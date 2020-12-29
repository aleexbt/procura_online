import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
// import 'package:get/get.dart';
import 'package:procura_online/models/product_model.dart';
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

class ProductRepository {
  Future<ProductModel> findAll({int page = 1}) async {
    final Response response = await _dio.get('/api/v1/listings', queryParameters: {"page": "$page"});
    return ProductModel.fromJson(response.data);
  }

  Future<Product> findOne(String productId) async {
    // _dio.interceptors.add(_dioCacheManager.interceptor);
    // Options _cacheOptions = buildCacheOptions(Duration(minutes: 5));
    final Response response = await _dio.get('/api/v1/listings/$productId');
    return Product.fromJson(response.data['data']);
  }

  Future<Product> create({
    List<File> photos,
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
  }) async {
    String token = Prefs.getString('token') ?? null;
    Uuid uuid = Uuid();
    MultipartFile mainPhoto;
    List<MultipartFile> photosList = List<MultipartFile>();

    if (photos.length > 0) {
      for (File photo in photos) {
        MultipartFile multipartFile = await MultipartFile.fromFile(photo.path, filename: '${uuid.v4()}.jpg');
        photosList.add(multipartFile);
      }
      mainPhoto = await MultipartFile.fromFile(photos[0].path, filename: '${uuid.v4()}.jpg');
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
      "categories": ["1", "2"],
      "main_photo": mainPhoto,
      "photos": photosList
    });

    _dio.options.headers["Authorization"] = 'Bearer $token';
    final Response response = await _dio.post('/api/v1/listings', data: formData);

    return Product.fromJson(response.data);
  }

  Future<ProductModel> productSearch(String category, String term, {int page = 1}) async {
    final Response response =
        await _dio.get('/api/v1/search/$category', queryParameters: {"search": "$term", "page": "$page"});
    return ProductModel.fromJson(response.data);
  }
}
