import 'package:get/get.dart';
import 'package:procura_online/intro.dart';
import 'package:procura_online/routes/routes.dart';
import 'package:procura_online/screens/ad/new_ad_screen.dart';
import 'package:procura_online/screens/app_screen.dart';
import 'package:procura_online/screens/auth/forgot_password_screen.dart';
import 'package:procura_online/screens/auth/login_screen.dart';
import 'package:procura_online/screens/auth/register_screen.dart';
import 'package:procura_online/screens/conversations/chat_screen.dart';
import 'package:procura_online/screens/conversations/conversation_screen.dart';
import 'package:procura_online/screens/filter_screen.dart';
import 'package:procura_online/screens/home/home_screen.dart';
import 'package:procura_online/screens/product/product_screen.dart';
import 'package:procura_online/screens/settings/change_password_screen.dart';
import 'package:procura_online/screens/settings/edit_profile_screen.dart';
import 'package:procura_online/screens/settings/settings_screen.dart';
import 'package:procura_online/screens/tests.dart';
import 'package:procura_online/splash.dart';

List<GetPage> getPages = [
  GetPage(
    name: Routers.initialRoute,
    page: () => SplashScreen(),
  ),
  GetPage(
    name: Routers.intro,
    page: () => OnBoardingPage(),
  ),
  GetPage(
    name: Routers.home,
    page: () => HomeScreen(),
  ),
  GetPage(
    name: Routers.app,
    page: () => AppScreen(),
  ),
  GetPage(
    name: Routers.login,
    page: () => LoginScreen(),
  ),
  GetPage(
    name: Routers.register,
    page: () => RegisterScreen(),
  ),
  GetPage(
    name: Routers.forgotPassword,
    page: () => ForgotPasswordScreen(),
  ),
  GetPage(
    name: Routers.product,
    page: () => ProductScreen(),
  ),
  GetPage(
    name: Routers.chat,
    page: () => ChatScreen(),
  ),
  GetPage(
    name: Routers.chatConversation,
    page: () => ConversationScreen(),
  ),
  GetPage(
    name: Routers.searchFilter,
    page: () => FilterScreen(),
    fullscreenDialog: true,
  ),
  GetPage(
    name: Routers.settings,
    page: () => SettingsScreen(),
  ),
  GetPage(
    name: Routers.editProfile,
    page: () => EditProfileScreen(),
  ),
  GetPage(
    name: Routers.changePassword,
    page: () => ChangePasswordScreen(),
  ),
  GetPage(
    name: Routers.newAd,
    page: () => NewAdScreen(),
  ),
  GetPage(
    name: Routers.tests,
    page: () => TestsScreen(),
  ),
];
