import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:procura_online/controllers/conversation_controller.dart';

class NotificationHelper {
  void initOneSignal({String userId}) async {
    // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    Map<OSiOSSettings, bool> settings = {
      OSiOSSettings.autoPrompt: true,
      OSiOSSettings.promptBeforeOpeningPushUrl: true
    };

    OneSignal.shared.setNotificationReceivedHandler((notification) {
      debugPrint("NOTIFICATION_RECEIVED");
      if (notification.appInFocus) {
        _showNotification(notification.payload.rawPayload);
      }
    });

    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      Map<String, dynamic> data = result.notification.payload.additionalData;

      if (data['action'] == 'redirect') {
        if (data['page'] == 'conversation') {
          String conversationId = data['conversationId'].toString();
          Get.toNamed('/chat/conversation/$conversationId');
        }
      }
    });

    await OneSignal.shared.init('5d641105-7b40-4b0d-902a-ad3a0b02041a', iOSSettings: settings);

    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.none);

    if (userId != null) {
      OneSignal.shared.setExternalUserId(userId);
    }
  }

  void setExternalUserId({@required String userId}) {
    OneSignal.shared.setExternalUserId(userId);
  }

  void removeExternalUserId() {
    OneSignal.shared.removeExternalUserId();
  }

  Future onSelectLocalNotification(String payload) async {
    print('LOCAL_NOTIFICATION_TAPPED');
    Map<String, dynamic> data = jsonDecode(payload)['a'];

    if (data['action'] == 'redirect') {
      if (data['page'] == 'conversation') {
        String conversationId = data['conversationId'].toString();
        Get.delete<ConversationController>(force: true);
        Get.toNamed('/chat/conversation/$conversationId');
      }
    }
  }

  static FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  initLocalNotifications() {
    var initializationSettingsAndroid = AndroidInitializationSettings('@drawable/ic_stat_onesignal_default');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectLocalNotification,
    );
  }

  static Future _showNotification(Map<String, dynamic> message) async {
    String pushTitle;
    String pushText;
    Map<String, dynamic> payload = jsonDecode(message['custom'])['a'];

    pushTitle = message['title'];
    pushText = message['alert'];

    var platformChannelSpecificsAndroid = AndroidNotificationDetails(
      '1',
      'Notifications',
      'App notifications',
      playSound: true,
      enableVibration: false,
      importance: Importance.max,
      priority: Priority.high,
      color: Colors.blue,
    );

    var platformChannelSpecificsIos = IOSNotificationDetails(presentSound: true);
    var platformChannelSpecifics =
        NotificationDetails(android: platformChannelSpecificsAndroid, iOS: platformChannelSpecificsIos);

    if (payload['action'] == 'redirect' && payload['page'] == 'conversation') {
      if (Get.currentRoute != '/chat/conversation/${payload['conversationId']}') {
        Future.delayed(Duration.zero, () {
          _flutterLocalNotificationsPlugin.show(
            0,
            pushTitle,
            pushText,
            platformChannelSpecifics,
            payload: message['custom'],
          );
        });
      }
    } else {
      Future.delayed(Duration.zero, () {
        _flutterLocalNotificationsPlugin.show(
          0,
          pushTitle,
          pushText,
          platformChannelSpecifics,
          payload: message['custom'],
        );
      });
    }
  }
}
