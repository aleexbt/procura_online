import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

BaseOptions options = BaseOptions(
  connectTimeout: 8000,
  receiveTimeout: 3000,
  baseUrl: 'https://procuraonline-dev.pt',
  headers: {"Accept": "application/json", "Content-Type": "application/json"},
);

class ApiService {
  Dio _dio = Dio(options);
  final _dioCacheManager = DioCacheManager(CacheConfig());
}
