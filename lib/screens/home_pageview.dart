import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:procura_online/screens/chat_screen.dart';
import 'package:procura_online/screens/settings_screen.dart';
import 'package:procura_online/screens/tests.dart';

import 'home.dart';

class HomePageView extends StatefulWidget {
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  PageController _pageController = PageController();
  int _selectedIndex = 0;
  int productCount = 0;

  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: onPageChanged,
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomeScreen(),
            ChatScreen(),
            TestsScreen(),
            SettingsScreen(),
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
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.plus_app_fill),
            label: 'Tests',
          ),
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
