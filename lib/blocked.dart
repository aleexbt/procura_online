import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Blocked extends StatefulWidget {
  @override
  _BlockedState createState() => _BlockedState();
}

class _BlockedState extends State<Blocked> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ops, parece que este aplicativo foi desabilitado.',
              ),
              SizedBox(height: 5),
              Text(
                'Entre em contato: aleexbt@gmail.com',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
