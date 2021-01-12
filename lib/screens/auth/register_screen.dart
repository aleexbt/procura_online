import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:procura_online/utils/colors.dart';
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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.blue,
    ));

    return Scaffold(
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
              child: Stack(children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 50, left: 80, right: 80, bottom: 40),
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
                            SizedBox(height: 40),
                            CustomTextInput(
                              controller: _name,
                              hintText: 'Full name',
                              hintStyle: TextStyle(color: Colors.white),
                              textCapitalization: TextCapitalization.sentences,
                            ),
                            SizedBox(height: 10),
                            CustomTextInput(
                              controller: _email,
                              hintText: 'Email',
                              hintStyle: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(height: 10),
                            CustomTextInput(
                              controller: _phone,
                              hintText: 'Phone',
                              hintStyle: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.phone,
                            ),
                            SizedBox(height: 10),
                            CustomTextInput(
                              controller: _address,
                              hintText: 'Address',
                              hintStyle: TextStyle(color: Colors.white),
                              textCapitalization: TextCapitalization.sentences,
                            ),
                            SizedBox(height: 10),
                            CustomTextInput(
                              controller: _postcode,
                              hintText: 'Postcode',
                              hintStyle: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 10),
                            CustomTextInput(
                              controller: _password,
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Colors.white),
                              obscureText: true,
                            ),
                          ],
                        ),
                        SizedBox(height: 50),
                        Column(
                          children: [
                            LargeButton(
                              text: 'Sign Up',
                              onPressed: () => _userController.signUp(
                                name: _name.text,
                                email: _email.text,
                                phone: _phone.text,
                                address: _address.text,
                                postcode: _postcode.text,
                                password: _password.text,
                              ),
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
                Padding(
                  padding: EdgeInsets.only(left: 5, top: 5),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Get.back(),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
