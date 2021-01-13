import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:procura_online/widgets/text_input.dart';

class ChangePasswordScreen extends StatelessWidget {
  final UserController _userController = Get.find();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change password'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: Colors.black),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                FocusScope.of(context).unfocus();
                _userController.changePassword(
                  currentPass: _currentPassword.text,
                  newPass: _newPassword.text,
                  confirmPass: _confirmPassword.text,
                );
              }
            },
          ),
        ],
      ),
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: _userController.isLoading,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current password',
                      style: TextStyle(color: Colors.blue),
                    ),
                    SizedBox(height: 5),
                    CustomTextInput(
                      controller: _currentPassword,
                      fillColor: Colors.grey[200],
                      hintText: 'Current password',
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your current password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      'New password',
                      style: TextStyle(color: Colors.blue),
                    ),
                    SizedBox(height: 5),
                    CustomTextInput(
                        controller: _newPassword,
                        fillColor: Colors.grey[200],
                        hintText: 'New password',
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a new password';
                          }
                          if (value.length < 8) {
                            return 'Your new password must have at least 8 characters';
                          }
                          return null;
                        }),
                    SizedBox(height: 10),
                    Text(
                      'Confirm password',
                      style: TextStyle(color: Colors.blue),
                    ),
                    SizedBox(height: 5),
                    CustomTextInput(
                        controller: _confirmPassword,
                        fillColor: Colors.grey[200],
                        hintText: 'Confirm new password',
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please repeat your new password';
                          }
                          if (value != _newPassword.text) {
                            return 'Your passwords didn\'t match, please verify';
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
