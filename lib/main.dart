import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:procura_online/app_bindings.dart';
import 'package:procura_online/routes/pages.dart';
import 'package:procura_online/routes/routes.dart';
import 'package:procura_online/utils/route_transition_vertical.dart';
import 'package:sizer/sizer_util.dart';

void main() async {
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              SizerUtil().init(constraints, orientation);
              return GetMaterialApp(
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: [
                  const Locale('pt', 'PT'),
                  const Locale('pt', 'BR'),
                  const Locale('en', 'US'),
                ],
                customTransition: SharedZaxisPageTransitionVertical(),
                initialBinding: AppBindings(),
                initialRoute: Routers.initialRoute,
                getPages: getPages,
                popGesture: true,
                debugShowCheckedModeBanner: false,
                title: 'Procura Online',
                theme: ThemeData(
                  primaryColor: Colors.white,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  textTheme: GoogleFonts.openSansTextTheme(
                    Theme.of(context).textTheme,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
