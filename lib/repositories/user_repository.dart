import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/models/auth_error_model.dart';
import 'package:procura_online/models/user_model.dart';
import 'package:procura_online/screens/auth/user_controller.dart';

BaseOptions options = BaseOptions(
  connectTimeout: 8000,
  receiveTimeout: 3000,
  baseUrl: 'https://procuraonline-dev.pt',
  headers: {"Accept": "application/json", "Content-Type": "application/json"},
);

Dio _dio = Dio(options);
final _dioCacheManager = DioCacheManager(CacheConfig());

class UserRepository {
  // UserController _userController = Get.find();
  @override
  void onInit() {}

  // Future<UserModel> signIn({String email, String password}) async {
  //   Map<String, dynamic> loginData = {
  //     "email": email,
  //     "password": password,
  //     "device_name": "Android",
  //   };
  //   final response = await post<UserModel>('/api/v1/login', loginData, decoder: (response) {
  //     return UserModel.fromJson(response ?? null);
  //   });
  //   if (response.hasError) {
  //     Get.rawSnackbar(
  //         message: 'Ops, something went wrong.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
  //   }
  //   return response.body;
  // }

  Future<UserModel> signIn({String email, String password}) async {
    Map<String, dynamic> loginData = {
      "email": email,
      "password": password,
      "device_name": "Android",
    };
    final response = await _dio.post('/api/v1/login', data: loginData);

    // print(response.data);

    if (response.statusCode != 200) {
      return null;
    }
    return UserModel.fromJson(response.data);
  }

  Future<UserModel> signUp() async {}

  // Future<UserModel> signUp() async {
  //   Map<String, dynamic> registerData = {
  //     "name": "Alex DEV",
  //     "email": "alex@gmail.com",
  //     "phone": "+55123456789",
  //     "password": "12345678",
  //     "type": "company",
  //     "company": "const LLC",
  //     "district_id": 1,
  //     "city_id": 1,
  //     "address": "Example Address",
  //     "postcode": "90210"
  //   };

  //   final response = await post<UserModel>('/api/v1/register', registerData,
  //       decoder: (response) {
  //     return UserModel.fromJson(response);
  //   });

  //   if (response.hasError) {
  //     AuthError errMsg = AuthError.fromJson(json.decode(response.bodyString));

  //     String errName =
  //         errMsg.errors.name.length > 0 ? '${errMsg.errors.name[0]}\n' : '';
  //     String errEmail =
  //         errMsg.errors.email.length > 0 ? '${errMsg.errors.email[0]}\n' : '';
  //     String errPhone =
  //         errMsg.errors.phone.length > 0 ? '${errMsg.errors.phone[0]}\n' : '';

  //     print(errName);

  //     Get.rawSnackbar(
  //         title: errMsg.message,
  //         message: '$errName$errEmail$errPhone',
  //         messageText: Column(
  //           children: [
  //             Text('xxxx'),
  //           ],
  //         ),
  //         backgroundColor: Colors.red,
  //         duration: Duration(seconds: 3));
  //   }

  //   return response.body;
  // }

  Future<void> changePassword({
    @required String currentPass,
    @required String newPass,
    @required String confirmPass,
    @required String token,
  }) async {
    Map<String, dynamic> passwordData = {
      "old_password": currentPass,
      "new_password": newPass,
      "new_password_confirmation": confirmPass,
    };
    _dio.options.headers["Authorization"] = 'Bearer $token';
    final response =
        await _dio.post('/api/v1/change-password', data: passwordData);

    print(response.data);

    if (response.statusCode != 200) {
      return null;
    } else {
      return response.data;
    }
  }
}
