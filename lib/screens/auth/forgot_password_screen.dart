import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:procura_online/utils/colors.dart';
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
                child: Stack(
                  children: [
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
                                  padding: const EdgeInsets.only(
                                      top: 120,
                                      left: 80,
                                      right: 80,
                                      bottom: 40),
                                  child: SvgPicture.asset(
                                      'assets/images/logo_branco.svg',
                                      width: 100),
                                ),
                                Text(
                                  'Forgot password',
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
                                        return 'Your email address cannot be empty.';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 50),
                            Column(
                              children: [
                                LargeButton(
                                  text: 'Reset password',
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      FocusScope.of(context).unfocus();
                                      _userController
                                          .passwordReset(_email.text);
                                    }
                                  },
                                ),
                                SizedBox(height: 25),
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () => Get.back(),
                                  child:
                                      Text('Back to Login', style: kSmallText),
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
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
