import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:hive/hive.dart';
import 'package:procura_online/models/listing_model.dart';
import 'package:procura_online/models/plan_model.dart';
import 'package:procura_online/models/profile_model.dart';
import 'package:procura_online/models/user_model.dart';
import 'package:procura_online/services/dio_client.dart';
import 'package:uuid/uuid.dart';

DioClient _dio = DioClient();

Future<void> setToken() async {
  Box authBox = await Hive.openBox('auth') ?? null;
  String token = authBox.get('token') ?? null;
  if (token != null) {
    _dio = DioClient(token: token);
  }
}

final _dioCacheManager = DioCacheManager(CacheConfig());

enum UploadType { cover, logo }

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

  Future<User> updateProfile(Map<String, dynamic> updateData) async {
    await setToken();
    final response = await _dio.post('/api/v1/user/me/update', data: updateData);
    return User.fromJson(response.data);
  }

  Future<User> updateBilling(Map<String, dynamic> updateData) async {
    await setToken();
    final response = await _dio.post('/api/v1/user/me/billing/update', data: updateData);
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

  Future setPushToken(String playerId) async {
    await setToken();
    final response = await _dio.post('/api/v1/set-token', data: {"token": "$playerId"});
    return response.data;
  }

  Future<List> getSkills() async {
    final response = await _dio.get('/api/v1/skills');
    return response.data;
  }

  Future<List> getDistricts() async {
    DioClient _dio = DioClient(interceptors: [_dioCacheManager.interceptor]);
    Options _cacheOptions = buildCacheOptions(Duration(days: 365));
    final response = await _dio.get('/api/v1/districts', options: _cacheOptions);
    return response.data;
  }

  Future<List> getCities(int districtId) async {
    DioClient _dio = DioClient(interceptors: [_dioCacheManager.interceptor]);
    Options _cacheOptions = buildCacheOptions(Duration(days: 365));
    final response =
        await _dio.get('/api/v1/cities', queryParameters: {"district_id": "$districtId"}, options: _cacheOptions);
    return response.data;
  }

  Future<List<Plan>> getPlans() async {
    final response = await _dio.get('/api/v1/plans');
    List<Plan> plans = List<Plan>.from(response.data.map((plan) => Plan.fromJson(plan)));
    return plans;
  }

  Future<bool> checkSubscription(String feature) async {
    await setToken();
    final response = await _dio.get('/api/v1/check-subscription', queryParameters: {"feature": "$feature"});
    if (response.data['can']) {
      return true;
    } else {
      return false;
    }
  }

  Future<Profile> getProfile(int id) async {
    final response = await _dio.get('/api/v1/listings/company-profile/$id');
    return Profile.fromJson(response.data);
  }

  Future deleteAccount() async {
    await setToken();
    final response = await _dio.delete('/api/v1/user/me/destroy');
    return response.data;
  }

  Future<String> uploadCoverLogo(File image, UploadType type) async {
    await setToken();
    Uuid uuid = Uuid();
    String upload = type == UploadType.cover ? 'cover' : 'logo';

    FormData data = FormData.fromMap({
      "$upload": await MultipartFile.fromFile(
        image.path,
        filename: '${uuid.v4()}.jpg',
      ),
    });

    Response response = await _dio.post('/api/v1/user/me/update', data: data, onSendProgress: (sent, total) {
      // _createAdController.uploadImageProgress.value = ((sent / total));
    });

    User userData = User.fromJson(response.data);

    if (type == UploadType.cover) {
      return userData.cover.url;
    } else {
      return userData.logo.thumbnail;
    }
  }
}
