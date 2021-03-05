import 'dart:io';

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
  void initState() {
    super.initState();
  }

  showAlertDialog({
    @required BuildContext context,
    @required String title,
    @required String content,
    String cancelActionText,
    @required String confirmActionText,
  }) {
    if (Platform.isAndroid) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            if (cancelActionText != null)
              FlatButton(
                child: Text(cancelActionText),
                onPressed: () => Get.back(),
              ),
            FlatButton(
              child: Text(confirmActionText),
              onPressed: () => _userController.deleleteAccount(),
            ),
          ],
        ),
      );
    }

    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          if (cancelActionText != null)
            CupertinoDialogAction(
              child: Text(cancelActionText),
              onPressed: () => Get.back(),
            ),
          CupertinoDialogAction(
            child: Text(
              confirmActionText,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Configurações'),
        backgroundColor: Platform.isIOS ? Colors.transparent : null,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTileMoreCustomizable(
              onTap: (_) => Get.toNamed('/settings/account/profile'),
              leading: Icon(Icons.account_circle_outlined, color: Colors.blue),
              title: Text('Conta'),
              horizontalTitleGap: 0,
              subtitle: Text('Editar informações do perfil'),
            ),
            ListTileMoreCustomizable(
              onTap: (_) => Get.toNamed('/settings/account/billing'),
              leading: Icon(Icons.article_outlined, color: Colors.blue),
              title: Text('Faturação'),
              horizontalTitleGap: 0,
              subtitle: Text('Editar informações de faturação'),
            ),
            ListTileMoreCustomizable(
              onTap: (_) => Get.toNamed('/settings/change-password'),
              leading: Icon(CupertinoIcons.lock, color: Colors.blue),
              title: Text('Alterar password'),
              horizontalTitleGap: 0,
              subtitle: Text('Alterar password da sua conta'),
            ),
            ListTileMoreCustomizable(
              onTap: (_) => Get.toNamed('/settings/ads'),
              leading: Icon(Icons.edit, color: Colors.blue),
              title: Text('Meus anúncios'),
              horizontalTitleGap: 0,
              subtitle: Text('Gerenciar anúncios publicados'),
            ),
            Divider(),
            ListTileMoreCustomizable(
              onTap: (_) => showAlertDialog(
                context: context,
                title: 'Eliminar conta',
                content: 'Tem certeza que deseja eliminar sua conta? Esta ação é irreversível',
                cancelActionText: 'Cancelar',
                confirmActionText: 'Eliminar',
              ),
              leading: Icon(CupertinoIcons.trash, color: Colors.red),
              title: Text(
                'Eliminar conta',
                style: TextStyle(color: Colors.red),
              ),
              horizontalTitleGap: 0,
              subtitle: Text('Eliminar sua conta e todos os seus dados'),
            ),
            ListTileMoreCustomizable(
              onTap: (_) => _userController.logOut(),
              leading: Icon(CupertinoIcons.power, color: Colors.blue),
              title: Text('Logout'),
              horizontalTitleGap: 0,
              subtitle: Text('Sair de sua conta'),
            ),
          ],
        ),
      ),
    );
  }
}
