import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:procura_online/controllers/search_controller.dart';
import 'package:procura_online/repositories/product_repository.dart';
import 'package:procura_online/repositories/user_repository.dart';
import 'package:procura_online/screens/auth/user_controller.dart';

import 'home/home_controller.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    Get.put(ProductRepository());
    Get.put(UserRepository());
    Get.put(UserController());
    Get.put(SearchController());
    Get.put(HomeController());
    // Get.put(DetailsController());

    Get.put(UserRepository());
    await Future.delayed(Duration(seconds: 2));
    Get.offAllNamed('/app');
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.blue,
    ));
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: 200,
        ),
      ),
    );
  }
}
