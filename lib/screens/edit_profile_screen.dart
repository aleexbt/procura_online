import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:procura_online/widgets/text_input.dart';

class EditProfileScreen extends StatelessWidget {
  final UserControllerOld _userController = Get.find();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit profile'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: Colors.black),
            onPressed: () {
              FocusScope.of(context).unfocus();
              _userController.setUser(name: _name.text, email: _email.text);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your name',
              style: TextStyle(color: Colors.blue),
            ),
            SizedBox(height: 5),
            Obx(() => CustomTextInput(
                  controller: _name..text = _userController.userData.user?.name,
                  fillColor: Colors.grey[200],
                  hintText: _userController.name,
                  textCapitalization: TextCapitalization.words,
                )),
            SizedBox(height: 10),
            Text(
              'Enter your email',
              style: TextStyle(color: Colors.blue),
            ),
            SizedBox(height: 5),
            Obx(() => CustomTextInput(
                  controller: _email..text = _userController.userData.user?.email,
                  fillColor: Colors.grey[200],
                  hintText: _userController.email,
                  keyboardType: TextInputType.emailAddress,
                )),
          ],
        ),
      ),
    );
  }
}
