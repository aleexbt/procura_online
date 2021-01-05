import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:procura_online/models/media_upload_model.dart';
import 'package:procura_online/models/order_reply_model.dart' hide Order;
import 'package:procura_online/models/orders_model.dart';
import 'package:procura_online/utils/prefs.dart';
import 'package:uuid/uuid.dart';

BaseOptions options = BaseOptions(
  connectTimeout: 8000,
  receiveTimeout: 3000,
  baseUrl: 'https://procuraonline-dev.pt',
  headers: {"Accept": "application/json", "Content-Type": "application/json"},
);

Dio _dio = Dio(options);
final _dioCacheManager = DioCacheManager(CacheConfig());

class OrdersRepository {
  Future<OrdersModel> findAll({String filter = 'vazio', int page = 1}) async {
    String token = Prefs.getString('token') ?? null;
    _dio.options.headers["Authorization"] = 'Bearer $token';
    Response response = await _dio.get('/api/v1/orders', queryParameters: {"filter": "$filter", "page": "$page"});
    print(response.request.uri);
    return OrdersModel.fromJson(response.data);
  }

  Future<OrderReplyModel> replyOrder(Map<String, dynamic> data) async {
    String token = Prefs.getString('token') ?? null;
    _dio.options.headers["Authorization"] = 'Bearer $token';
    Response response = await _dio.post('/api/v1/conversation/send', data: data);
    print('replying...');
    return OrderReplyModel.fromJson(response.data);
  }

  Future<Order> createOrder(Map<String, dynamic> data) async {
    String token = Prefs.getString('token') ?? null;
    _dio.options.headers["Authorization"] = 'Bearer $token';
    Response response = await _dio.post('/api/v1/orders', data: data);
    return Order.fromJson(response.data);
  }

  Future<MediaUploadModel> mediaUpload(File photo) async {
    String token = Prefs.getString('token') ?? null;
    Uuid uuid = Uuid();

    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        photo.path,
        filename: '${uuid.v4()}.jpg',
      ),
    });

    _dio.options.headers["Authorization"] = 'Bearer $token';
    Response response = await _dio.post('/api/v1/orders/media', data: data, onSendProgress: (sent, total) {
      print(((sent / total) * 100).round());
    });
    print(response.data);
    return MediaUploadModel.fromJson(response.data);
  }
}
