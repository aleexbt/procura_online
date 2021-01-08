import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/controllers/chat_controller.dart';
import 'package:procura_online/models/messages_model.dart';
import 'package:procura_online/repositories/chat_repository.dart';

class ConversationController extends GetxController {
  final String chatId = Get.parameters['id'];
  final ChatRepository _chatRepository = Get.find();
  final ChatController _chatController = Get.find();

  @override
  void onInit() {
    findOne();
    super.onInit();
  }

  RxBool _isLoading = false.obs;
  RxBool _hasError = false.obs;
  RxBool _isReplying = false.obs;
  RxBool _replyingError = false.obs;
  RxBool _isDeleting = false.obs;
  RxBool _deletingError = false.obs;
  Rx<Messages> _messages = Messages().obs;

  bool get isLoading => _isLoading.value;
  bool get hasError => _hasError.value;
  bool get isReplying => _isReplying.value;
  bool get replyingError => _replyingError.value;
  bool get isDeleting => _isDeleting.value;
  bool get deletingError => _deletingError.value;
  Messages get messages => _messages.value;

  Rx<TextEditingController> _messageInput = TextEditingController().obs;
  TextEditingController get messageInput => _messageInput.value;

  findOne() async {
    _isLoading.value = true;
    _hasError.value = false;
    try {
      Messages response = await _chatRepository.findOne(chatId);
      _chatRepository.markMessageAsRead(chatId);
      _messages.value = response;
    } on DioError catch (err) {
      _hasError.value = true;
      print(err);
    } catch (err) {
      _hasError.value = true;
      print(err);
    } finally {
      _isLoading.value = false;
    }
  }

  void replyMessage({String message, String orderId, String chatId}) async {
    if (message.isNullOrBlank) {
      return;
    }
    _isReplying.value = true;
    _replyingError.value = false;
    try {
      Map<String, dynamic> data = {"message": message, "order_id": orderId, "conversation_id": chatId ?? ""};
      await _chatRepository.replyMessage(data);
      updateMessages();
    } on DioError catch (err) {
      _replyingError.value = true;
      Get.rawSnackbar(
          message: 'Ops, something went wrong.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
    } catch (err) {
      _replyingError.value = true;
      print(err);
      Get.rawSnackbar(
          message: 'Ops, something went wrong.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
    } finally {
      _isReplying.value = false;
    }
  }

  void muteConversation() async {
    try {
      _chatRepository.muteConversation(chatId);
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
      await _chatRepository.deleteConversation(chatId);
      _chatController.findAll();
      Get.back(closeOverlays: true);
    } on DioError catch (err) {
      _deletingError.value = true;
      Get.rawSnackbar(
          message: 'Ops, something went wrong.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
    } catch (err) {
      _deletingError.value = true;
      Get.rawSnackbar(
          message: 'Ops, something went wrong.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
    } finally {
      _isDeleting.value = false;
    }
  }

  void updateMessages() async {
    try {
      Messages response = await _chatRepository.findOne(chatId);
      _messages.update((val) {
        val.messages = response.messages;
      });
    } on DioError catch (err) {
      print(err);
    } finally {
      _messageInput.value.clear();
      _isReplying.value = false;
      _chatController.findAll();
    }
  }
}
