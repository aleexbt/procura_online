import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/screens/auth/user_controller.dart';
import 'package:procura_online/widgets/text_input.dart';

class EditProfileScreen extends StatelessWidget {
  final UserController _userController = Get.find();

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
              _userController.updateUserData(
                  name: _name.text, email: _email.text);
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
                  controller: _name..text = _userController.userData?.name,
                  fillColor: Colors.grey[200],
                  hintText: _userController.userData?.name,
                  textCapitalization: TextCapitalization.sentences,
                )),
            SizedBox(height: 10),
            Text(
              'Enter your email',
              style: TextStyle(color: Colors.blue),
            ),
            SizedBox(height: 5),
            Obx(() => CustomTextInput(
                  controller: _email..text = _userController.userData?.email,
                  fillColor: Colors.grey[200],
                  hintText: _userController.userData?.email,
                  keyboardType: TextInputType.emailAddress,
                  validatorText: 'Por favor digite seu e-mail',
                )),
          ],
        ),
      ),
    );
  }
}
