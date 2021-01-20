import 'package:get/get.dart';
import 'package:procura_online/controllers/chat_controller.dart';
import 'package:procura_online/controllers/conversation_controller.dart';

class ConversationBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ChatController());
    Get.put(ConversationController());
  }
}
