import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:procura_online/models/chat_model.dart';
import 'package:procura_online/utils/prefs.dart';

BaseOptions options = BaseOptions(
  connectTimeout: 8000,
  receiveTimeout: 3000,
  baseUrl: 'https://procuraonline-dev.pt',
  headers: {"Accept": "application/json", "Content-Type": "application/json"},
);

Dio _dio = Dio(options);
final _dioCacheManager = DioCacheManager(CacheConfig());

class ChatRepository {
  Future<ChatModel> findAll({int page = 1}) async {
    String token = Prefs.getString('token') ?? null;
    _dio.options.headers["Authorization"] = 'Bearer $token';
    Response response = await _dio.get('/api/v1/conversation', queryParameters: {"page": "$page"});
    return ChatModel.fromJson(response.data);
  }

  Future<ChatModel> findOne({@required String id, int page = 1}) async {
    String token = Prefs.getString('token') ?? null;
    _dio.options.headers["Authorization"] = 'Bearer $token';
    Response response = await _dio.get('/api/v1/conversation/$id', queryParameters: {"page": "$page"});
    return ChatModel.fromJson(response.data);
  }
}
