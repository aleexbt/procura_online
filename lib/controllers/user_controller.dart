import 'package:dio/dio.dart' as dio;
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final String baseUrl = 'https://procuraonline-dev.pt/api';

dio.BaseOptions options = dio.BaseOptions(
  connectTimeout: 8000,
  receiveTimeout: 3000,
);

dio.Dio api = dio.Dio(options);
final _dioCacheManager = DioCacheManager(CacheConfig());
//Options _cacheOptions = buildCacheOptions(Duration(hours: 3));

class UserController extends GetxController {
  @override
  onInit() {
    _initSharedPrefs();
    super.onInit();
  }

  _initSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  }

  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  RxBool _loggedIn = false.obs;
  RxString _name = 'Alex'.obs;
  RxString _email = 'alex@example.com'.obs;

  Rx<UserModel> _userData = UserModel().obs;
  UserModel get userData => _userData.value;

  bool get loggedIn => _loggedIn.value;
  String get name => _name.value;
  String get email => _email.value;

  void setUser({bool loggedIn, String name, String email}) {
    _loggedIn.value = loggedIn;
    _name.value = name;
    _email.value = email;
  }

  void signIn({String email, String password}) async {
    try {
      _isLoading.value = true;
      Map<String, dynamic> loginData = {
        "email": email,
        "password": password,
        "device_name": "Android",
      };

      api.options.headers['Content-Type'] = 'application/json';
      api.options.headers['Accept'] = 'application/json';
      dio.Response response = await api.post(baseUrl + '/v1/login', data: loginData);
      UserModel data = UserModel.fromJson(response.data);
      _userData.value = data;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await Future.delayed(Duration(seconds: 2));
      prefs.setBool('isLoggedIn', true);
      _isLoading.value = false;
      Get.offAllNamed('/home');
    } catch (e) {
      print(e);
      Get.rawSnackbar(
          message: 'Ops, something went wrong.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
      _isLoading.value = false;
    }

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await Future.delayed(Duration(seconds: 2));
    // setUser(loggedIn: true, name: 'Authenticated Alex', email: data['email']);
    // prefs.setBool('isLoggedIn', true);
    // _isLoading.value = false;
    // // Get.rawSnackbar(message: 'Ops, something went wrong.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
    // Get.offAllNamed('/home');
  }

  void signUp() async {}

  void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setUser(loggedIn: false, name: 'Unauthenticated User', email: 'unknown@me.com');
    prefs.setBool('isLoggedIn', false);
    Get.offAllNamed('/');
  }
}
