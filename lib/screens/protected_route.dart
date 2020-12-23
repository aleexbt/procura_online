import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:procura_online/utils/navigation_helper.dart';

class ProtectedRoute extends StatefulWidget {
  @override
  _ProtectedRouteState createState() => _ProtectedRouteState();
}

class _ProtectedRouteState extends State<ProtectedRoute> {
  PageController _pageController = NavKey.pageController;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('You need to be logged in to view this page.'),
          FlatButton(
            onPressed: () => Get.toNamed('/auth/login'),
            child: Text(
              'Login',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
