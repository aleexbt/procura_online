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
  // @override
  // void onInit() {
  //   httpClient.baseUrl = 'https://procuraonline-dev.pt';
  //   httpClient.addRequestModifier((request) {
  //     request.headers['Accept'] = 'application/json';
  //     request.headers['Content-Type'] = 'application/json';
  //     return request;
  //   });
  // }

  // Future<ProductModel> findAll({int page = 1}) async {
  //   final response = await get<ProductModel>('/api/v1/listings', query: {"page": "$page"}, decoder: (response) {
  //     return ProductModel.fromJson(response);
  //   });
  //   print(response.request.url);
  //   if (response.hasError) {
  //     print('REPOSITORY_ERROR: Error getting information from server.');
  //   }
  //   return response.body;
  // }

  Future<ProductModel> findAll({int page = 1}) async {
    final Response response = await _dio.get('/api/v1/listings', queryParameters: {"page": "$page"});
    if (response.statusCode == 200) {
      return ProductModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  // Future<Products> findOne(String productId) async {
  //   final response = await get<Products>('/api/v1/listings/$productId', decoder: (response) {
  //     return Products.fromJson(response['data'] ?? null);
  //   });
  //
  //   if (response.hasError) {
  //     print('REPOSITORY_ERROR: Error getting information from server.');
  //   }
  //   return response.body;
  // }

  Future<Products> findOne(String productId) async {
    // _dio.interceptors.add(_dioCacheManager.interceptor);
    // Options _cacheOptions = buildCacheOptions(Duration(minutes: 5));
    final Response response = await _dio.get('/api/v1/listings/$productId');
    if (response.statusCode == 200) {
      return Products.fromJson(response.data['data']);
    } else {
      return null;
    }
  }
}
