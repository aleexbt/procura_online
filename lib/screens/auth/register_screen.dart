import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:procura_online/widgets/large_button.dart';
import 'package:procura_online/widgets/text_input.dart';

class RegisterScreen extends StatelessWidget {
  final UserController _userController = Get.find();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _postcode = TextEditingController();
  final TextEditingController _password = TextEditingController();
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
          'Sign up',
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
                  padding: const EdgeInsets.all(35.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 50, left: 80, right: 80, bottom: 40),
                              child: SvgPicture.asset('assets/images/logo_branco.svg', width: 100),
                            ),
                            CustomTextInput(
                              controller: _name,
                              hintText: 'Full name',
                              hintStyle: TextStyle(color: Colors.white),
                              textCapitalization: TextCapitalization.sentences,
                              errorBorderColor: Colors.white54,
                              errorTextColor: Colors.white,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            CustomTextInput(
                              controller: _email,
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
                            SizedBox(height: 20),
                            CustomTextInput(
                              controller: _phone,
                              hintText: 'Phone',
                              hintStyle: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.phone,
                              errorBorderColor: Colors.white54,
                              errorTextColor: Colors.white,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            CustomTextInput(
                              controller: _address,
                              hintText: 'Address',
                              hintStyle: TextStyle(color: Colors.white),
                              textCapitalization: TextCapitalization.sentences,
                              errorBorderColor: Colors.white54,
                              errorTextColor: Colors.white,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your address';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            CustomTextInput(
                              controller: _postcode,
                              hintText: 'Postcode',
                              hintStyle: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.number,
                              errorBorderColor: Colors.white54,
                              errorTextColor: Colors.white,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your postcode';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            CustomTextInput(
                              controller: _password,
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Colors.white),
                              obscureText: true,
                              errorBorderColor: Colors.white54,
                              errorTextColor: Colors.white,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter a password';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Column(
                        children: [
                          LargeButton(
                            text: 'Sign Up',
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _userController.signUp(
                                  name: _name.text,
                                  email: _email.text,
                                  phone: _phone.text,
                                  address: _address.text,
                                  postcode: _postcode.text,
                                  password: _password.text,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
