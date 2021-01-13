import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:procura_online/controllers/conversation_controller.dart';
import 'package:pusher_websocket_flutter/pusher.dart';

class PusherService {
  Event lastEvent;
  String lastConnectionState;
  Channel channel;

  Future<void> initPusher() async {
    try {
      await Pusher.init('839c5518f49da7441ab4', PusherOptions(cluster: 'us2'),
          enableLogging: true);
      print("Pusher initialized");
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  void connectPusher() {
    Pusher.connect(
        onConnectionStateChange: (ConnectionStateChange connectionState) async {
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
    await initPusher();
    connectPusher();
    await subscribePusher(channelName);
    bindEvent(eventName);
  }
}
