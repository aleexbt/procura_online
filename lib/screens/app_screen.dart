import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:procura_online/screens/auth/user_controller.dart';
import 'package:procura_online/screens/conversations/chat_screen.dart';
import 'package:procura_online/screens/protected_route.dart';
import 'package:procura_online/screens/settings_screen.dart';
import 'package:procura_online/utils/navigation_helper.dart';

import 'home/home_screen.dart';

class AppScreen extends StatefulWidget {
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  // final PageController _pageController = PageController();
  PageController _pageController = NavKey.pageController;
  final UserController _userController = Get.find();
  int _selectedIndex = 0;
  int productCount = 0;

  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: onPageChanged,
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomeScreen(),
            _userController.isLoggedIn ? ChatScreen() : ProtectedRoute(),
            _userController.isLoggedIn ? SettingsScreen() : ProtectedRoute(),
            // LoginScreen(),
          ],
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
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_fill),
            label: 'Chat',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(CupertinoIcons.plus_app_fill),
          //   label: 'Tests',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded),
            label: 'Settings',
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
