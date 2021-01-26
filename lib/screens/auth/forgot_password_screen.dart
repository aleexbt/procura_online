import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:procura_online/widgets/large_button.dart';
import 'package:procura_online/widgets/text_input.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final UserController _userController = Get.find();
  final TextEditingController _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.blue,
    ));
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(
          'Forgot password',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Obx(
          () => ModalProgressHUD(
              inAsyncCall: _userController.isLoading,
              child: Container(
                constraints: BoxConstraints(
                  minHeight: Get.size.height,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue, Colors.blue[900]],
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50, left: 80, right: 80, bottom: 50),
                          child: SvgPicture.asset('assets/images/logo_branco.svg', width: 100),
                        ),
                        Column(
                          children: [
                            Form(
                              key: _formKey,
                              child: CustomTextInput(
                                controller: _email,
                                prefixIcon: Icon(
                                  Icons.mail,
                                  color: Colors.white,
                                ),
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.white),
                                keyboardType: TextInputType.emailAddress,
                                errorBorderColor: Colors.white54,
                                errorTextColor: Colors.white,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your email address';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: [
                            LargeButton(
                              text: 'Reset password',
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  FocusScope.of(context).unfocus();
                                  _userController.passwordReset(_email.text);
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
