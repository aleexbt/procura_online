import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:get/instance_manager.dart';
import 'package:hive/hive.dart';
import 'package:procura_online/controllers/create_ad_controller.dart';
import 'package:procura_online/models/listing_model.dart';
import 'package:procura_online/models/product_model.dart';
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
    Box authBox = await Hive.openBox('auth');
    String token = authBox.get('token') ?? null;
    _dio.options.headers["Authorization"] = 'Bearer $token';
    Response response = await _dio.post('/api/v1/listings', data: data);
    return Product.fromJson(response.data);
  }

  Future edit({
    String id,
    List<File> photos,
    List<String> photosToRemove,
    String title,
    String description,
    String brand,
    String model,
    String year,
    String color,
    String engineDisplacement,
    String enginePower,
    String transmission,
    String miliage,
    String numberOfSeats,
    String numberOfDoors,
    String fuelType,
    String condition,
    String price,
    String negotiable,
    String registered,
    String category,
    String subcategory,
  }) async {
    Box authBox = await Hive.openBox('auth');
    String token = authBox.get('token') ?? null;
    Uuid uuid = Uuid();
    MultipartFile mainPhoto;
    List<MultipartFile> photosList = List<MultipartFile>.empty(growable: true);

    if (photos.length > 0) {
      for (File photo in photos) {
        MultipartFile multipartFile = await MultipartFile.fromFile(photo.path, filename: '${uuid.v4()}.jpg');
        photosList.add(multipartFile);
      }
      mainPhoto = await MultipartFile.fromFile(photos[0].path, filename: '${uuid.v4()}.jpg');
    }

    if (photosToRemove.length > 0) {
      photosToRemove.forEach((element) {
        _dio.options.headers["Authorization"] = 'Bearer $token';
        _dio.delete('/api/v1/listings/$id/photos/$element');
      });
    }

    FormData formData = FormData.fromMap({
      "title": title,
      "description": description,
      "make": brand,
      "model": model,
      "year": year,
      "color": color,
      "engine_displacement": engineDisplacement,
      "number_of_seats": numberOfSeats,
      "number_of_doors": numberOfDoors,
      "fuel_type": fuelType,
      "engine_power": enginePower,
      "transmission": transmission,
      "registered": registered,
      "mileage": miliage,
      "condition": condition,
      "price": price,
      "negotiable": negotiable,
      "main_photo": mainPhoto,
      "photos": photosList,
      "categories": [category, subcategory]
    });

    _dio.options.headers["Authorization"] = 'Bearer $token';
    final Response response = await _dio.post('/api/v1/listings/$id?_method=PATCH', data: formData);
    return response.data;
  }

  Future<Listing> productSearch(String category, String term, {int page = 1, String brand, String model}) async {
    var cat = category == 'listings' ? 'vehicles' : category;
    final Response response = await _dio.get('/api/v1/search/$cat',
        queryParameters: {"search": "$term", "makes[0]": "$brand", "model": "$model", "page": "$page"});
    return Listing.fromJson(response.data);
  }

  Future<bool> delete(String productId) async {
    Box authBox = await Hive.openBox('auth');
    String token = authBox.get('token') ?? null;
    _dio.options.headers["Authorization"] = 'Bearer $token';
    Response response = await _dio.delete('/api/v1/listings/$productId');
    return response.data['result'];
  }

  Future<UploadMedia> mediaUpload(File photo) async {
    CreateAdController _createAdController = Get.find();
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
    Response response = await _dio.post('/api/v1/listings/media', data: data, onSendProgress: (sent, total) {
      _createAdController.uploadImageProgress.value = ((sent / total));
    });
    return UploadMedia.fromJson(response.data);
  }
}
