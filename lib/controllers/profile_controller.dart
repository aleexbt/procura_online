import 'package:get/get.dart';

class ProfileController extends GetxController {
  // final UserController _userController = Get.find();

  RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;
}
