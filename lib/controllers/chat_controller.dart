import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/models/chat_model.dart';
import 'package:procura_online/models/chats_model.dart';
import 'package:procura_online/repositories/chat_repository.dart';

class ChatController extends GetxController {
  ChatRepository _chatRepository = Get.find();

  @override
  onInit() {
    findAll();
    super.onInit();
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
          message: 'Ops, error getting more items.',
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3));
    } catch (err) {
      print(err);
      _loadingMoreError.value = true;
      Get.rawSnackbar(
          message: 'Ops, error getting more items.',
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3));
    } finally {
      _isLoadingMore.value = false;
    }
  }

  void filterResults(String term) {
    List<Chat> filtered = filteredConversations
        .where(
          (conversation) =>
              conversation.order.userInfo.name
                  .toLowerCase()
                  .contains(term.toLowerCase()) ||
              conversation.latestMessage.message
                  .toLowerCase()
                  .contains(term.toLowerCase()),
        )
        .toList();

    _chats.value.chats = filtered;
    _chats.refresh();
  }
}
