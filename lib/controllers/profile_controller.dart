import 'package:get/get.dart';
import 'package:procura_online/controllers/user_controller.dart';

class ProfileController extends GetxController {
  final UserController _userController = Get.find();

  RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;
}
