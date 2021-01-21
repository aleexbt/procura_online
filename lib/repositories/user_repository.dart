import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:hive/hive.dart';
import 'package:procura_online/models/listing_model.dart';
import 'package:procura_online/models/user_model.dart';
import 'package:procura_online/services/dio_client.dart';

DioClient _dio = DioClient();

Future<void> setToken() async {
  Box authBox = await Hive.openBox('auth') ?? null;
  String token = authBox.get('token') ?? null;
  if (token != null) {
    _dio = DioClient(token: token);
  }
}

final _dioCacheManager = DioCacheManager(CacheConfig());

class UserRepository {
  Future<User> userInfo() async {
    await setToken();
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

  Future<User> update(Map<String, dynamic> updateData) async {
    await setToken();
    final response = await _dio.post('/api/v1/user/me/update', data: updateData);
    return User.fromJson(response.data);
  }

  Future<void> changePassword(Map<String, dynamic> passwordData) async {
    await setToken();
    final response = await _dio.post('/api/v1/change-password', data: passwordData);

    if (response.statusCode != 200) {
      return null;
    } else {
      return response.data;
    }
  }

  Future<Listing> adsListing({page = 1}) async {
    await setToken();
    final response = await _dio.get('/api/v1/user/me/listings', queryParameters: {"page": "$page"});
    return Listing.fromJson(response.data);
  }
}
