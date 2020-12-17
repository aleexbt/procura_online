import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/screens/login.dart';
import 'package:procura_online/screens/register_screen.dart';

class TestsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Tests Screen'),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            FlatButton(onPressed: () => Get.to(LoginScreen()), child: Text('Show Login Screen')),
            SizedBox(height: 10),
            FlatButton(onPressed: () => Get.to(RegisterScreen()), child: Text('Show Register Screen')),
          ],
        ),
      )),
    );
  }
}
