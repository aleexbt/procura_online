import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:procura_online/widgets/large_button.dart';
import 'package:procura_online/widgets/text_input.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final UserController _userController = Get.find();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FocusScopeNode _node = FocusScopeNode();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.blue,
      statusBarIconBrightness: Brightness.light,
    ));
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    _node.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    final focus = FocusNode();
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(
          'Entrar',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      // backgroundColor: Colors.blue,
      body: SafeArea(
        bottom: false,
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
                        padding: EdgeInsets.only(top: 50, left: 80, right: 80, bottom: 50),
                        child: SvgPicture.asset('assets/images/logo_branco.svg', width: 100),
                      ),
                      Form(
                        key: _formKey,
                        child: FocusScope(
                          node: _node,
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
                                textInputAction: TextInputAction.next,
                                onEditingComplete: _node.nextFocus,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your email address';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              CustomTextInput(
                                controller: _passwordController,
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                hintText: 'Senha',
                                hintStyle: TextStyle(color: Colors.white),
                                obscureText: true,
                                errorBorderColor: Colors.white54,
                                errorTextColor: Colors.white,
                                onSubmitted: (value) {
                                  if (_formKey.currentState.validate()) {
                                    FocusScope.of(context).unfocus();
                                    _userController.signIn(
                                        email: _emailController.text, password: _passwordController.text);
                                  }
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    padding: EdgeInsets.all(0),
                                    visualDensity: VisualDensity.compact,
                                  ),
                                  child: Text('Esqueceu sua senha?'),
                                  onPressed: () => Get.toNamed('/auth/forgot-password'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Column(
                        children: [
                          LargeButton(
                            text: 'Entrar',
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
                          SizedBox(height: 20),
                          TextButton(
                            style: TextButton.styleFrom(primary: Colors.white),
                            child: Text('Ainda não tem uma conta? Registre-se'),
                            onPressed: () => Get.toNamed('/auth/register'),
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
