import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:procura_online/screens/auth/user_controller.dart';
import 'package:procura_online/widgets/text_input.dart';

class ChangePasswordScreen extends StatelessWidget {
  final UserController _userController = Get.find();
  final _formKey = GlobalKey<FormState>();
  // final _formKey = GlobalKey<FormBuilderState>();
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
                      'Enter your current password',
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
                          return 'Your current password cannot be empty.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Enter your new password',
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
                            return 'Your new password cannot be empty.';
                          }
                          if (value.length < 8) {
                            return 'Your password must have at least 8 characters.';
                          }
                          return null;
                        }),
                    SizedBox(height: 10),
                    Text(
                      'Confirm your new password',
                      style: TextStyle(color: Colors.blue),
                    ),
                    SizedBox(height: 5),
                    CustomTextInput(
                        controller: _confirmPassword,
                        fillColor: Colors.grey[200],
                        hintText: 'Confirm password',
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Your confirmation password cannot be empty.';
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
