import 'package:hive/hive.dart';
import 'package:procura_online/models/conversation_model.dart';
import 'package:procura_online/models/message_media.dart';
import 'package:procura_online/models/message_model.dart';
import 'package:procura_online/models/order_media.dart';
import 'package:procura_online/models/order_model.dart';
import 'package:procura_online/models/user_model.dart';

class HiveAdapters {
  static register() {
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(MessageAdapter());
    Hive.registerAdapter(ConversationAdapter());
    Hive.registerAdapter(OrderAdapter());
    Hive.registerAdapter(OrderMediaAdapter());
    Hive.registerAdapter(MessageMediaAdapter());
  }
}
