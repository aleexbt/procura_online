import 'dart:convert';

import 'package:get/get.dart';
import 'package:procura_online/controllers/conversation_controller.dart';
import 'package:pusher_client/pusher_client.dart';

class PusherService extends GetxController {
  final ConversationController _conversationController = Get.find();

  Channel channel;
  PusherEvent event;

  PusherClient pusher = PusherClient(
    '839c5518f49da7441ab4',
    PusherOptions(cluster: 'us2'),
    enableLogging: true,
  );

  void connectPusher() {
    pusher.connect();
    pusher.onConnectionStateChange((state) {
      print("previousState: ${state.previousState}, currentState: ${state.currentState}");
    });
    pusher.onConnectionError((error) {
      print("error: ${error.message}");
    });
  }

  void subscribePusher(String channelName) {
    channel = pusher.subscribe(channelName);
    print("Pusher subscribed to channel");
  }

  void unSubscribePusher(String channelName) {
    pusher.unsubscribe(channelName);
    print("Pusher unsubscribed from channel");
  }

  void bindEvent(String eventName) {
    channel.bind(eventName, (event) {
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
    connectPusher();
    subscribePusher(channelName);
    bindEvent(eventName);
  }
}
