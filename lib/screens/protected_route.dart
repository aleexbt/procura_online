import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:procura_online/utils/navigation_helper.dart';

class ProtectedRoute extends StatefulWidget {
  @override
  _ProtectedRouteState createState() => _ProtectedRouteState();
}

class _ProtectedRouteState extends State<ProtectedRoute> {
  PageController _pageController = NavKey.pageController;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/images/registro.svg', width: 300),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              'Você precisar estar autenticado para acessar este conteúdo.',
              textAlign: TextAlign.center,
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            ),
            onPressed: () => Get.toNamed('/auth/login'),
            child: Text('ENTRAR'),
          )
        ],
      ),
    );
  }
}
