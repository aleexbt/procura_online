import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/models/user_model.dart';
import 'package:procura_online/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController with StateMixin<UserModel> {
  UserRepository _repository = Get.find();

  @override
  onInit() {
    _initSharedPrefs();
    super.onInit();
  }

  _initSharedPrefs() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      String userData = prefs.getString('userData');
      _isLoggedIn.value = isLoggedIn;
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

  bool get isLoading => _isLoading.value;
  bool get isLoggedIn => _isLoggedIn.value;
  User get userData => _userData.value;

  void signIn({String email, String password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoading.value = true;
    _repository.signIn(email: email, password: password).then((res) {
      change(res, status: RxStatus.success());
      _isLoggedIn.value = true;
      _isLoading.value = false;
      _userData.update((val) {
        val.name = res.user.name;
        val.email = res.user.email;
      });
      prefs.setBool('isLoggedIn', true);
      prefs.setString('token', res.token);
      prefs.setString('userData', jsonEncode(res.user));
      Get.offAndToNamed('/');
    }, onError: (err) {
      print(err);
      _isLoading.value = false;
      Get.rawSnackbar(
          message: 'Ops, something went wrong.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
      change(null, status: RxStatus.error('Ops, something went wrong.'));
    });
  }

  void signUp() {
    _isLoading.value = true;
    _repository.signUp().then((res) {
      change(res, status: RxStatus.success());
      _isLoading.value = false;
    }, onError: (err) {
      _isLoading.value = false;
      change(null, status: RxStatus.error('Ops, something went wrong.'));
    });
  }

  void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn.value = false;
    prefs.setBool('isLoggedIn', false);
    Get.offAndToNamed('/');
  }

  void updateUserData({bool loggedIn, String name, String email}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn.value = loggedIn;
    _userData.update((val) {
      val.name = name;
      val.email = email;
    });
    prefs.setString('userData', jsonEncode(_userData));
  }
}
