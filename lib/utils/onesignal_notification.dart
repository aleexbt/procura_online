import 'package:flutter/foundation.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
// import './navigation_helper.dart';

class NotificationHelper {
  // final navigatorKey = NavKey.navKey;

  void initOneSignal({String userId}) async {
    // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    var settings = {OSiOSSettings.autoPrompt: false, OSiOSSettings.promptBeforeOpeningPushUrl: true};

    OneSignal.shared.setNotificationReceivedHandler((notification) {
      debugPrint("NOTIFICATION_RECEIVED");
    });

    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      var notifyDetails = result.notification.payload.additionalData;
      debugPrint("NOTIFICATION_CLICKED");
      if (notifyDetails["page"] == "orders") {
        // navigatorKey.currentState
        //     .pushNamedAndRemoveUntil('/app', (route) => false, arguments: 2);
      } else {
        debugPrint("NOTIFICATION_BYPASS");
      }
    });

    await OneSignal.shared.init('5d641105-7b40-4b0d-902a-ad3a0b02041a', iOSSettings: settings);

    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);

    if (userId != null) {
      print('SET_EXTERNAL_USER_ID');
      OneSignal.shared.setExternalUserId(userId);
    }
  }

  void setExternalUserId({@required String userId}) {
    OneSignal.shared.setExternalUserId(userId);
  }
}
