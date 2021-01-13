import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:procura_online/controllers/conversation_controller.dart';
import 'package:pusher_websocket_flutter/pusher.dart';

class PusherService {
  Event lastEvent;
  String lastConnectionState;
  Channel channel;

  Future<void> initPusher(String channelName) async {
    print('CHANNEL_NAME: $channelName');
    try {
      await Pusher.init(
        'cb7f336d45263a9ab275',
        PusherOptions(
          cluster: 'eu',
          auth: PusherAuth(
            'https://e0f2d168dbe4.ngrok.io/pusher/auth',
            headers: {'channel_name': channelName, 'socket_id': Pusher.getSocketId()},
          ),
        ),
      );
      print("Pusher initialized");
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  void connectPusher() {
    Pusher.connect(onConnectionStateChange: (ConnectionStateChange connectionState) async {
      lastConnectionState = connectionState.currentState;
      print("Pusher connected");
    }, onError: (ConnectionError e) {
      print("Error: ${e.message}");
    });
  }

  Future<void> subscribePusher(String channelName) async {
    channel = await Pusher.subscribe(channelName);
    print("Pusher subscribed to channel");
  }

  void unSubscribePusher(String channelName) {
    Pusher.unsubscribe(channelName);
    print("Pusher unsubscribed from channel");
  }

  void bindEvent(String eventName) {
    channel.bind(eventName, (event) {
      final ConversationController _conversationController = Get.find();
      debugPrint(event.data, wrapWidth: 1024);
      Map<String, dynamic> json = jsonDecode(event.data);
      _conversationController.addMessage(json);
    });
    print("Pusher data binded");
  }

  void unbindEvent(String eventName) {
    channel.unbind(eventName);
    print("Pusher data unbinded");
  }

  Future<void> firePusher(String channelName, String eventName) async {
    await initPusher(channelName);
    connectPusher();
    await subscribePusher(channelName);
    bindEvent(eventName);
  }
}
