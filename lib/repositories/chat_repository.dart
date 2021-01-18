import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:hive/hive.dart';
import 'package:procura_online/models/chats_model.dart';
import 'package:procura_online/models/message_model.dart';
import 'package:procura_online/models/new_conversation_model.dart';

BaseOptions options = BaseOptions(
  connectTimeout: 10000,
  receiveTimeout: 3000,
  baseUrl: 'https://procuraonline-dev.pt',
  headers: {"Accept": "application/json", "Content-Type": "application/json"},
);

Dio _dio = Dio(options);
final _dioCacheManager = DioCacheManager(CacheConfig());

class ChatRepository {
  Future<Chats> findAll({int page = 1}) async {
    Box authBox = await Hive.openBox('auth');
    String token = authBox.get('token') ?? null;
    _dio.options.headers["Authorization"] = 'Bearer $token';
    Response response = await _dio
        .get('/api/v1/conversation', queryParameters: {"page": "$page"});
    return Chats.fromJson(response.data);
  }

  Future<NewConversationModel> findOne(String chatId) async {
    Box authBox = await Hive.openBox('auth');
    String token = authBox.get('token') ?? null;
    _dio.options.headers["Authorization"] = 'Bearer $token';
    Response response = await _dio.get('/api/v1/conversation/$chatId');
    return NewConversationModel.fromJson(response.data['data']);
  }

  Future<Message> replyMessage(Map<String, dynamic> data) async {
    Box authBox = await Hive.openBox('auth');
    String token = authBox.get('token') ?? null;
    _dio.options.headers["Authorization"] = 'Bearer $token';
    Response response =
        await _dio.post('/api/v1/conversation/send', data: data);
    return Message.fromJson(response.data['data']);
  }

  void markMessageAsRead(String chatId) async {
    Box authBox = await Hive.openBox('auth');
    String token = authBox.get('token') ?? null;
    _dio.options.headers["Authorization"] = 'Bearer $token';
    _dio.post('/api/v1/conversation/$chatId/seen');
  }

  Future muteConversation(String conversationId) async {
    Box authBox = await Hive.openBox('auth');
    String token = authBox.get('token') ?? null;
    _dio.options.headers["Authorization"] = 'Bearer $token';
    Response response =
        await _dio.post('/api/v1/conversation/$conversationId/mute');
    return response.data;
  }

  Future deleteConversation(String conversationId) async {
    Box authBox = await Hive.openBox('auth');
    String token = authBox.get('token') ?? null;
    _dio.options.headers["Authorization"] = 'Bearer $token';
    Response response =
        await _dio.delete('/api/v1/conversation/$conversationId');
    return response.data;
  }
}
