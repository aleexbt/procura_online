import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
// import './navigation_helper.dart';

class NotificationHelper {
  // final navigatorKey = NavKey.navKey;

  void initOneSignal({String userId}) async {
    // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    Map<OSiOSSettings, bool> settings = {
      OSiOSSettings.autoPrompt: true,
      OSiOSSettings.promptBeforeOpeningPushUrl: true
    };

    OneSignal.shared.setNotificationReceivedHandler((notification) {
      debugPrint("NOTIFICATION_RECEIVED");
    });

    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      Map<String, dynamic> data = result.notification.payload.additionalData;

      if (data['action'] == 'redirect') {
        if (data['page'] == 'conversation') {
          String conversationId = data['conversationId'];
          Get.toNamed('/chat/conversation/$conversationId');
        }
      }
    });

    await OneSignal.shared.init('5d641105-7b40-4b0d-902a-ad3a0b02041a', iOSSettings: settings);
    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);

    if (userId != null) {
      OneSignal.shared.setExternalUserId(userId);
    }
  }

  void setExternalUserId({@required String userId}) {
    OneSignal.shared.setExternalUserId(userId);
  }
}
