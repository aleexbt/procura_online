import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/utils/colors.dart';
import 'package:procura_online/widgets/large_button.dart';
import 'package:procura_online/widgets/text_input.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 120, left: 80, right: 80, bottom: 40),
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 200,
                      ),
                    ),
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Column(
                  children: [
                    CustomTextInput(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    CustomTextInput(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    CustomTextInput(
                      hintText: 'Confirm password',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Column(
                  children: [
                    LargeButton(
                      text: 'Sign Up',
                      onPressed: () => Get.back(),
                    ),
                    SizedBox(height: 25),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => Get.back(),
                      child: Text('Back to login', style: kSmallText),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
