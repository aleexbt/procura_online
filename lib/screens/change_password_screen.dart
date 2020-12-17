import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/widgets/text_input.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change password'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: Colors.black),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your current password',
              style: TextStyle(color: Colors.blue),
            ),
            SizedBox(height: 5),
            CustomTextInput(
              fillColor: Colors.grey[200],
              hintText: 'Current password',
              obscureText: true,
            ),
            SizedBox(height: 10),
            Text(
              'Enter your new password',
              style: TextStyle(color: Colors.blue),
            ),
            SizedBox(height: 5),
            CustomTextInput(
              fillColor: Colors.grey[200],
              hintText: 'New password',
              obscureText: true,
            ),
            SizedBox(height: 10),
            Text(
              'Confirm your new password',
              style: TextStyle(color: Colors.blue),
            ),
            SizedBox(height: 5),
            CustomTextInput(
              fillColor: Colors.grey[200],
              hintText: 'Confirm password',
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }
}
