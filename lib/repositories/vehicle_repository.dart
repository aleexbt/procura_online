import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:procura_online/app_settings.dart';
import 'package:procura_online/services/dio_client.dart';

DioClient _dio = DioClient();
final _dioCacheManager = DioCacheManager(CacheConfig());

class VehicleRepository {
  Future<List<String>> getMakers() async {
    DioClient _dio = DioClient(interceptors: [_dioCacheManager.interceptor]);
    Options _cacheOptions = buildCacheOptions(Duration(days: 1));
    Response response = await _dio.get('/$kApiPath/vehicle/makes', options: _cacheOptions);
    if (response.statusCode == 200) {
      return List<String>.from(response.data);
    } else {
      return [];
    }
  }

  Future<List<String>> getModels(String model) async {
    Response response = await _dio.get('/$kApiPath/vehicle/makes/$model');
    if (response.statusCode == 200) {
      return List<String>.from(response.data);
    } else {
      return [];
    }
  }

  Future getCategories() async {
    DioClient _dio = DioClient(interceptors: [_dioCacheManager.interceptor]);
    Options _cacheOptions = buildCacheOptions(Duration(days: 1));
    Response response = await _dio.get('/$kApiPath/listings/main-categories', options: _cacheOptions);
    return response.data;
  }

  Future getSubCategories(String catId) async {
    DioClient _dio = DioClient(interceptors: [_dioCacheManager.interceptor]);
    Options _cacheOptions = buildCacheOptions(Duration(days: 1));
    Response response = await _dio.get('/$kApiPath/listings/sub-categories',
        queryParameters: {"category_id": "$catId"}, options: _cacheOptions);
    return response.data;
  }
}
