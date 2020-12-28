import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/controllers/orders_controller.dart';
import 'package:procura_online/models/user_model.dart';
import 'package:procura_online/repositories/user_repository.dart';
import 'package:procura_online/utils/navigation_helper.dart';
import 'package:procura_online/utils/prefs.dart';

import 'chat_controller.dart';

class UserController extends GetxController with StateMixin<UserModel> {
  UserRepository _repository = Get.find();
  // OrdersController _ordersController = Get.find();
  PageController _pageController = NavKey.pageController;

  @override
  onInit() {
    _initSharedPrefs();
    super.onInit();
  }

  _initSharedPrefs() async {
    try {
      bool isLoggedIn = Prefs.getBool('isLoggedIn') ?? false;
      String token = Prefs.getString('token') ?? null;
      String userData = Prefs.getString('userData');
      _isLoggedIn.value = isLoggedIn;
      _token.value = token;
      if (userData != null) {
        var decoded = jsonDecode(userData) as Map<String, dynamic>;
        _userData.value = User.fromJson(decoded);
      }
    } catch (err) {
      print(err);
    }
  }

  RxBool _isLoading = false.obs;
  RxBool _isLoggedIn = false.obs;
  Rx<User> _userData = User().obs;
  RxString _token = ''.obs;

  bool get isLoading => _isLoading.value;
  bool get isLoggedIn => _isLoggedIn.value;
  User get userData => _userData.value;
  String get token => _token.value;

  void signIn({String email, String password}) async {
    _isLoading.value = true;
    try {
      Map<String, dynamic> loginData = {
        "email": email,
        "password": password,
        "device_name": "Android",
      };

      UserModel response = await _repository.signIn(loginData);
      _isLoggedIn.value = true;
      _token.value = response.token;
      _userData.value = response.user;
      Prefs.setBool('isLoggedIn', true);
      Prefs.setString('token', response.token);
      Prefs.setString('userData', jsonEncode(response.user));
      Get.offAllNamed('/');
    } on DioError catch (err) {
      Map<String, dynamic> errors = err.response.data['errors'];
      List<String> errorList = [];

      errors.forEach((key, value) {
        errorList.add(value[0]);
      });

      Get.rawSnackbar(
          message: errorList.join('\n'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3 + errorList.length));
    } finally {
      _isLoading.value = false;
    }
  }

  void signUp(
      {String name,
      String email,
      String phone,
      String password,
      String type,
      String company,
      String address,
      String postcode}) async {
    _isLoading.value = true;
    try {
      Map<String, dynamic> registerData = {
        "name": name ?? "TEST 1",
        "email": email ?? "alex@gmail.com",
        "phone": phone ?? "+55123456789",
        "password": password ?? "12345678",
        "type": "personal",
        "company": "Acme Inc",
        "district_id": 1,
        "city_id": 1,
        "address": address ?? "Example Address",
        "postcode": postcode ?? "90210"
      };

      await _repository.signUp(registerData);
      Get.back();
      Get.rawSnackbar(
          message: 'User registered successfully.', backgroundColor: Colors.green, duration: Duration(seconds: 3));
    } on DioError catch (err) {
      Map<String, dynamic> errors = err.response.data['errors'];
      List<String> errorList = [];

      errors.forEach((key, value) {
        errorList.add(value[0]);
      });

      Get.rawSnackbar(
          message: errorList.join('\n'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3 + errorList.length));
    } finally {
      _isLoading.value = false;
    }
  }

  void passwordReset(String email) async {
    _isLoading.value = true;
    try {
      String response = await _repository.passwordReset(email);
      Get.rawSnackbar(message: response, backgroundColor: Colors.green, duration: Duration(seconds: 3));
    } on DioError catch (err) {
      Map<String, dynamic> errors = err.response.data['errors'];
      List<String> errorList = [];

      errors.forEach((key, value) {
        errorList.add(value[0]);
      });

      Get.rawSnackbar(
          message: errorList.join('\n'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3 + errorList.length));
    } finally {
      _isLoading.value = false;
    }
  }

  void logOut() async {
    _isLoggedIn.value = false;
    _userData.value = User();
    Prefs.setBool('isLoggedIn', false);
    Prefs.setString('userData', null);
    // _pageController.animateToPage(0, duration: Duration(milliseconds: 200), curve: Curves.linear);
    Get.delete<OrdersController>(force: true);
    Get.delete<ChatController>(force: true);
    Get.offAllNamed('/');
  }

  void updateUserData(
      {String name, String email, String phone, String company, String address, String postcode}) async {
    _userData.update((val) {
      val.name = name;
      val.email = email;
      val.phone = phone;
      val.company = company;
      val.address = address;
      val.postcode = postcode;
    });
    Prefs.setString('userData', jsonEncode(_userData));
    Get.back();
    Get.rawSnackbar(
        message: 'Profile updated successfully.', backgroundColor: Colors.green, duration: Duration(seconds: 3));
  }

  void changePassword({@required String currentPass, @required String newPass, @required String confirmPass}) async {
    _isLoading.value = true;
    try {
      Map<String, dynamic> passwordData = {
        "old_password": currentPass,
        "new_password": newPass,
        "new_password_confirmation": confirmPass,
      };
      await _repository.changePassword(passwordData);
      Get.back();
      Get.rawSnackbar(
          message: 'Password changed successfully.', backgroundColor: Colors.green, duration: Duration(seconds: 3));
    } on DioError catch (err) {
      Map<String, dynamic> errors = err.response.data['errors'];
      List<String> errorList = [];

      errors.forEach((key, value) {
        errorList.add(value[0]);
      });

      Get.rawSnackbar(
          message: errorList.join('\n'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3 + errorList.length));
    } finally {
      _isLoading.value = false;
    }
  }
}
