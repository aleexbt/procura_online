import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:procura_online/screens/ad/new_ad_screen.dart';
import 'package:procura_online/screens/app_screen.dart';
import 'package:procura_online/screens/auth/login_screen.dart';
import 'package:procura_online/screens/auth/register_screen.dart';
import 'package:procura_online/screens/change_password_screen.dart';
import 'package:procura_online/screens/chat_screen.dart';
import 'package:procura_online/screens/conversation_screen.dart';
import 'package:procura_online/screens/edit_profile_screen.dart';
import 'package:procura_online/screens/filter_screen.dart';
import 'package:procura_online/screens/home/home_screen.dart';
import 'package:procura_online/screens/product/product_screen.dart';
import 'package:procura_online/screens/settings_screen.dart';
import 'package:procura_online/screens/splash.dart';
import 'package:procura_online/screens/tests.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: GetMaterialApp(
        home: SplashScreen(),
        getPages: [
          GetPage(name: '/', page: () => SplashScreen()),
          GetPage(name: '/home', page: () => HomeScreen()),
          GetPage(name: '/app', page: () => AppScreen()),
          GetPage(name: '/product-details/:id', page: () => ProductScreen()),
          GetPage(name: '/chat', page: () => ChatScreen()),
          GetPage(
              name: '/chat/conversation/:id', page: () => ConversationScreen()),
          GetPage(name: '/tests', page: () => TestsScreen()),
          GetPage(
              name: '/search-filter',
              page: () => FilterScreen(),
              fullscreenDialog: true),
          GetPage(name: '/settings', page: () => SettingsScreen()),
          GetPage(
              name: '/settings/edit-profile', page: () => EditProfileScreen()),
          GetPage(
              name: '/settings/change-password',
              page: () => ChangePasswordScreen()),
          GetPage(name: '/ad/new', page: () => NewAdScreen()),
          GetPage(name: '/auth/login', page: () => LoginScreen()),
          GetPage(name: '/auth/register', page: () => RegisterScreen()),
        ],
        debugShowCheckedModeBanner: false,
        title: 'Procura Online',
        theme: ThemeData(
          primaryColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.openSansTextTheme(
            Theme.of(context).textTheme,
          ),
        ),

        // home: MyHomePage(),
        // home: SplashScreen(),
      ),
    );
  }
}
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   var _textControllerEmail;
//   var _textControllerPassword;
//   final FocusNode _emailFocus = FocusNode();
//   final FocusNode _passwordFocus = FocusNode();
//
//   //Used for visible/invisible password
//   var isPasswordVisible = true;
//
//   GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: [
//       'email',
//       'https://www.googleapis.com/auth/userinfo.email',
//       'https://www.googleapis.com/auth/userinfo.profile',
//     ],
//   );
//
//   @override
//   void initState() {
//     _textControllerEmail = TextEditingController();
//     _textControllerPassword = TextEditingController();
//     super.initState();
//   }
//
//   Future<void> _handleSignInGoogle() async {
//     try {
//       await _googleSignIn.signIn();
//     } catch (e) {
//       print('login failed $e');
//     }
//   }
//
//   Future<void> _handleSignInFacebook() async {
//     try {
//       // by default the login method has the next permissions ['email','public_profile']
//       AccessToken accessToken = await FacebookAuth.instance.login();
//       print(accessToken.toJson());
//       // get the user data
//       final userData = await FacebookAuth.instance.getUserData();
//       print(userData);
//     } on FacebookAuthException catch (e) {
//       switch (e.errorCode) {
//         case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
//           print("You have a previous login operation in progress");
//           break;
//         case FacebookAuthErrorCode.CANCELLED:
//           print("login cancelled");
//           break;
//         case FacebookAuthErrorCode.FAILED:
//           print("login failed ${e.message}");
//           break;
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
//       statusBarColor: Colors.blue, //or set color with: Color(0xFF0000FF)
//     ));
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(35.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 120, left: 80, right: 80, bottom: 40),
//                       child: Image.asset(
//                         'assets/images/logo.png',
//                         width: 200,
//                       ),
//                     ),
//                     Text(
//                       'Login',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 50),
//                 Column(
//                   children: [
//                     CustomTextInput(
//                       hintText: 'Email',
//                       hintStyle: TextStyle(color: Colors.white),
//                     ),
//                     SizedBox(height: 10),
//                     CustomTextInput(
//                       hintText: 'Password',
//                       hintStyle: TextStyle(color: Colors.white),
//                     ),
//                     SizedBox(height: 10),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: Text(
//                         'Forgot password?',
//                         style: kSmallText,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                   ],
//                 ),
//                 SizedBox(height: 50),
//                 Column(
//                   children: [
//                     LargeButton(
//                       text: 'Login',
//                       onPressed: () => Get.off(HomePageView()),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text('- OR -'),
//                     ),
//                     MaterialButton(
//                       child: Center(
//                           child: Padding(
//                         padding: const EdgeInsets.all(4.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Padding(
//                               padding: const EdgeInsets.only(right: 4.0),
//                               child: Image.asset(
//                                 'assets/images/icon_google.png',
//                                 width: 20,
//                                 height: 20,
//                               ),
//                             ),
//                             Text('Login with Google', style: TextStyle(color: Colors.blue)),
//                           ],
//                         ),
//                       )),
//                       onPressed: () => _handleSignInGoogle(),
//                       color: Colors.white,
//                     ),
//                     MaterialButton(
//                       child: Center(
//                           child: Padding(
//                         padding: const EdgeInsets.all(4.0),
//                         child: Padding(
//                           padding: const EdgeInsets.all(6.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 8.0),
//                                 child: Image.asset(
//                                   'assets/images/icon_facebook.png',
//                                   width: 20,
//                                   height: 20,
//                                 ),
//                               ),
//                               Text('Login with Facebook', style: TextStyle(color: Colors.white)),
//                             ],
//                           ),
//                         ),
//                       )),
//                       onPressed: () => _handleSignInFacebook(),
//                       color: Color.fromRGBO(59, 89, 152, 1),
//                     ),
//                     SizedBox(height: 25),
//                     GestureDetector(
//                       behavior: HitTestBehavior.translucent,
//                       onTap: () => Get.to(RegisterScreen()),
//                       child: Text('Not a member? Sign Up', style: kSmallText),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
