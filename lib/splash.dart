import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:procura_online/utils/prefs.dart';

class SplashScreen extends StatelessWidget {
  void init() async {
    await Future.delayed(Duration(seconds: 2));
    bool showIntro = Prefs.getBool('showIntro') ?? true;
    if (showIntro) {
      Get.offNamed('/intro');
    } else {
      Get.offNamed('/app');
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.blue,
    ));
    init();
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
