import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:procura_online/controllers/orders_controller.dart';
import 'package:procura_online/models/user_model.dart';
import 'package:procura_online/repositories/user_repository.dart';
import 'package:procura_online/utils/navigation_helper.dart';
import 'package:procura_online/utils/onesignal_notification.dart';
import 'package:smart_select/smart_select.dart';

import 'chat_controller.dart';

class UserController extends GetxController with StateMixin<User> {
  UserRepository _userRepository = Get.find();
  NotificationHelper _notificationHelper = NotificationHelper();

  @override
  onInit() {
    _initData();
    super.onInit();
  }

  RxBool _isLoading = false.obs;
  RxBool _isSaving = false.obs;
  RxBool _isLoadingSkills = false.obs;
  RxBool _isLoadingDistricts = false.obs;
  RxBool _isLoadingCities = false.obs;
  RxBool _savingError = false.obs;
  RxBool _isLoggedIn = false.obs;
  Rx<User> _userData = User().obs;
  RxString _token = ''.obs;

  bool get isLoading => _isLoading.value;
  bool get isSaving => _isSaving.value;
  bool get isLoadingSkills => _isLoadingSkills.value;
  bool get isLoadingDistricts => _isLoadingDistricts.value;
  bool get isLoadingCities => _isLoadingCities.value;
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

  Rx<TextEditingController> vatNumber = TextEditingController().obs;
  Rx<TextEditingController> billingName = TextEditingController().obs;
  Rx<TextEditingController> billingCountry = TextEditingController().obs;
  Rx<TextEditingController> billingCity = TextEditingController().obs;
  Rx<TextEditingController> billingAddress = TextEditingController().obs;
  Rx<TextEditingController> billingPostcode = TextEditingController().obs;

  RxList<S2Choice<int>> _skills = List<S2Choice<int>>.empty(growable: true).obs;
  RxList<S2Choice<int>> _districts = List<S2Choice<int>>.empty(growable: true).obs;
  RxList<S2Choice<int>> _cities = List<S2Choice<int>>.empty(growable: true).obs;

  List<S2Choice<int>> get skills => _skills;
  List<S2Choice<int>> get districts => _districts;
  List<S2Choice<int>> get cities => _cities;

  RxString selectedAccountType = ''.obs;
  final List<S2Choice<String>> accountTypeOptions = [
    S2Choice<String>(value: 'company', title: 'Company'),
    S2Choice<String>(value: 'personal', title: 'Personal'),
  ];

  void setAccountType(String value) => selectedAccountType.value = value;

  _initData() async {
    try {
      Box authBox = await Hive.openBox('auth') ?? null;
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

      if (response['message'] != null) {
        Get.rawSnackbar(message: response['message'], backgroundColor: Colors.red, duration: Duration(seconds: 3));
      } else {
        User user = User.fromJson(response['user']);
        Box<User> userBox = await Hive.openBox<User>('userData');
        Box authBox = await Hive.openBox('auth');

        _isLoggedIn.value = true;
        _token.value = response['token'];
        _userData.value = user;

        authBox.put('isLoggedIn', true);
        authBox.put('token', response['token']);
        userBox.put(response['user']['id'], User.fromJson(response['user']));
        _notificationHelper.setExternalUserId(userId: response['user']['id'].toString());
        // setPushToken();
        Get.offAllNamed('/app');
      }
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
    } catch (err) {
      Get.rawSnackbar(
          message: 'Ops, something went wrong.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
    } finally {
      _isLoading.value = false;
    }
  }

  void signUp({
    String name,
    String email,
    String phone,
    String password,
    String type,
    String company,
    List skills,
    int district,
    int city,
    String address,
    String postcode,
  }) async {
    _isLoading.value = true;
    try {
      Map<String, dynamic> registerData = {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "type": type,
        "company": company,
        "skills": skills,
        "district_id": district,
        "city_id": city,
        "address": address,
        "postcode": postcode,
        "plan_id": 1,
      };

      await _userRepository.signUp(registerData);
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
      String response = await _userRepository.passwordReset(email);
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
    Box authBox = await Hive.openBox('auth');
    Box<User> userBox = await Hive.openBox<User>('userData');
    authBox.put('isLoggedIn', false);
    userBox.clear();
    Get.delete<OrdersController>(force: true);
    Get.delete<ChatController>(force: true);
    _isLoggedIn.value = false;
    _userData.value = User();
    _notificationHelper.removeExternalUserId();
    NavKey.pageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.linear);
    Get.back();
  }

  void updateProfile() async {
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

      User response = await _userRepository.updateProfile(updateData);
      Box<User> box = await Hive.openBox<User>('userData');
      box.put(response.id.toString(), response);

      Get.back();
    } on DioError catch (err) {
      print(err);
      _savingError.value = true;
      Get.rawSnackbar(
          message: 'Ops, error updating profile information.',
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3));
    } catch (err) {
      print(err);
      _savingError.value = true;
      Get.rawSnackbar(
          message: 'Ops, error updating profile information..',
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3));
    } finally {
      _isSaving.value = false;
    }
  }

  void updateBilling() async {
    _isSaving.value = true;
    try {
      Map<String, dynamic> updateData = {
        'vat_number': vatNumber.value.text,
        'billing_name': billingName.value.text,
        'billing_country': billingCountry.value.text,
        'billing_city': billingCity.value.text,
        'billing_address': billingAddress.value.text,
        'billing_postcode': billingPostcode.value.text,
      };

      _userData.update((val) {
        val.vatNumber = vatNumber.value.text;
        val.billingName = billingName.value.text;
        val.billingCountry = billingCountry.value.text;
        val.billingCity = billingCity.value.text;
        val.billingAddress = billingAddress.value.text;
        val.billingPostcode = billingPostcode.value.text;
      });

      User response = await _userRepository.updateBilling(updateData);
      Box<User> box = await Hive.openBox<User>('userData');
      box.put(response.id.toString(), response);

      Get.back();
    } on DioError catch (err) {
      print(err);
      _savingError.value = true;
      Get.rawSnackbar(
          message: 'Ops, error updating billing information.',
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3));
    } catch (err) {
      print(err);
      _savingError.value = true;
      Get.rawSnackbar(
          message: 'Ops, error updating billing information.',
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3));
    } finally {
      _isSaving.value = false;
    }
  }

  void changePassword({@required String currentPass, @required String newPass, @required String confirmPass}) async {
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

  void setPushToken() async {
    OSPermissionSubscriptionState player = await OneSignal.shared.getPermissionSubscriptionState();
    String playerId = player.subscriptionStatus.userId.toString();
    print('PLAYER_ID: $playerId');
    _userRepository.setPushToken(playerId);
  }

  void getSkills() async {
    _isLoadingSkills.value = true;
    try {
      List response = await _userRepository.getSkills();
      List<S2Choice<int>> skillsList = List<S2Choice<int>>.empty(growable: true);

      if (response != null) {
        response.forEach((skill) {
          skillsList.add(S2Choice<int>(value: skill['id'], title: skill['name']));
        });
        _skills.assignAll(skillsList);
      }
    } catch (err) {
      print(err);
    } finally {
      _isLoadingSkills.value = false;
    }
  }

  void getDistricts() async {
    _isLoadingDistricts.value = true;
    try {
      List response = await _userRepository.getDistricts();
      List<S2Choice<int>> districtsList = List<S2Choice<int>>.empty(growable: true);

      if (response != null) {
        response.forEach((district) {
          districtsList.add(S2Choice<int>(value: district['id'], title: district['name']));
        });
        _districts.assignAll(districtsList);
      }
    } catch (err) {
      print(err);
    } finally {
      _isLoadingDistricts.value = false;
    }
  }

  void getCities(int districtId) async {
    _isLoadingCities.value = true;
    try {
      List response = await _userRepository.getCities(districtId);
      List<S2Choice<int>> citiesList = List<S2Choice<int>>.empty(growable: true);

      if (response != null) {
        response.forEach((city) {
          citiesList.add(S2Choice<int>(value: city['id'], title: city['name']));
        });
        _cities.assignAll(citiesList);
      }
    } catch (err) {
      print(err);
    } finally {
      _isLoadingCities.value = false;
    }
  }
}
