import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:procura_online/models/chat_model.dart';
import 'package:procura_online/models/chats_model.dart';
import 'package:procura_online/models/user_model.dart';
import 'package:procura_online/repositories/chat_repository.dart';
import 'package:procura_online/services/pusher_service.dart';

class ChatController extends GetxController with WidgetsBindingObserver {
  ChatRepository _chatRepository = Get.find();
  PusherService pusherService;

  @override
  void onInit() {
    pusherService = PusherService();
    subscribeMessages();
    findAll();
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  void onClose() {
    pusherService.unbindEvent('App\\Events\\ConversationUpdateEvent');
    pusherService.unSubscribePusher('App\\Events\\ConversationUpdateEvent');
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  void subscribeMessages() async {
    print('CALL_SUBSCRIBE');
    Box<User> box = await Hive.openBox<User>('userData') ?? null;
    int userId = box.values?.first?.id ?? null;
    if (userId != null) {
      pusherService.firePusher('private-update-conversation.$userId', 'App\\Events\\ConversationUpdateEvent');
      pusherService.firePusher('private-conversation-up', 'App\\Events\\ConversationUpdateEvent');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    if (state == AppLifecycleState.resumed) {
      subscribeMessages();
    } else if (state == AppLifecycleState.paused) {
      try {
        pusherService.unbindEvent('App\\Events\\ConversationUpdateEvent');
        pusherService.unSubscribePusher('App\\Events\\ConversationUpdateEvent');
      } catch (err) {
        // unbind or unsubscribe error
      }
    }
  }

  RxBool _isLoading = false.obs;
  RxBool _isLoadingMore = false.obs;
  RxBool _hasError = false.obs;
  RxBool _loadingMoreError = false.obs;
  RxInt _page = 1.obs;
  Rx<Chats> _chats = Chats().obs;

  bool get isLoading => _isLoading.value;
  bool get isLoadingMore => _isLoadingMore.value;
  bool get hasError => _hasError.value;
  bool get loadingMoreError => _loadingMoreError.value;
  int get page => _page.value;
  Chats get chats => _chats.value;
  bool get isLastPage => _page.value == _chats.value.meta.lastPage;
  List<Chat> filteredConversations;

  void findAll({skipLoading = false}) async {
    _isLoading.value = !skipLoading;
    _hasError.value = false;
    _page.value = 1;
    try {
      Chats response = await _chatRepository.findAll();
      _chats.value = response;
      filteredConversations = List.from(response.chats);
    } on DioError catch (err) {
      print(err);
      _hasError.value = true;
    } catch (err) {
      print(err);
      _hasError.value = true;
    } finally {
      _isLoading.value = false;
    }
  }

  void nextPage() async {
    _isLoadingMore.value = true;
    _loadingMoreError.value = false;
    _page.value = _page.value + 1;
    try {
      Chats response = await _chatRepository.findAll(page: _page.value);
      if (response != null) {
        _chats.update((val) {
          val.chats.addAll(response.chats);
        });
        filteredConversations.addAll(response.chats);
      }
    } on DioError catch (err) {
      print(err);
      _loadingMoreError.value = true;
      Get.rawSnackbar(
          message: 'Ops, erro ao carregar mais items.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
    } catch (err) {
      print(err);
      _loadingMoreError.value = true;
      Get.rawSnackbar(
          message: 'Ops, erro ao carregar mais items.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
    } finally {
      _isLoadingMore.value = false;
    }
  }

  void filterResults(String term) {
    List<Chat> filtered = filteredConversations
        .where(
          (conversation) =>
              conversation.order.userInfo.name.toLowerCase().contains(term.toLowerCase()) ||
              conversation.latestMessage.message.toLowerCase().contains(term.toLowerCase()),
        )
        .toList();

    _chats.value.chats = filtered;
    _chats.refresh();
  }

  void updateMessages(Map<String, dynamic> data) async {
    Chat conversation = Chat.fromJson(data);
    _chats.update((val) {
      val.chats.removeWhere((chat) => chat.id == conversation.id);
      val.chats.insert(0, conversation);
      // val.chats.firstWhere((chat) => chat.id == conversation.id).latestMessage = conversation.latestMessage;
    });
  }
}
