import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              onTap: () => Get.toNamed('/settings/edit-profile'),
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
              onTap: () => Get.toNamed('/settings/change-password'),
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
              onTap: () => Get.offAndToNamed('/'),
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
