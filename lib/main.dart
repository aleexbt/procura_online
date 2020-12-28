import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:procura_online/app_bindings.dart';
import 'package:procura_online/routes/pages.dart';
import 'package:procura_online/routes/routes.dart';
import 'package:procura_online/utils/prefs.dart';
import 'package:procura_online/utils/push_notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  await PushNotificationsManager().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: GetMaterialApp(
        // smartManagement: SmartManagement.keepFactory,
        initialBinding: AppBindings(),
        initialRoute: Routers.initialRoute,
        getPages: getPages,
        debugShowCheckedModeBanner: false,
        title: 'Procura Online',
        theme: ThemeData(
          primaryColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.openSansTextTheme(
            Theme.of(context).textTheme,
          ),
          pageTransitionsTheme: PageTransitionsTheme(
            builders: const {TargetPlatform.android: ZoomPageTransitionsBuilder()},
          ),
        ),
      ),
    );
  }
}
