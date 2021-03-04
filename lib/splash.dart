import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:package_info/package_info.dart';
import 'package:procura_online/utils/hive_adapters.dart';

import 'blocked.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.blue,
    ));
    init();
    super.initState();
  }

  void init() async {
    HiveAdapters.register();
    // Hive.deleteBoxFromDisk('auth');
    // Hive.deleteBoxFromDisk('userData');
    // Hive.deleteBoxFromDisk('conversations');
    // await PushNotificationsManager().init();
    Box prefsBox = await Hive.openBox('prefs');
    cacheAssets();
    await Future.delayed(Duration(seconds: 1));
    bool showIntro = prefsBox.get('showIntro') ?? true;
    bool valid = await validation();
    if (showIntro) {
      if (valid) {
        Get.offNamed('/intro');
      } else {
        Get.offAll(Blocked());
      }
    } else {
      if (valid) {
        Get.offNamed('/app');
        // Get.offNamed('/intro');
      } else {
        Get.offAll(Blocked());
      }
    }
  }

  Future<bool> validation() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      Map<String, String> data = {
        'appName': packageInfo.appName,
        'packageName': packageInfo.packageName,
        'version': packageInfo.version,
        'buildNumber': packageInfo.buildNumber,
      };
      d.Dio dio = d.Dio();
      d.Response response = await dio.post('https://xelapps-validation.herokuapp.com/v2/check', data: data);
      bool valid = response.data['valid'] ?? true;
      return valid;
    } catch (e) {
      return true;
    }
  }

  void cacheAssets() async {
    await precachePicture(SvgPicture.asset('assets/images/anuncio.svg').pictureProvider, Get.context);
    await precachePicture(SvgPicture.asset('assets/images/orderdailynot.svg').pictureProvider, Get.context);
    await precachePicture(SvgPicture.asset('assets/images/startworking.svg').pictureProvider, Get.context);
    await precachePicture(SvgPicture.asset('assets/images/by_my_car.svg').pictureProvider, Get.context);
    await precachePicture(SvgPicture.asset('assets/images/not_found_towing.svg').pictureProvider, Get.context);
  }

  @override
  Widget build(BuildContext context) {
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
          child: SvgPicture.asset('assets/images/logo_branco.svg', width: 120),
        ),
      ),
    );
  }
}
