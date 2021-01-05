import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/models/chat_model.dart';
import 'package:procura_online/models/conversation_model.dart';
import 'package:procura_online/repositories/chat_repository.dart';

class ChatController extends GetxController {
  ChatRepository _repository = Get.put(ChatRepository(), permanent: true);

  @override
  onInit() {
    findAll();
    super.onInit();
  }

  Rx<TextEditingController> _messageInput = TextEditingController().obs;
  RxBool _isLoading = false.obs;
  RxBool _isLoadingMsgs = false.obs;
  RxBool _isReplyingMsg = false.obs;
  RxBool _isLoadingMore = false.obs;
  RxBool _isDeletingChat = false.obs;
  RxBool _hasError = false.obs;
  RxInt _page = 1.obs;
  Rx<ChatModel> _chat = ChatModel().obs;

  TextEditingController get messageInput => _messageInput.value;
  bool get isLoading => _isLoading.value;
  bool get isLoadingMsgs => _isLoadingMsgs.value;
  bool get isReplyingMsg => _isReplyingMsg.value;
  bool get isLoadingMore => _isLoadingMore.value;
  bool get isDeletingChat => _isDeletingChat.value;
  bool get hasError => _hasError.value;
  int get page => _page.value;
  ChatModel get chat => _chat.value;
  List<Conversation> get conversations => _chat.value.data;
  int get totalConversations => _chat.value.data?.length ?? 0;
  bool get isLastPage => false;
  List<Conversation> filteredConversations;

  RxList<Message> _messages = List<Message>().obs;
  List<Message> get messages => _messages;

  void findAll() async {
    _isLoading.value = true;
    _hasError.value = false;
    _page.value = 1;
    try {
      ChatModel response = await _repository.findAll();
      _chat.value = response;
      filteredConversations = List.from(response.data);
    } on DioError catch (err) {
      print(err);
      _hasError.value = true;
    } finally {
      _isLoading.value = false;
    }
  }

  void findOne(String conversationId) async {
    _isLoadingMsgs.value = true;
    _hasError.value = false;
    try {
      _messages.clear();
      var response = await _repository.findOne(conversationId);
      Map<String, dynamic> messagesMap = Map<String, dynamic>.from(response);

      messagesMap.forEach((key, value) {
        value.forEach((message) {
          _messages.add(Message.fromJson(message));
        });
      });
      _messages.refresh();
    } on DioError catch (err) {
      _hasError.value = true;
      print(err);
    } finally {
      _isLoadingMsgs.value = false;
    }
  }

  void replyMessage({String message, String orderId, String conversationId}) async {
    if (message.isNullOrBlank) {
      return;
    }
    _isReplyingMsg.value = true;
    try {
      Map<String, dynamic> data = {"message": message, "order_id": orderId, "conversation_id": conversationId ?? ""};
      await _repository.replyMessage(data);
      updateMessages(conversationId);
    } on DioError catch (err) {
      _isReplyingMsg.value = false;
      print(err);
    }
  }

  void muteConversation(String conversationId) async {
    try {
      _repository.muteConversation(conversationId);
    } on DioError catch (err) {
      print(err);
    } finally {
      Get.back();
    }
  }

  void deleteConversation(String conversationId) async {
    _isDeletingChat.value = true;
    try {
      var response = await _repository.deleteConversation(conversationId);
      print(response);
    } on DioError catch (err) {
      print(err);
    } finally {
      findAll();
      _isDeletingChat.value = false;
      Get.back(closeOverlays: true);
    }
  }

  void updateMessages(String conversationId) async {
    try {
      var response = await _repository.findOne(conversationId);
      Map<String, dynamic> messagesMap = Map<String, dynamic>.from(response);
      _messages.clear();
      messagesMap.forEach((key, value) {
        value.forEach((message) {
          _messages.add(Message.fromJson(message));
        });
      });
      _messages.refresh();
    } on DioError catch (err) {
      print(err);
    } finally {
      _messageInput.value.clear();
      _isReplyingMsg.value = false;
      findAll();
    }
  }

  void nextPage() async {
    _isLoadingMore.value = true;
    _page.value = _page.value + 1;
    ChatModel response = await _repository.findAll(page: _page.value);

    if (response != null) {
      _chat.update((val) {
        val.data.addAll(response.data);
      });
      filteredConversations.addAll(response.data);
    }
    _isLoadingMore.value = false;
  }

  void filterResults(String term) {
    List<Conversation> filtered = filteredConversations
        .where(
          (conversation) =>
              conversation.userone.name.toLowerCase().contains(term.toLowerCase()) ||
              conversation.latestMessage.message.toLowerCase().contains(term.toLowerCase()),
        )
        .toList();

    _chat.value.data = filtered;
    _chat.refresh();
  }
}
