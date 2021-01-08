import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:procura_online/models/user_model.dart';
import 'package:procura_online/utils/prefs.dart';

BaseOptions options = BaseOptions(
  connectTimeout: 8000,
  receiveTimeout: 3000,
  baseUrl: 'https://procuraonline-dev.pt',
  headers: {"Accept": "application/json", "Content-Type": "application/json"},
);

Dio _dio = Dio(options);
final _dioCacheManager = DioCacheManager(CacheConfig());

class UserRepository {
  Future<User> userInfo() async {
    String token = Prefs.getString('token') ?? null;
    _dio.options.headers["Authorization"] = 'Bearer $token';
    Response response = await _dio.get('/api/v1/user');
    return User.fromJson(response.data);
  }

  Future signIn(Map<String, dynamic> loginData) async {
    final response = await _dio.post('/api/v1/login', data: loginData);
    return response.data;
  }

  Future<User> signUp(Map<String, dynamic> registerData) async {
    final response = await _dio.post('/api/v1/register', data: registerData);
    if (response.statusCode == 201) {
      return User.fromJson(response.data);
    }
    return response.data;
  }

  Future<String> passwordReset(String email) async {
    final response = await _dio.post('/api/v1/forgot-password', data: email);
    if (response.statusCode == 200) {
      return response.data['message'];
    }
    return response.data;
  }

  Future<void> changePassword(Map<String, dynamic> passwordData) async {
    String token = Prefs.getString('token') ?? null;
    _dio.options.headers["Authorization"] = 'Bearer $token';
    final response = await _dio.post('/api/v1/change-password', data: passwordData);

    if (response.statusCode != 200) {
      return null;
    } else {
      return response.data;
    }
  }
}
