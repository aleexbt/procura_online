import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:procura_online/controllers/conversation_controller.dart';
import 'package:pusher_client/pusher_client.dart';

class PusherService {
  PusherEvent lastEvent;
  String lastConnectionState;
  Channel channel;
  PusherClient pusher;
  String socketId = '';

  Future<void> initPusher(String channelName) async {
    print('INIT_PUSHER_START');
    // Box authBox = await Hive.openBox('auth') ?? null;
    // String token = authBox.get('token') ?? null;
    pusher = PusherClient(
      'cb7f336d45263a9ab275',
      PusherOptions(
        cluster: 'eu',
        auth: PusherAuth(
          'https://xelapps-validation.herokuapp.com/pusher/auth',
          headers: {'channel_name': '$channelName', 'socket_id': '$socketId'},
        ),
      ),
      enableLogging: true,
      autoConnect: true,
    );
    print('PUSHER_INIT_END');
  }

  void connectPusher() {
    // pusher.connect();
    socketId = pusher.getSocketId();
    print('SOCKET_ID_fim: $socketId');
    pusher.onConnectionStateChange((state) {
      print("previousState: ${state.previousState}, currentState: ${state.currentState}");
    });
    pusher.onConnectionError((error) {
      print("error: ${error.message}");
    });
  }

  void subscribePusher(String channelName) {
    pusher.unsubscribe(channelName);
    channel = pusher.subscribe(channelName);
  }

  void unSubscribePusher(String channelName) {
    pusher.unsubscribe(channelName);
    print('PUSHER_UNSUBSCRIBE');
  }

  void bindEvent(String eventName) {
    channel.bind(eventName, (PusherEvent event) {
      print('EVENT_RECEIVED');
      debugPrint(event.data, wrapWidth: 1024);
      final ConversationController _conversationController = Get.find();
      Map<String, dynamic> json = jsonDecode(event.data);
      _conversationController.addMessage(json);
    });
  }

  void unbindEvent(String eventName) {
    channel.unbind(eventName);
    print('PUSHER_UNBIND');
  }

  Future<void> firePusher(String channelName, String eventName) async {
    print('FIRE_PUSHER');
    await initPusher(channelName);
    connectPusher();
    subscribePusher(channelName);
    bindEvent(eventName);
  }
}
