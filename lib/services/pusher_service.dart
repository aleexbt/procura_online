import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:procura_online/controllers/chat_controller.dart';
import 'package:procura_online/controllers/conversation_controller.dart';
import 'package:pusher_client/pusher_client.dart';

class PusherService {
  PusherEvent lastEvent;
  String lastConnectionState;
  Channel channel;
  PusherClient pusher;
  String socketId = '';

  Future<void> initPusher(String channelName) async {
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
  }

  void connectPusher() {
    socketId = pusher.getSocketId();
    pusher.onConnectionStateChange((state) {
      print("previousState: ${state.previousState}, currentState: ${state.currentState}");
    });
    pusher.onConnectionError((error) {
      print("error: ${error.message}");
    });
  }

  void subscribePusher(String channelName) {
    // pusher.unsubscribe(channelName);
    channel = pusher.subscribe(channelName);
  }

  void unSubscribePusher(String channelName) {
    pusher.unsubscribe(channelName);
  }

  void bindEvent(String eventName) {
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
  }

  void unbindEvent(String eventName) {
    channel.unbind(eventName);
  }

  Future<void> firePusher(String channelName, String eventName) async {
    await initPusher(channelName);
    connectPusher();
    subscribePusher(channelName);
    bindEvent(eventName);
  }
}
