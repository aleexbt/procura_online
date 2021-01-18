import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:get/instance_manager.dart';
import 'package:hive/hive.dart';
import 'package:procura_online/controllers/orders_controller.dart';
import 'package:procura_online/models/message_model.dart';
import 'package:procura_online/models/order_model.dart';
import 'package:procura_online/models/orders_model.dart';
import 'package:procura_online/models/upload_media_model.dart';
import 'package:uuid/uuid.dart';

BaseOptions options = BaseOptions(
  connectTimeout: 10000,
  receiveTimeout: 3000,
  baseUrl: 'https://procuraonline-dev.pt',
  headers: {"Accept": "application/json", "Content-Type": "application/json"},
);

Dio _dio = Dio(options);
final _dioCacheManager = DioCacheManager(CacheConfig());

class OrdersRepository {
  Future<Orders> findAll({String filter = 'vazio', int page = 1}) async {
    Box authBox = await Hive.openBox('auth');
    String token = authBox.get('token') ?? null;
    _dio.options.headers["Authorization"] = 'Bearer $token';
    Response response = await _dio.get('/api/v1/orders',
        queryParameters: {"filter": "$filter", "page": "$page"});
    return Orders.fromJson(response.data);
  }

  Future<Message> replyOrder(Map<String, dynamic> data) async {
    Box authBox = await Hive.openBox('auth');
    String token = authBox.get('token') ?? null;
    _dio.options.headers["Authorization"] = 'Bearer $token';
    Response response =
        await _dio.post('/api/v1/conversation/send', data: data);
    return response.data['data']['conversation_id'];
  }

  void markOrderAsRead(String orderId) async {
    Box authBox = await Hive.openBox('auth');
    String token = authBox.get('token') ?? null;
    _dio.options.headers["Authorization"] = 'Bearer $token';
    _dio.get('/api/v1/orders/seen/$orderId');
  }

  void markOrderAsSold(String orderId) async {
    Box authBox = await Hive.openBox('auth');
    String token = authBox.get('token') ?? null;
    _dio.options.headers["Authorization"] = 'Bearer $token';
    _dio.get('/api/v1/orders/$orderId/sold');
  }

  Future<Order> createOrder(Map<String, dynamic> data) async {
    Box authBox = await Hive.openBox('auth');
    String token = authBox.get('token') ?? null;
    _dio.options.headers["Authorization"] = 'Bearer $token';
    Response response = await _dio.post('/api/v1/orders', data: data);
    return Order.fromJson(response.data);
  }

  Future<UploadMedia> mediaUpload(File photo) async {
    OrdersController _ordersController = Get.find();
    Box authBox = await Hive.openBox('auth');
    String token = authBox.get('token') ?? null;
    Uuid uuid = Uuid();

    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        photo.path,
        filename: '${uuid.v4()}.jpg',
      ),
    });

    _dio.options.headers["Authorization"] = 'Bearer $token';
    Response response = await _dio.post('/api/v1/orders/media', data: data,
        onSendProgress: (sent, total) {
      _ordersController.uploadImageProgress.value = ((sent / total));
    });
    return UploadMedia.fromJson(response.data);
  }
}
