import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:hive/hive.dart';
import 'package:procura_online/app_settings.dart';
import 'package:procura_online/controllers/conversation_controller.dart';
import 'package:procura_online/models/chats_model.dart';
import 'package:procura_online/models/conversation_model.dart';
import 'package:procura_online/models/message_model.dart';
import 'package:procura_online/models/upload_media_model.dart';
import 'package:procura_online/services/dio_client.dart';
import 'package:uuid/uuid.dart';

DioClient _dio = DioClient();

Future<void> setToken() async {
  Box authBox = await Hive.openBox('auth') ?? null;
  String token = authBox.get('token') ?? null;
  if (token != null) {
    _dio = DioClient(token: token);
  }
}

class ChatRepository {
  Future<Chats> findAll({int page = 1}) async {
    await setToken();
    Response response = await _dio.get('/$kApiPath/conversation', queryParameters: {"page": "$page"});
    return Chats.fromJson(response.data);
  }

  Future<Conversation> findOne(String chatId) async {
    await setToken();
    Response response = await _dio.get('/$kApiPath/conversation/$chatId');
    return Conversation.fromJson(response.data['data']);
  }

  Future<Message> replyMessage(Map<String, dynamic> data) async {
    await setToken();
    Response response = await _dio.post('/$kApiPath/conversation/send', data: data);
    return Message.fromJson(response.data['data']);
  }

  void markMessageAsRead(String chatId) async {
    await setToken();
    _dio.post('/$kApiPath/conversation/$chatId/seen');
  }

  Future muteConversation(String conversationId) async {
    await setToken();
    Response response = await _dio.post('/$kApiPath/conversation/$conversationId/mute');
    return response.data;
  }

  Future unmuteConversation(String conversationId) async {
    await setToken();
    Response response = await _dio.post('/$kApiPath/conversation/$conversationId/unmute');
    return response.data;
  }

  Future deleteConversation(String conversationId) async {
    await setToken();
    Response response = await _dio.delete('/$kApiPath/conversation/$conversationId');
    return response.data;
  }

  Future<UploadMedia> mediaUpload(File photo) async {
    ConversationController _conversationController = Get.find();
    Uuid uuid = Uuid();

    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        photo.path,
        filename: '${uuid.v4()}.jpg',
      ),
    });

    await setToken();
    Response response =
        await _dio.post('/$kApiPath/conversation/send/media', data: data, onSendProgress: (sent, total) {
      _conversationController.uploadImageProgress.value = ((sent / total));
    });
    return UploadMedia.fromJson(response.data);
  }
}
