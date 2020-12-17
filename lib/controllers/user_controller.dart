import 'package:get/get.dart';

class UserController extends GetxController {
  @override
  onInit() {
    print('INICIADO_USER_CONTROLLER');
  }

  RxBool _loggedIn = false.obs;
  RxString _name = 'Alex'.obs;
  RxString _email = 'alex@example.com'.obs;

  bool get loggedIn => _loggedIn.value;
  String get name => _name.value;
  String get email => _email.value;

  void setUser({bool loggedIn, String name, String email}) {
    _loggedIn.value = loggedIn;
    _name.value = name;
    _email.value = email;
  }
}
