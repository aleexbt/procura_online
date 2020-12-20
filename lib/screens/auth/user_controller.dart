import 'package:get/get.dart';
import 'package:procura_online/models/user_model.dart';
import 'package:procura_online/repositories/user_repository.dart';

class UserController extends GetxController with StateMixin<UserModel> {
  UserRepository _repository = Get.find();

  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  void signIn({String email, String password}) {
    _isLoading.value = true;
    _repository.signIn(email: email, password: password).then((res) {
      change(res, status: RxStatus.success());
      _isLoading.value = false;
    }, onError: (err) {
      _isLoading.value = false;
      change(null, status: RxStatus.error('Ops, something went wrong.'));
    });
  }

  void signUp() {
    _isLoading.value = true;
    _repository.signUp().then((res) {
      change(res, status: RxStatus.success());
      _isLoading.value = false;
    }, onError: (err) {
      _isLoading.value = false;
      change(null, status: RxStatus.error('Ops, something went wrong.'));
    });
  }
}
