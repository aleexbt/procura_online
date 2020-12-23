import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/models/user_model.dart';
import 'package:procura_online/repositories/user_repository.dart';
import 'package:procura_online/utils/navigation_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      String token = prefs.getString('token') ?? null;
      String userData = prefs.getString('userData');
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      UserModel response = await _repository.signIn(email: email, password: password);
      _isLoggedIn.value = true;
      _token.value = response.token;
      // _userData.update((val) {
      //   val.name = response.user.name;
      //   val.email = response.user.email;
      // });
      _userData.value = response.user;
      prefs.setBool('isLoggedIn', true);
      prefs.setString('token', response.token);
      prefs.setString('userData', jsonEncode(response.user));
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
    try {
      _isLoading.value = true;

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn.value = false;
    _userData.value = User();
    prefs.setBool('isLoggedIn', false);
    prefs.setString('userData', null);
    // _pageController.animateToPage(0, duration: Duration(milliseconds: 200), curve: Curves.linear);
    Get.offAllNamed('/');
  }

  void updateUserData(
      {String name, String email, String phone, String company, String address, String postcode}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userData.update((val) {
      val.name = name;
      val.email = email;
      val.phone = phone;
      val.company = company;
      val.address = address;
      val.postcode = postcode;
    });
    prefs.setString('userData', jsonEncode(_userData));
    Get.back();
    Get.rawSnackbar(
        message: 'Profile updated successfully.', backgroundColor: Colors.green, duration: Duration(seconds: 3));
  }

  void changePassword({@required String currentPass, @required String newPass, @required String confirmPass}) async {
    try {
      _isLoading.value = true;
      await _repository.changePassword(
        currentPass: currentPass,
        newPass: newPass,
        confirmPass: confirmPass,
        token: _token.value,
      );
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
