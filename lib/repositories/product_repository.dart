import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:get/instance_manager.dart';
import 'package:hive/hive.dart';
import 'package:procura_online/controllers/create_ad_controller.dart';
import 'package:procura_online/controllers/edit_ad_controller.dart';
import 'package:procura_online/models/listing_model.dart';
import 'package:procura_online/models/product_model.dart';
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

class ProductRepository {
  Future<Listing> findAll({String category = 'listings', int page = 1}) async {
    final Response response = await _dio.get('/api/v1/$category', queryParameters: {"page": "$page"});
    return Listing.fromJson(response.data);
  }

  Future<Product> findOne(String productId) async {
    // _dio.interceptors.add(_dioCacheManager.interceptor);
    // Options _cacheOptions = buildCacheOptions(Duration(minutes: 5));
    final Response response = await _dio.get('/api/v1/listings/$productId');
    return Product.fromJson(response.data['data']);
  }

  Future<Product> create(Map<String, dynamic> data) async {
    await setToken();
    Response response = await _dio.post('/api/v1/listings', data: data);
    return Product.fromJson(response.data);
  }

  Future edit({String id, Map<String, dynamic> data, List<String> photosToRemove}) async {
    await setToken();

    if (photosToRemove.length > 0) {
      photosToRemove.forEach((photoId) {
        setToken();
        _dio.delete('/api/v1/listings/$id/photos/$photoId');
      });
    }

    final Response response = await _dio.post('/api/v1/listings/$id?_method=PATCH', data: data);
    return response.data;
  }

  Future<Listing> productSearch(String category, String term, {int page = 1, String brand, String model}) async {
    var cat = category == 'listings' ? 'vehicles' : category;
    final Response response = await _dio.get('/api/v1/search/$cat',
        queryParameters: {"search": "$term", "makes[0]": "$brand", "model": "$model", "page": "$page"});
    return Listing.fromJson(response.data);
  }

  Future<bool> delete(String productId) async {
    await setToken();
    Response response = await _dio.delete('/api/v1/listings/$productId');
    return response.data['result'];
  }

  Future<UploadMedia> mediaUpload(File photo) async {
    CreateAdController _createAdController = Get.find();
    Uuid uuid = Uuid();

    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        photo.path,
        filename: '${uuid.v4()}.jpg',
      ),
    });

    await setToken();
    Response response = await _dio.post('/api/v1/listings/media', data: data, onSendProgress: (sent, total) {
      _createAdController.uploadImageProgress.value = ((sent / total));
    });
    return UploadMedia.fromJson(response.data);
  }

  Future<UploadMedia> mediaUploadEditor(File photo) async {
    EditAdController _editAdController = Get.find();
    Uuid uuid = Uuid();

    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        photo.path,
        filename: '${uuid.v4()}.jpg',
      ),
    });

    await setToken();
    Response response = await _dio.post('/api/v1/listings/media', data: data, onSendProgress: (sent, total) {
      _editAdController.uploadImageProgress.value = ((sent / total));
    });
    return UploadMedia.fromJson(response.data);
  }
}
