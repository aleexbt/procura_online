import 'package:get/get.dart';
import 'package:procura_online/intro.dart';
import 'package:procura_online/routes/routes.dart';
import 'package:procura_online/screens/ad/create_ad_screen.dart';
import 'package:procura_online/screens/ad/edit_ad_screen.dart';
import 'package:procura_online/screens/app_screen.dart';
import 'package:procura_online/screens/auth/forgot_password_screen.dart';
import 'package:procura_online/screens/auth/login_screen.dart';
import 'package:procura_online/screens/auth/register_screen.dart';
import 'package:procura_online/screens/conversations/chat_screen.dart';
import 'package:procura_online/screens/conversations/conversation_screen.dart';
import 'package:procura_online/screens/conversations/order_reply_screen.dart';
import 'package:procura_online/screens/create_order_screen.dart';
import 'package:procura_online/screens/filter_screen.dart';
import 'package:procura_online/screens/home/home_screen.dart';
import 'package:procura_online/screens/product/product_screen.dart';
import 'package:procura_online/screens/settings/ads_listing_screen.dart';
import 'package:procura_online/screens/settings/change_password_screen.dart';
import 'package:procura_online/screens/settings/edit_profile_screen.dart';
import 'package:procura_online/screens/settings/settings_screen.dart';
import 'package:procura_online/screens/tests.dart';
import 'package:procura_online/splash.dart';
import 'package:procura_online/utils/route_transition_horizontal.dart';
import 'package:procura_online/widgets/show_photo.dart';

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
    customTransition: SharedZaxisPageTransitionHorizontal(),
  ),
  GetPage(
    name: Routers.forgotPassword,
    page: () => ForgotPasswordScreen(),
    customTransition: SharedZaxisPageTransitionHorizontal(),
  ),
  GetPage(
    name: Routers.product,
    page: () => ProductScreen(),
  ),
  GetPage(name: Routers.showPhotos, page: () => ShowPhotos()),
  GetPage(
    name: Routers.chat,
    page: () => ChatScreen(),
  ),
  GetPage(
    name: Routers.chatConversation,
    page: () => ConversationScreen(),
  ),
  GetPage(
    name: Routers.chatReply,
    page: () => OrderReplyScreen(),
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
    name: Routers.adsListing,
    page: () => AdsListingScreen(),
  ),
  GetPage(
    name: Routers.adsEdit,
    page: () => EditAdScreen(),
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
    name: Routers.createAd,
    page: () => CreateAdScreen(),
  ),
  GetPage(
    name: Routers.createOrder,
    page: () => CreateOrderScreen(),
  ),
  GetPage(
    name: Routers.tests,
    page: () => TestsScreen(),
  ),
];
