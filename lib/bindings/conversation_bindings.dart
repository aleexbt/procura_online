import 'package:get/get.dart';
import 'package:procura_online/controllers/conversation_controller.dart';

class ConversationBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ConversationController());
  }
}
