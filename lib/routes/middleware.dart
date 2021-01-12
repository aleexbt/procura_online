import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/controllers/user_controller.dart';

class RedirectMiddleware extends GetMiddleware {
  final UserController _userController = Get.find();

  @override
  RouteSettings redirect(String route) {
    return !_userController.isLoggedIn ? RouteSettings(name: '/auth/login') : null;
  }
}

// import 'package:get/get.dart';
// import 'package:procura_online/controllers/user_controller.dart';
// import 'package:procura_online/routes/routes.dart';
// import 'package:procura_online/screens/auth/login_screen.dart';
//
// GetPage redirect() {
//   final user = Get.find<UserController>();
//   return !user.isLoggedIn ? null : GetPage(name: Routers.login, page: () => LoginScreen());
// }
