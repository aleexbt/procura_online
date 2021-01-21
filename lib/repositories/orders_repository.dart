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

final _dioCacheManager = DioCacheManager(CacheConfig());

class OrdersRepository {
  Future<Orders> findAll({String filter = 'vazio', int page = 1}) async {
    await setToken();
    Response response = await _dio.get('/api/v1/orders', queryParameters: {"filter": "$filter", "page": "$page"});
    return Orders.fromJson(response.data);
  }

  Future<Message> replyOrder(Map<String, dynamic> data) async {
    await setToken();
    Response response = await _dio.post('/api/v1/conversation/send', data: data);
    return response.data['data']['conversation_id'];
  }

  void markOrderAsRead(String orderId) async {
    await setToken();
    _dio.get('/api/v1/orders/seen/$orderId');
  }

  void markOrderAsSold(String orderId) async {
    await setToken();
    _dio.get('/api/v1/orders/$orderId/sold');
  }

  Future<Order> createOrder(Map<String, dynamic> data) async {
    Response response = await _dio.post('/api/v1/orders', data: data);
    return Order.fromJson(response.data);
  }

  Future<UploadMedia> mediaUpload(File photo) async {
    OrdersController _ordersController = Get.find();
    Uuid uuid = Uuid();

    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        photo.path,
        filename: '${uuid.v4()}.jpg',
      ),
    });

    await setToken();
    Response response = await _dio.post('/api/v1/orders/media', data: data, onSendProgress: (sent, total) {
      _ordersController.uploadImageProgress.value = ((sent / total));
    });
    return UploadMedia.fromJson(response.data);
  }
}
