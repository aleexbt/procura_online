import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProtectedRoute extends StatefulWidget {
  @override
  _ProtectedRouteState createState() => _ProtectedRouteState();
}

class _ProtectedRouteState extends State<ProtectedRoute> {
  @override
  void initState() {
    // Get.toNamed('/auth/login');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('You need to be logged in to view this page.'),
          RaisedButton(
            onPressed: () => Get.toNamed('/auth/login'),
            child: Text('Go to login'),
          )
        ],
      ),
    );
  }
}
