import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:procura_online/controllers/conversation_controller.dart';
import 'package:pusher_websocket_flutter/pusher.dart';

class PusherService {
  Event lastEvent;
  String lastConnectionState;
  Channel channel;

  Future<void> initPusher(String channelName) async {
    try {
      Box authBox = await Hive.openBox('auth') ?? null;
      String token = authBox.get('token') ?? null;
      await Pusher.init(
        'cb7f336d45263a9ab275',
        PusherOptions(
          cluster: 'eu',
          auth: PusherAuth(
            'https://xelapps-validation.herokuapp.com/pusher/auth',
            headers: {'Authorization': 'Bearer $token', 'channel_name': channelName, 'socket_id': Pusher.getSocketId()},
          ),
        ),
        enableLogging: true,
      );
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  void connectPusher() {
    Pusher.connect(onConnectionStateChange: (ConnectionStateChange connectionState) async {
      lastConnectionState = connectionState.currentState;
      print('CONNECTION_STATE: ${connectionState.currentState}');
    }, onError: (ConnectionError e) {
      print("Error: ${e.message}");
    });
  }

  Future<void> subscribePusher(String channelName) async {
    channel = await Pusher.subscribe(channelName);
  }

  void unSubscribePusher(String channelName) {
    Pusher.unsubscribe(channelName);
  }

  void bindEvent(String eventName) {
    channel.bind(eventName, (event) {
      final ConversationController _conversationController = Get.find();
      Map<String, dynamic> json = jsonDecode(event.data);
      _conversationController.addMessage(json);
    });
  }

  void unbindEvent(String eventName) {
    channel.unbind(eventName);
  }

  Future<void> firePusher(String channelName, String eventName) async {
    await initPusher(channelName);
    connectPusher();
    await subscribePusher(channelName);
    bindEvent(eventName);
  }
}
