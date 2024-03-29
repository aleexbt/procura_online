import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:procura_online/screens/protected_route.dart';
import 'package:procura_online/screens/settings/settings_screen.dart';
import 'package:procura_online/utils/navigation_helper.dart';
import 'package:procura_online/utils/onesignal_notification.dart';

import 'home_screen.dart';
import 'orders/orders_chat_screen.dart';

class AppScreen extends StatefulWidget {
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  // final PageController _pageController = PageController();
  NotificationHelper _notificationHelper = NotificationHelper();
  PageController _pageController = NavKey.pageController;
  final UserController _userController = Get.find();
  int _selectedIndex = 0;
  int productCount = 0;

  @override
  void initState() {
    _notificationHelper.initOneSignal();
    _notificationHelper.initLocalNotifications();
    if (_userController.userData?.id != null) {
      _notificationHelper.setExternalUserId(userId: _userController.userData?.id?.toString());
    }

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.red,
      statusBarIconBrightness: Brightness.dark,
    ));
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> unauthenticatedScreens = [
    HomeScreen(),
    ProtectedRoute(),
    ProtectedRoute(),
  ];

  final List<Widget> authenticatedScreeens = [
    HomeScreen(),
    OrdersAndChatScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarBrightness: Brightness.light,
    //   statusBarColor: Colors.white,
    //   statusBarIconBrightness: Brightness.dark,
    // ));
    return Scaffold(
      body: SafeArea(
        child: PageView(
          pageSnapping: false,
          controller: _pageController,
          onPageChanged: onPageChanged,
          physics: NeverScrollableScrollPhysics(),
          children: _userController.isLoggedIn ? authenticatedScreeens : unauthenticatedScreens,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        unselectedFontSize: 10,
        selectedFontSize: 10,
        unselectedItemColor: Colors.grey[500],
        selectedItemColor: Colors.grey[800],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            // icon: Badge(
            //   badgeColor: Colors.blue,
            //   badgeContent: Text(
            //     '20',
            //     style: TextStyle(color: Colors.white, fontSize: 7),
            //   ),
            //   child: Icon(CupertinoIcons.chat_bubble_fill),
            //   animationType: BadgeAnimationType.scale,
            // ),
            icon: Icon(CupertinoIcons.chat_bubble_fill),
            label: 'Conversas',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(CupertinoIcons.plus_app_fill),
          //   label: 'Tests',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Configurações',
          ),
        ],
        currentIndex: _selectedIndex,
        // onTap: (int index) => _pageController.animateToPage(index,
        //     duration: Duration(milliseconds: 200), curve: Curves.linear),
        onTap: (int index) => _pageController.jumpToPage(index),
      ),
    );
  }
}
