import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_tile_more_customizable/list_tile_more_customizable.dart';

import '../../controllers/user_controller.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  UserController _userController = Get.find();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Settings'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTileMoreCustomizable(
              onTap: (_) => Get.toNamed('/settings/edit-profile'),
              leading: Icon(Icons.account_circle_outlined, color: Colors.blue),
              title: Text('Account'),
              horizontalTitleGap: 0,
              subtitle: Text('Manage your account settings'),
            ),
            ListTileMoreCustomizable(
              onTap: (_) => Get.toNamed('/settings/change-password'),
              leading: Icon(CupertinoIcons.lock, color: Colors.blue),
              title: Text('Change password'),
              horizontalTitleGap: 0,
              subtitle: Text('Change your account password'),
            ),
            ListTileMoreCustomizable(
              onTap: (_) => _userController.logOut(),
              leading: Icon(CupertinoIcons.power, color: Colors.blue),
              title: Text('Sign out'),
              horizontalTitleGap: 0,
              subtitle: Text('Sign out of your account'),
            ),
            ListTileMoreCustomizable(
              onTap: (_) => Get.toNamed('/ad/edit/24'),
              leading: Icon(Icons.account_circle_outlined, color: Colors.blue),
              title: Text('Edit'),
              horizontalTitleGap: 0,
              subtitle: Text('Manage your account settings'),
            ),
          ],
        ),
      ),
    );
  }
}
