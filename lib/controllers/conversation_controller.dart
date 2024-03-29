import 'dart:io';

import 'package:diacritic/diacritic.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:procura_online/controllers/chat_controller.dart';
import 'package:procura_online/models/conversation_model.dart';
import 'package:procura_online/models/message_model.dart';
import 'package:procura_online/models/upload_media_model.dart';
import 'package:procura_online/repositories/chat_repository.dart';
import 'package:procura_online/services/pusher_service.dart';

class ConversationController extends GetxController with WidgetsBindingObserver {
  final String chatId = Get.parameters['id'];
  final bool skipFetch = Get.arguments != null ? Get.arguments['skipFetch'] ?? false : false;
  final ChatRepository _chatRepository = Get.find();
  final ChatController _chatController = Get.find();
  PusherService pusherService;

  @override
  void onInit() {
    pusherService = PusherService();
    restoreConversation();
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  void onClose() {
    pusherService.unbindEvent('App\\Events\\ConversationEvent');
    pusherService.unSubscribePusher('App\\Events\\ConversationEvent');
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      pusherService.firePusher('private-conversation.$chatId', 'App\\Events\\ConversationEvent');
      backgroundUpdateMessages();
    } else if (state == AppLifecycleState.paused) {
      pusherService.unbindEvent('App\\Events\\ConversationEvent');
      pusherService.unSubscribePusher('App\\Events\\ConversationEvent');
    }
  }

  RxBool _isLoading = true.obs;
  RxBool _hasError = false.obs;
  RxBool _isReplying = false.obs;
  RxBool _replyingError = false.obs;
  RxBool _isDeleting = false.obs;
  RxBool _deletingError = false.obs;

  RxList<File> images = List<File>.empty(growable: true).obs;
  RxList<String> imagesUrl = List<String>.empty(growable: true).obs;

  RxString currentUploadImage = ''.obs;
  RxDouble uploadImageProgress = 0.0.obs;
  RxBool _isUploadingImage = false.obs;
  Rx<Conversation> _conversation = Conversation().obs;
  List<Message> filteredMessages;

  bool get isLoading => _isLoading.value;
  bool get hasError => _hasError.value;
  bool get isReplying => _isReplying.value;
  bool get replyingError => _replyingError.value;
  bool get isDeleting => _isDeleting.value;
  bool get deletingError => _deletingError.value;
  bool get isUploadingImage => _isUploadingImage.value;
  Conversation get conversation => _conversation.value;

  Rx<TextEditingController> messageInput = TextEditingController().obs;

  void setImages(List<File> value) => images.addAll(value);

  void removeImage(File value) {
    images.removeWhere((img) => img == value);
  }

  void setImagesUrl(String value) => imagesUrl.add(value);

  void restoreConversation() async {
    Box<Conversation> box = await Hive.openBox<Conversation>('conversations') ?? null;
    if (box != null && box.get(chatId) != null) {
      _conversation.value = box.get(chatId);
      _isLoading.value = false;
      findOne(skipLoading: true);
    } else {
      findOne();
    }
  }

  findOne({skipLoading = false}) async {
    _isLoading.value = !skipLoading;
    _hasError.value = false;
    try {
      Conversation response = await _chatRepository.findOne(chatId);
      _conversation.value = response;
      filteredMessages = List.from(response.messages);
      Box<Conversation> box = await Hive.openBox<Conversation>('conversations');
      box.put(chatId, response);
      bool seen = _chatController.chats.chats
              .firstWhere((element) => element.id.toString() == chatId, orElse: () => null)
              ?.seen ??
          false;
      if (!seen) {
        _chatRepository.markMessageAsRead(chatId);
        _chatController.findAll(skipLoading: true);
      }
    } on DioError catch (err) {
      _hasError.value = true;
      print(err);
    } catch (err) {
      _hasError.value = true;
      print('CONVERSATION_FATAL_ERROR: $err');
    } finally {
      _isLoading.value = false;
      if (skipFetch) {
        await Future.delayed(Duration(seconds: 5));
        pusherService.firePusher('private-conversation.$chatId', 'App\\Events\\ConversationEvent');
      } else {
        pusherService.firePusher('private-conversation.$chatId', 'App\\Events\\ConversationEvent');
      }
    }
  }

  void replyMessage({String message, String orderId, String chatId, List<String> photos}) async {
    if (message.isBlank && photos.isBlank) {
      return;
    }
    _isReplying.value = true;
    _replyingError.value = false;
    try {
      Map<String, dynamic> data = {
        "message": message,
        "order_id": orderId,
        "conversation_id": chatId ?? "",
        "attachments": photos
      };
      await _chatRepository.replyMessage(data);
    } on DioError catch (err) {
      _replyingError.value = true;
      Get.rawSnackbar(message: 'Ops, ocorreu um erro.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
    } catch (err) {
      _replyingError.value = true;
      print(err);
      Get.rawSnackbar(message: 'Ops, ocorreu um erro.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
    } finally {
      messageInput.value.clear();
      images.clear();
      imagesUrl.clear();
      messageInput.value.value = TextEditingValue(selection: TextSelection.collapsed(offset: 0));
      _isReplying.value = false;
      _chatController.findAll();
    }
  }

  void filterMessages(String term) {
    try {
      String keyword = removeDiacritics(term.toLowerCase());
      String message(String msg) => msg != null ? removeDiacritics(msg.toLowerCase()) : '';
      List<Message> filtered = filteredMessages.where((msg) => message(msg.message).contains(keyword)).toList();

      _conversation.update((val) {
        val.messages = filtered;
      });
    } catch (e) {
      print('FILTER_MESSAGES_ERROR: $e');
    }
  }

  void muteConversationToggle() async {
    try {
      int status = _conversation.value.mute;
      if (status == 0) {
        _conversation.update((val) {
          val.mute = 1;
        });
        _chatRepository.muteConversation(chatId);
      } else {
        _conversation.update((val) {
          val.mute = 0;
        });
        _chatRepository.muteConversation(chatId);
      }
    } on DioError catch (err) {
      print(err);
    } finally {
      Get.back();
    }
  }

  void deleteConversation() async {
    _isDeleting.value = true;
    _deletingError.value = false;
    try {
      Get.back();
      await _chatRepository.deleteConversation(chatId);
      _chatController.findAll();
      Get.back(closeOverlays: true);
    } on DioError catch (err) {
      _deletingError.value = true;
      Get.rawSnackbar(message: 'Ops, ocorreu um erro.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
    } catch (err) {
      _deletingError.value = true;
      Get.rawSnackbar(message: 'Ops, ocorreu um erro.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
    } finally {
      _isDeleting.value = false;
    }
  }

  void backgroundUpdateMessages() async {
    try {
      Conversation response = await _chatRepository.findOne(chatId);
      _conversation.value = response;
      Box<Conversation> box = await Hive.openBox<Conversation>('conversations');
      box.put(chatId, response);
    } on DioError catch (err) {
      print(err);
    } catch (err) {
      print(err);
    } finally {
      _chatController.findAll();
    }
  }

  void addMessage(Map<String, dynamic> data) async {
    try {
      _conversation.update((val) {
        val.messages.add(Message.fromJson(data['message']));
      });
      _chatRepository.markMessageAsRead(chatId);
    } catch (e) {
      print('ADD_MESSAGE_ERROR');
    }
  }

  Future<UploadMedia> mediaUpload(File photo) async {
    uploadImageProgress.value = 0.0;
    _isUploadingImage.value = true;
    var _result;
    try {
      UploadMedia response = await _chatRepository.mediaUpload(photo);
      _result = response;
    } on DioError catch (err) {
      print(err);
      Get.rawSnackbar(
          message: 'Ops, erro ao enviar imagem.', backgroundColor: Colors.red, duration: Duration(seconds: 5));
    } catch (err) {
      print(err);
      Get.rawSnackbar(
          message: 'Ops, erro ao enviar imagem.', backgroundColor: Colors.red, duration: Duration(seconds: 5));
    } finally {
      _isUploadingImage.value = false;
      uploadImageProgress.value = 0.0;
      currentUploadImage.value = '';
    }
    return _result;
  }
}
