import 'dart:io';

import 'package:get/get.dart';
import 'package:procura_online/bindings/conversation_bindings.dart';
import 'package:procura_online/intro.dart';
import 'package:procura_online/routes/routes.dart';
import 'package:procura_online/screens/ad/create_ad_screen.dart';
import 'package:procura_online/screens/ad/edit_ad_screen.dart';
import 'package:procura_online/screens/app_screen.dart';
import 'package:procura_online/screens/auth/forgot_password_screen.dart';
import 'package:procura_online/screens/auth/login_screen.dart';
import 'package:procura_online/screens/auth/register_screen.dart';
import 'package:procura_online/screens/create_order_screen.dart';
import 'package:procura_online/screens/filter_screen.dart';
import 'package:procura_online/screens/home_screen.dart';
import 'package:procura_online/screens/orders/conversation_screen.dart';
import 'package:procura_online/screens/orders/order_reply_screen.dart';
import 'package:procura_online/screens/orders/orders_chat_screen.dart';
import 'package:procura_online/screens/product_screen.dart';
import 'package:procura_online/screens/profile_screen.dart';
import 'package:procura_online/screens/settings/ads_listing_screen.dart';
import 'package:procura_online/screens/settings/change_password_screen.dart';
import 'package:procura_online/screens/settings/edit_billing_screen.dart';
import 'package:procura_online/screens/settings/edit_profile_screen.dart';
import 'package:procura_online/screens/settings/settings_screen.dart';
import 'package:procura_online/splash.dart';
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
    transition: Transition.fadeIn,
    opaque: false,
  ),
  GetPage(
    name: Routers.register,
    page: () => RegisterScreen(),
    transition: Transition.fadeIn,
    opaque: false,
  ),
  GetPage(
    name: Routers.forgotPassword,
    page: () => ForgotPasswordScreen(),
    transition: Transition.fadeIn,
    opaque: false,
  ),
  GetPage(
    name: Routers.product,
    page: () => ProductScreen(),
    transition: Platform.isIOS ? Transition.native : null,
  ),
  GetPage(
    name: Routers.showPhotos,
    page: () => ShowPhotos(),
    opaque: false,
    transition: Platform.isIOS ? Transition.noTransition : null,
  ),
  // GetPage(
  //   name: Routers.imagePreview,
  //   page: () => ImagePreview(),
  //   opaque: false,
  // ),
  GetPage(
    name: Routers.chat,
    page: () => OrdersAndChatScreen(),
  ),
  GetPage(
    name: Routers.chatConversation,
    page: () => ConversationScreen(),
    binding: ConversationBindings(),
    transition: Platform.isIOS ? Transition.native : null,
  ),
  GetPage(
    name: Routers.chatReply,
    page: () => OrderReplyScreen(),
    transition: Platform.isIOS ? Transition.native : null,
  ),
  GetPage(
    name: Routers.searchFilter,
    page: () => FilterScreen(),
    fullscreenDialog: true,
    transition: Transition.cupertinoDialog,
  ),
  GetPage(
    name: Routers.settings,
    page: () => SettingsScreen(),
  ),
  GetPage(
    name: Routers.adsListing,
    page: () => AdsListingScreen(),
    transition: Platform.isIOS ? Transition.native : null,
  ),
  GetPage(
    name: Routers.adsEdit,
    page: () => EditAdScreen(),
    transition: Platform.isIOS ? Transition.native : null,
  ),
  GetPage(
    name: Routers.editProfile,
    page: () => EditProfileScreen(),
    transition: Platform.isIOS ? Transition.native : null,
  ),
  GetPage(
    name: Routers.editBilling,
    page: () => EditBillingScreen(),
    transition: Platform.isIOS ? Transition.native : null,
  ),
  GetPage(
    name: Routers.changePassword,
    page: () => ChangePasswordScreen(),
    transition: Platform.isIOS ? Transition.native : null,
  ),
  GetPage(
    name: Routers.createAd,
    page: () => CreateAdScreen(),
    transition: Platform.isIOS ? Transition.native : null,
  ),
  GetPage(
    name: Routers.createOrder,
    page: () => CreateOrderScreen(),
    transition: Platform.isIOS ? Transition.native : null,
  ),
  GetPage(
    name: Routers.profile,
    page: () => ProfileScreen(),
    transition: Platform.isIOS ? Transition.native : null,
  ),
];
