import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:procura_online/utils/prefs.dart';

class SplashScreen extends StatelessWidget {
  void init(BuildContext context) async {
    await precachePicture(
        SvgPicture.asset('assets/images/by_my_car.svg').pictureProvider,
        context);
    await precachePicture(
        SvgPicture.asset('assets/images/not_found_towing.svg').pictureProvider,
        context);
    await precachePicture(
        SvgPicture.asset('assets/images/success_ad.svg').pictureProvider,
        context);

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
    init(context);
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
