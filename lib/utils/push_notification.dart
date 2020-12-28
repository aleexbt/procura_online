import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsManager {
  PushNotificationsManager._();
  factory PushNotificationsManager() => _instance;
  static final PushNotificationsManager _instance = PushNotificationsManager._();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  static Future<dynamic> backgroundMessageHandler(Map<String, dynamic> message) {
    print('chamou background');
    // _showNotification(message);
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
      print("backgroundMessageHandler data: $data");
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
      print("backgroundMessageHandler notification: $notification");
    }
    return Future<void>.value();
  }

  Future<void> init() async {
    // _initLocalNotifications();
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();

      _firebaseMessaging.configure(
        // Run when the app is already in foreground
        onMessage: (Map<String, dynamic> response) async {
          print("onMessage: $response");
          // _showNotification(response);
        },
        // Run when the app is started from closed state
        onLaunch: (Map<String, dynamic> response) async {
          print("onLaunch: $response");
          // _showNotification(response);
        },
        // Run when the app is started from background state
        onResume: (Map<String, dynamic> response) async {
          print("onResume: $response");
          // _showNotification(response);
        },
        onBackgroundMessage: backgroundMessageHandler,
      );

      // For testing purposes print the Firebase Messaging token
      String token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $token");

      _initialized = true;
    }
  }

  // static FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //
  // _initLocalNotifications() {
  //   var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  //   var initializationSettingsIOS = IOSInitializationSettings();
  //   var initializationSettings =
  //       InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  //   _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  // }
  //
  // static Future _showNotification(Map<String, dynamic> message) async {
  //   var pushTitle;
  //   var pushText;
  //   var action;
  //
  //   if (Platform.isAndroid) {
  //     var nodeData = message['data'];
  //     pushTitle = nodeData['title'];
  //     pushText = nodeData['body'];
  //     action = nodeData['action'];
  //   } else {
  //     pushTitle = message['title'];
  //     pushText = message['body'];
  //     action = message['action'];
  //   }
  //   print("AppPushs params pushTitle : $pushTitle");
  //   print("AppPushs params pushText : $pushText");
  //   print("AppPushs params pushAction : $action");
  //
  //   // @formatter:off
  //   var platformChannelSpecificsAndroid = AndroidNotificationDetails('1', 'Notifications', 'App notifications',
  //       playSound: false, enableVibration: false, importance: Importance.max, priority: Priority.high);
  //   // @formatter:on
  //   var platformChannelSpecificsIos = IOSNotificationDetails(presentSound: false);
  //   var platformChannelSpecifics =
  //       NotificationDetails(android: platformChannelSpecificsAndroid, iOS: platformChannelSpecificsIos);
  //
  //   Future.delayed(Duration.zero, () {
  //     _flutterLocalNotificationsPlugin.show(
  //       0,
  //       pushTitle,
  //       pushText,
  //       platformChannelSpecifics,
  //       payload: 'No_Sound',
  //     );
  //   });
  // }
}
