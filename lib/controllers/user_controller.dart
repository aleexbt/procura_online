import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:procura_online/controllers/orders_controller.dart';
import 'package:procura_online/models/user_model.dart';
import 'package:procura_online/repositories/user_repository.dart';
import 'package:procura_online/utils/navigation_helper.dart';
import 'package:smart_select/smart_select.dart';

import 'chat_controller.dart';

class UserController extends GetxController with StateMixin<User> {
  UserRepository _userRepository = Get.find();

  @override
  onInit() {
    _initData();
    super.onInit();
  }

  RxBool _isLoading = false.obs;
  RxBool _isSaving = false.obs;
  RxBool _savingError = false.obs;
  RxBool _isLoggedIn = false.obs;
  Rx<User> _userData = User().obs;
  RxString _token = ''.obs;

  bool get isLoading => _isLoading.value;
  bool get isSaving => _isSaving.value;
  bool get savingError => _savingError.value;
  bool get isLoggedIn => _isLoggedIn.value;
  User get userData => _userData.value;
  String get token => _token.value;

  Rx<TextEditingController> name = TextEditingController().obs;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> phone = TextEditingController().obs;
  Rx<TextEditingController> company = TextEditingController().obs;
  Rx<TextEditingController> address = TextEditingController().obs;
  Rx<TextEditingController> postcode = TextEditingController().obs;
  RxString selectedAccountType = ''.obs;
  final List<S2Choice<String>> accountTypeOptions = [
    S2Choice<String>(value: 'company', title: 'Company'),
    S2Choice<String>(value: 'personal', title: 'Personal'),
  ];

  void setAccountType(String value) => selectedAccountType.value = value;

  _initData() async {
    try {
      Box authBox = await Hive.openBox('auth');
      bool isLoggedIn = authBox.get('isLoggedIn') ?? false;
      String token = authBox.get('token') ?? null;
      Box<User> box = await Hive.openBox<User>('userData') ?? null;
      _isLoggedIn.value = isLoggedIn;
      _token.value = token;
      if (box != null) {
        _userData.value = box.values.first;
        selectedAccountType.value = box.values.first.type;
      }
      if (isLoggedIn) {
        updateUserInfo();
      }
    } catch (err) {
      print(err);
    }
  }

  void updateUserInfo() async {
    try {
      User response = await _userRepository.userInfo();
      Box<User> box = await Hive.openBox<User>('userData');
      box.put(response.id, response);
      _userData.value = response;
      selectedAccountType.value = response.type;
    } on DioError catch (err) {
      print('Error updating user information.');
    } catch (err) {
      print('Error updating user information.');
    } finally {}
  }

  void signIn({String email, String password}) async {
    _isLoading.value = true;
    try {
      Map<String, dynamic> loginData = {
        "email": email,
        "password": password,
        "device_name": "Android",
      };

      var response = await _userRepository.signIn(loginData);
      User user = User.fromJson(response['user']);
      Box<User> userBox = await Hive.openBox<User>('userData');
      Box authBox = await Hive.openBox('auth');

      _isLoggedIn.value = true;
      _token.value = response['token'];
      _userData.value = user;

      authBox.put('isLoggedIn', true);
      authBox.put('token', response['token']);
      userBox.put(response['user']['id'], User.fromJson(response['user']));

      Get.offAllNamed('/app');
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

      await _userRepository.signUp(registerData);
      Get.back();
      Get.rawSnackbar(
          message: 'User registered successfully.',
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3));
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
      String response = await _userRepository.passwordReset(email);
      Get.rawSnackbar(
          message: response,
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3));
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
    Box authBox = await Hive.openBox('auth');
    Box<User> userBox = await Hive.openBox<User>('userData');
    authBox.put('isLoggedIn', false);
    userBox.put(_userData.value.id, User());
    Get.delete<OrdersController>(force: true);
    Get.delete<ChatController>(force: true);
    _isLoggedIn.value = false;
    _userData.value = User();
    NavKey.pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.linear);
    Get.back();
  }

  void updateUserData() async {
    _isSaving.value = true;
    try {
      Map<String, dynamic> updateData = {
        'name': name.value.text,
        'email': email.value.text,
        'phone': phone.value.text,
        'company': company.value.text,
        'type': selectedAccountType.value,
        'address': address.value.text,
        'postcode': postcode.value.text
      };

      _userData.update((val) {
        val.name = name.value.text;
        val.email = email.value.text;
        val.phone = phone.value.text;
        val.company = company.value.text;
        val.type = selectedAccountType.value;
        val.address = address.value.text;
        val.postcode = postcode.value.text;
      });

      User response = await _userRepository.update(updateData);
      Box<User> box = await Hive.openBox<User>('userData');
      box.put(response.id, response);

      Get.back();
      Get.rawSnackbar(
          message: 'Profile updated successfully.',
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3));
    } on DioError catch (err) {
      print(err);
      _savingError.value = true;
      Get.rawSnackbar(
          message: 'Ops, error updating profile.',
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3));
    } catch (err) {
      print(err);
      _savingError.value = true;
      Get.rawSnackbar(
          message: 'Ops, error updating profile.',
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3));
    } finally {
      _isSaving.value = false;
    }
  }

  void changePassword(
      {@required String currentPass,
      @required String newPass,
      @required String confirmPass}) async {
    _isLoading.value = true;
    try {
      Map<String, dynamic> passwordData = {
        "old_password": currentPass,
        "new_password": newPass,
        "new_password_confirmation": confirmPass,
      };
      await _userRepository.changePassword(passwordData);
      Get.back();
      Get.rawSnackbar(
          message: 'Password changed successfully.',
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3));
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
