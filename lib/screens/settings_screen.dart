import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/screens/change_password_screen.dart';
import 'package:procura_online/screens/edit_profile_screen.dart';
import 'package:procura_online/screens/splash.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Get.to(EditProfileScreen()),
              behavior: HitTestBehavior.translucent,
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.pencil,
                    color: Colors.blue,
                    size: 25,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Edit profile',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => Get.to(ChangePasswordScreen()),
              behavior: HitTestBehavior.translucent,
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.lock,
                    color: Colors.blue,
                    size: 25,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Change password',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => Get.offAll(SplashScreen()),
              behavior: HitTestBehavior.translucent,
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.power,
                    color: Colors.blue,
                    size: 25,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Sign out',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
