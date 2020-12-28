import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:procura_online/models/chat_model.dart';
import 'package:procura_online/repositories/chat_repository.dart';

class ChatController extends GetxController {
  ChatRepository _repository = Get.put(ChatRepository(), permanent: true);

  @override
  onInit() {
    findAll();
    super.onInit();
  }

  RxBool _isLoading = false.obs;
  RxBool _isLoadingMore = false.obs;
  RxBool _hasError = false.obs;
  RxInt _page = 1.obs;
  Rx<ChatModel> _chat = ChatModel().obs;

  bool get isLoading => _isLoading.value;
  bool get isLoadingMore => _isLoadingMore.value;
  bool get hasError => _hasError.value;
  int get page => _page.value;
  ChatModel get chat => _chat.value;
  List<Conversation> get conversations => _chat.value.data;
  int get totalConversations => _chat.value.data?.length ?? 0;
  bool get isLastPage => false;
  List<Conversation> filteredConversations;

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
