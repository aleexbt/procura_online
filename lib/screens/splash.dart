import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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
    // Get.put(ProductRepository());
    // Get.put(UserRepository());
    // Get.put(UserController());
    // Get.put(SearchController());
    // Get.put(HomeController());
    // Get.put(UserRepository());

    // Get.lazyPut(() => ProductRepository());
    // Get.lazyPut(() => UserRepository());
    // Get.lazyPut(() => UserController());
    // Get.lazyPut(() => HomeController());
    // Get.lazyPut(() => SearchController());
    //
    // Get.lazyPut(() => OrdersRepository());
    // Get.lazyPut(() => OrdersController());

    await Future.delayed(Duration(seconds: 2));
    Get.offAllNamed('/app');
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.blue,
    ));
    return Scaffold(
      body: Container(
        constraints: BoxConstraints(
          minHeight: Get.size.height,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.blue],
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
            width: 200,
          ),
        ),
      ),
    );
  }
}
