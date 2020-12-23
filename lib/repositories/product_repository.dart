import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
// import 'package:get/get.dart';
import 'package:procura_online/models/product_model.dart';

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

  Future<Products> findOne(String productId) async {
    // _dio.interceptors.add(_dioCacheManager.interceptor);
    // Options _cacheOptions = buildCacheOptions(Duration(minutes: 5));
    final Response response = await _dio.get('/api/v1/listings/$productId');
    return Products.fromJson(response.data['data']);
  }
}
