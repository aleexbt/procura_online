import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:procura_online/app_settings.dart';
import 'package:procura_online/services/dio_client.dart';

DioClient _dio = DioClient();

class VehicleRepository {
  Future<List<String>> getMakers() async {
    final _cacheOptions = CacheOptions(
      policy: CachePolicy.request,
      maxStale: const Duration(days: 1),
    );

    Response response = await _dio.get('/$kApiPath/vehicle/makes', options: _cacheOptions.toOptions());
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
    final _cacheOptions = CacheOptions(
      policy: CachePolicy.cacheStoreForce,
      maxStale: const Duration(days: 1),
    );
    Response response = await _dio.get('/$kApiPath/listings/main-categories', options: _cacheOptions.toOptions());
    return response.data;
  }

  Future getSubCategories(String catId) async {
    final _cacheOptions = CacheOptions(
      policy: CachePolicy.cacheStoreForce,
      maxStale: const Duration(days: 1),
    );
    Response response = await _dio.get('/$kApiPath/listings/sub-categories',
        queryParameters: {"category_id": "$catId"}, options: _cacheOptions.toOptions());
    return response.data;
  }
}
