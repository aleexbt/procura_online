import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

BaseOptions options = BaseOptions(
  connectTimeout: 8000,
  receiveTimeout: 3000,
  baseUrl: 'https://procuraonline-dev.pt',
  headers: {"Accept": "application/json", "Content-Type": "application/json"},
);

Dio _dio = Dio(options);
final _dioCacheManager = DioCacheManager(CacheConfig());

class VehicleRepository {
  Future<List<String>> getMakers() async {
    _dio.interceptors.add(_dioCacheManager.interceptor);
    Options _cacheOptions = buildCacheOptions(Duration(days: 1));
    Response response =
        await _dio.get('/api/v1/vehicle/makes', options: _cacheOptions);
    if (response.statusCode == 200) {
      return List<String>.from(response.data);
    } else {
      return [];
    }
  }

  Future<List<String>> getModels(String model) async {
    Response response = await _dio.get('/api/v1/vehicle/makes/$model');
    print(response.request.uri);
    if (response.statusCode == 200) {
      return List<String>.from(response.data);
    } else {
      return [];
    }
  }

  Future getCategories() async {
    _dio.interceptors.add(_dioCacheManager.interceptor);
    Options _cacheOptions = buildCacheOptions(Duration(days: 1));
    Response response = await _dio.get('/api/v1/listings/main-categories',
        options: _cacheOptions);
    return response.data;
  }

  Future getSubCategories(String catId) async {
    _dio.interceptors.add(_dioCacheManager.interceptor);
    Options _cacheOptions = buildCacheOptions(Duration(days: 1));
    Response response = await _dio.get('/api/v1/listings/sub-categories',
        queryParameters: {"category_id": "$catId"}, options: _cacheOptions);
    return response.data;
  }
}
