import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:procura_online/controllers/chat_controller.dart';
import 'package:procura_online/controllers/conversation_controller.dart';
import 'package:pusher_client/pusher_client.dart';

import '../app_settings.dart';

class PusherService {
  PusherEvent lastEvent;
  String lastConnectionState;
  Channel channel;
  PusherClient pusher;
  String socketId = '';

  Future<void> initPusher(String channelName) async {
    Box authBox = await Hive.openBox('auth') ?? null;
    String token = authBox.get('token') ?? null;
    pusher = PusherClient(
      kPusherToken,
      PusherOptions(
        cluster: kPusherCluster,
        auth: PusherAuth(kPusherAuthUrl, headers: {'authorization': 'Bearer $token'}),
      ),
      enableLogging: kDebugMode,
      autoConnect: true,
    );
  }

  void connectPusher() {
    socketId = pusher.getSocketId();
    // pusher.onConnectionStateChange((state) {
    //   print("previousState: ${state.previousState}, currentState: ${state.currentState}");
    // });
    pusher.onConnectionError((error) {
      print("error: ${error.message}");
    });
  }

  void subscribePusher(String channelName) {
    try {
      channel = pusher.subscribe(channelName);
    } catch (e) {
      print('PUSHER_SUBSCRIBE_ERROR: $e');
    }
  }

  void unSubscribePusher(String channelName) {
    try {
      pusher.unsubscribe(channelName);
    } catch (e) {
      print('PUSHER_UNSUBSCRIBE_ERROR: $e');
    }
  }

  void bindEvent(String eventName) {
    try {
      channel.bind(eventName, (PusherEvent event) {
        if (eventName == 'App\\Events\\ConversationEvent') {
          final ConversationController _conversationController = Get.find();
          Map<String, dynamic> json = jsonDecode(event.data);
          _conversationController.addMessage(json);
        } else if (eventName == 'App\\Events\\ConversationUpdateEvent') {
          final ChatController _chatController = Get.find();
          Map<String, dynamic> json = jsonDecode(event.data);
          _chatController.updateMessages(json['conversation']);
        }
      });
    } catch (e) {
      print('PUSHER_BIND_ERROR: $e');
    }
  }

  void unbindEvent(String eventName) {
    try {
      channel.unbind(eventName);
    } catch (e) {
      print('PUSHER_UNBIND_ERROR: $e');
    }
  }

  Future<void> firePusher(String channelName, String eventName) async {
    await initPusher(channelName);
    connectPusher();
    subscribePusher(channelName);
    bindEvent(eventName);
  }
}
