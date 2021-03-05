import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile;
import 'package:procura_online/models/upload_media_model.dart';
import 'package:procura_online/repositories/product_repository.dart';
import 'package:procura_online/repositories/user_repository.dart';
import 'package:procura_online/repositories/vehicle_repository.dart';
import 'package:smart_select/smart_select.dart';

class CreateAdController extends GetxController {
  ProductRepository _productRepository = Get.find();
  VehicleRepository _vehicleRepository = Get.find();
  UserRepository _userRepository = Get.find();

  @override
  onInit() {
    getCategories();
    getBrands();
    super.onInit();
  }

  RxBool _isSaving = false.obs;
  RxBool _isLoadingCategories = false.obs;
  RxBool _isLoadingSubCategories = false.obs;
  RxBool _isLoadingBrands = false.obs;
  RxBool _isLoadingModels = false.obs;
  RxBool _isCheckingSubscription = false.obs;

  RxList<File> images = List<File>.empty(growable: true).obs;
  RxList<String> imagesUrl = List<String>.empty(growable: true).obs;
  RxString mainPhoto = ''.obs;
  RxString mainPhotoUrl = ''.obs;
  RxString currentUploadImage = ''.obs;
  RxDouble uploadImageProgress = 0.0.obs;
  RxBool _isUploadingImage = false.obs;

  bool get isSaving => _isSaving.value;
  bool get isLoadingCategories => _isLoadingCategories.value;
  bool get isLoadingSubCategories => _isLoadingSubCategories.value;
  bool get isLoadingBrands => _isLoadingBrands.value;
  bool get isLoadingModels => _isLoadingModels.value;
  bool get isUploadingImage => _isUploadingImage.value;
  bool get isCheckingSubscription => _isCheckingSubscription.value;

  Rx<TextEditingController> title = TextEditingController().obs;
  Rx<TextEditingController> description = TextEditingController().obs;
  Rx<TextEditingController> year = TextEditingController().obs;
  Rx<TextEditingController> engineDisplacement = TextEditingController().obs;
  Rx<TextEditingController> enginePower = TextEditingController().obs;
  Rx<TextEditingController> miliage = TextEditingController().obs;
  Rx<TextEditingController> numberOfSeats = TextEditingController().obs;
  Rx<TextEditingController> numberOfDoors = TextEditingController().obs;
  Rx<TextEditingController> price = TextEditingController().obs;

  RxList<S2Choice<String>> _categories = List<S2Choice<String>>.empty(growable: true).obs;
  RxList<S2Choice<String>> _subcategories = List<S2Choice<String>>.empty(growable: true).obs;
  RxList<S2Choice<String>> _brands = List<S2Choice<String>>.empty(growable: true).obs;
  RxList<S2Choice<String>> _models = List<S2Choice<String>>.empty(growable: true).obs;

  List<S2Choice<String>> get categories => _categories;
  List<S2Choice<String>> get subcategories => _subcategories;
  List<S2Choice<String>> get brands => _brands;
  List<S2Choice<String>> get models => _models;

  RxString selectedCategory = ''.obs;
  RxString selectedSubCategory = ''.obs;
  RxString selectedBrand = ''.obs;
  RxString selectedModel = ''.obs;
  RxString selectedColor = ''.obs;
  RxString selectedFuel = ''.obs;
  RxString selectedTransmission = ''.obs;
  RxString selectedCondition = ''.obs;
  RxString selectedNegotiable = ''.obs;
  RxBool isFeatured = false.obs;
  DateTime selectedDate = DateTime.now();
  RxString registeredDate = ''.obs;
  RxString formattedRegisteredDate = ''.obs;

  List<S2Choice<String>> colorOptions = [
    S2Choice<String>(value: '0', title: 'Blue'),
    S2Choice<String>(value: '1', title: 'Orange'),
    S2Choice<String>(value: '2', title: 'Black'),
    S2Choice<String>(value: '3', title: 'White'),
  ];

  List<S2Choice<String>> fuelOptions = [
    S2Choice<String>(value: 'gas', title: 'Gás'),
    S2Choice<String>(value: 'gasoline', title: 'Gasoline'),
    S2Choice<String>(value: 'diesel', title: 'Diesel'),
    S2Choice<String>(value: 'hybrid', title: 'Hybrid'),
    S2Choice<String>(value: 'electric', title: 'Electric'),
  ];

  List<S2Choice<String>> transmissionOptions = [
    S2Choice<String>(value: 'manual', title: 'Manual'),
    S2Choice<String>(value: 'semi', title: 'Semi-automatic'),
    S2Choice<String>(value: 'automatic', title: 'Automatic'),
  ];

  List<S2Choice<String>> conditionOptions = [
    S2Choice<String>(value: 'New', title: 'Novo'),
    S2Choice<String>(value: 'Used', title: 'Usado'),
    S2Choice<String>(value: 'Saved', title: 'Salvado'),
  ];

  List<S2Choice<String>> negotiableOptions = [
    S2Choice<String>(value: '1', title: 'Sim'),
    S2Choice<String>(value: '0', title: 'Não'),
  ];

  void setImages(List<File> value) => images.addAll(value);

  void removeImage(File value) {
    images.removeWhere((img) => img == value);
  }

  void removeImageByIndex(int value) {
    images.removeAt(value);
    imagesUrl.removeAt(value);
  }

  void setImagesUrl(String value) => imagesUrl.add(value);
  void setMainImageUrl(String value) => mainPhotoUrl.value = value;
  void setMainImage(String value) => mainPhoto.value = value;

  void setColor(String value) => selectedColor.value = value;
  void setFuel(String value) => selectedFuel.value = value;
  void setTransmission(String value) => selectedTransmission.value = value;
  void setCondition(String value) => selectedCondition.value = value;
  void setNegotiable(String value) => selectedNegotiable.value = value;

  void setCategory(String value) {
    if (value != '' && value != selectedCategory.value) {
      getSubCategories(value);
    }
    selectedCategory.value = value;
  }

  void setSubCategory(String value) => selectedSubCategory.value = value;

  void setBrand(String value) {
    if (value != '' && value != selectedBrand.value) {
      getModels(value);
    }
    selectedBrand.value = value;
  }

  void setModel(String value) => selectedModel.value = value;

  void getCategories() async {
    _isLoadingCategories.value = true;
    try {
      Map<String, dynamic> response = await _vehicleRepository.getCategories();
      List<S2Choice<String>> catList = List<S2Choice<String>>.empty(growable: true);

      if (response != null) {
        response.entries.forEach(
          (e) => catList.add(
            S2Choice<String>(value: e.key, title: e.value),
          ),
        );
        _categories.assignAll(catList);
      }
    } catch (err) {
      print(err);
    } finally {
      _isLoadingCategories.value = false;
    }
  }

  void getSubCategories(String catId) async {
    _isLoadingSubCategories.value = true;
    try {
      Map<String, dynamic> response = await _vehicleRepository.getSubCategories(catId);
      List<S2Choice<String>> catList = List<S2Choice<String>>.empty(growable: true);

      if (response != null) {
        response.entries.forEach(
          (e) => catList.add(
            S2Choice<String>(value: e.key, title: e.value),
          ),
        );
        _subcategories.assignAll(catList);
      }
    } catch (err) {
      print(err);
    } finally {
      _isLoadingSubCategories.value = false;
    }
  }

  void getBrands() async {
    try {
      _isLoadingBrands.value = true;
      List<String> brands = await _vehicleRepository.getMakers();
      if (brands.length > 0) {
        List<S2Choice<String>> options = S2Choice.listFrom<String, dynamic>(
          source: brands,
          value: (index, item) => item,
          title: (index, item) => item,
        );
        _brands.assignAll(options);
      }
    } catch (err) {
      print(err);
    } finally {
      _isLoadingBrands.value = false;
    }
  }

  void getModels(String brand) async {
    try {
      _isLoadingModels.value = true;
      List<String> models = await _vehicleRepository.getModels(brand);
      if (models.length > 0) {
        List<S2Choice<String>> options = S2Choice.listFrom<String, dynamic>(
          source: models,
          value: (index, item) => item,
          title: (index, item) => item,
        );
        _models.assignAll(options);
      }
    } catch (err) {
      print(err);
    } finally {
      _isLoadingModels.value = false;
    }
  }

  void create() async {
    _isSaving.value = true;
    try {
      Map<String, dynamic> createData = {
        "title": title.value.text,
        "description": description.value.text,
        "make": selectedBrand.value,
        "model": selectedModel.value,
        "year": year.value.text,
        "color": selectedColor.value,
        "engine_displacement": engineDisplacement.value.text,
        "number_of_seats": numberOfSeats.value.text,
        "number_of_doors": numberOfDoors.value.text,
        "fuel_type": selectedFuel.value,
        "engine_power": enginePower.value.text,
        "transmission": selectedTransmission.value,
        "registered": registeredDate.value,
        "mileage": miliage.value.text,
        "condition": selectedCondition.value,
        "price": price.value.text,
        "negotiable": selectedNegotiable.value,
        "featured": isFeatured.value,
        "main_photo": mainPhotoUrl.value,
        "gallery": imagesUrl,
        "categories": [selectedCategory.value, selectedSubCategory.value],
      };

      await _productRepository.create(createData);
      successDialog(title: 'Successo', message: 'Seu anúncio foi criado com sucesso.', dismiss: () => Get.back());
    } on DioError catch (err) {
      print(err.request.data);
      try {
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
          message: 'Ops, ocorreu um erro.',
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        );
      }
    } finally {
      _isSaving.value = false;
    }
  }

  Future<UploadMedia> mediaUpload(File photo) async {
    uploadImageProgress.value = 0.0;
    _isUploadingImage.value = true;
    var _result;
    try {
      UploadMedia response = await _productRepository.mediaUpload(photo);
      _result = response;
    } on DioError catch (err) {
      print(err);
      Get.rawSnackbar(
          message: 'Ops, ocorreu um erro ao enviar imagem.',
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5));
    } catch (err) {
      print(err);
      Get.rawSnackbar(
          message: 'Ops, ocorreu um erro ao enviar imagem.',
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5));
    } finally {
      _isUploadingImage.value = false;
      uploadImageProgress.value = 0.0;
      currentUploadImage.value = '';
    }
    return _result;
  }

  void setFeatured(bool value) async {
    if (!value) {
      isFeatured.value = false;
      return;
    }
    _isCheckingSubscription.value = true;
    try {
      bool response = await _userRepository.checkSubscription('listings-featured');
      if (response) {
        isFeatured.value = response;
      } else {
        errorDialog(
          title: 'Error',
          message: 'Você não pode destacar este anúncio. Verifique seu plano.',
        );
      }
    } catch (err) {
      isFeatured.value = false;
      print(err);
    } finally {
      _isCheckingSubscription.value = false;
    }
  }

  AwesomeDialog successDialog({String title, String message, Function dismiss}) {
    return AwesomeDialog(
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      context: Get.context,
      animType: AnimType.BOTTOMSLIDE,
      headerAnimationLoop: false,
      dialogType: DialogType.SUCCES,
      title: title,
      useRootNavigator: false,
      padding: EdgeInsets.only(left: 10, right: 10),
      desc: message,
      btnOkText: 'OK',
      btnOkOnPress: () {},
      onDissmissCallback: dismiss,
      btnOkIcon: Icons.check_circle,
      btnOkColor: Colors.blue,
    )..show();
  }

  AwesomeDialog errorDialog({String title, String message, Function dismiss}) {
    return AwesomeDialog(
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      context: Get.context,
      animType: AnimType.BOTTOMSLIDE,
      headerAnimationLoop: false,
      dialogType: DialogType.ERROR,
      title: title,
      useRootNavigator: false,
      padding: EdgeInsets.only(left: 10, right: 10),
      desc: message,
      btnOkText: 'OK',
      btnOkOnPress: () {},
      onDissmissCallback: dismiss,
      btnOkIcon: Icons.check_circle,
      btnOkColor: Colors.blue,
    )..show();
  }
}
