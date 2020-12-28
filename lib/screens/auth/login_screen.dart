import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:procura_online/screens/auth/register_screen.dart';
import 'package:procura_online/utils/colors.dart';
import 'package:procura_online/widgets/large_button.dart';
import 'package:procura_online/widgets/text_input.dart';

class LoginScreen extends StatelessWidget {
  final UserController _userController = Get.find();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.blue,
    ));

    // GoogleSignIn _googleSignIn = GoogleSignIn(
    //   scopes: [
    //     'email',
    //     'https://www.googleapis.com/auth/userinfo.email',
    //     'https://www.googleapis.com/auth/userinfo.profile',
    //   ],
    // );
    //
    // Future<void> _handleSignInGoogle() async {
    //   try {
    //     await _googleSignIn.signIn();
    //   } catch (e) {
    //     print('login failed $e');
    //   }
    // }
    //
    // Future<void> _handleSignInFacebook() async {
    //   try {
    //     // by default the login method has the next permissions ['email','public_profile']
    //     AccessToken accessToken = await FacebookAuth.instance.login();
    //     print(accessToken.toJson());
    //     // get the user data
    //     final userData = await FacebookAuth.instance.getUserData();
    //     print(userData);
    //   } on FacebookAuthException catch (e) {
    //     switch (e.errorCode) {
    //       case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
    //         print("You have a previous login operation in progress");
    //         break;
    //       case FacebookAuthErrorCode.CANCELLED:
    //         print("login cancelled");
    //         break;
    //       case FacebookAuthErrorCode.FAILED:
    //         print("login failed ${e.message}");
    //         break;
    //     }
    //   }
    // }

    Future<bool> _onWillPop() async {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ));
      return true;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 50),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomTextInput(
                                controller: _emailController,
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
                              SizedBox(height: 10),
                              CustomTextInput(
                                controller: _passwordController,
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Colors.white),
                                obscureText: true,
                                errorBorderColor: Colors.white54,
                                errorTextColor: Colors.white,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Your password cannot be empty.';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () => Get.toNamed('/auth/forgot-password'),
                                  behavior: HitTestBehavior.translucent,
                                  child: Text(
                                    'Forgot password?',
                                    style: kSmallText,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                        SizedBox(height: 50),
                        Column(
                          children: [
                            LargeButton(
                              text: 'Login',
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  FocusScope.of(context).unfocus();
                                  _userController.signIn(
                                      email: _emailController.text, password: _passwordController.text);
                                }
                              },
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Text('- OR -'),
                            // ),
                            // MaterialButton(
                            //   child: Center(
                            //       child: Padding(
                            //     padding: const EdgeInsets.all(4.0),
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: <Widget>[
                            //         Padding(
                            //           padding: const EdgeInsets.only(right: 4.0),
                            //           child: Image.asset(
                            //             'assets/images/icon_google.png',
                            //             width: 20,
                            //             height: 20,
                            //           ),
                            //         ),
                            //         Text('Login with Google', style: TextStyle(color: Colors.blue)),
                            //       ],
                            //     ),
                            //   )),
                            //   onPressed: () => _handleSignInGoogle(),
                            //   color: Colors.white,
                            // ),
                            // MaterialButton(
                            //   child: Center(
                            //       child: Padding(
                            //     padding: const EdgeInsets.all(4.0),
                            //     child: Padding(
                            //       padding: const EdgeInsets.all(6.0),
                            //       child: Row(
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         children: <Widget>[
                            //           Padding(
                            //             padding: const EdgeInsets.only(right: 8.0),
                            //             child: Image.asset(
                            //               'assets/images/icon_facebook.png',
                            //               width: 20,
                            //               height: 20,
                            //             ),
                            //           ),
                            //           Text('Login with Facebook', style: TextStyle(color: Colors.white)),
                            //         ],
                            //       ),
                            //     ),
                            //   )),
                            //   onPressed: () => _handleSignInFacebook(),
                            //   color: Color.fromRGBO(59, 89, 152, 1),
                            // ),
                            SizedBox(height: 25),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () => Get.to(RegisterScreen()),
                              child: Text('Not a member? Sign Up', style: kSmallText),
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
      ),
    );
  }
}
