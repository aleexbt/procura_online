import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile;
import 'package:procura_online/repositories/product_repository.dart';
import 'package:procura_online/repositories/vehicle_repository.dart';
import 'package:smart_select/smart_select.dart';

class CreateAdController extends GetxController {
  ProductRepository _productRepository = Get.find();
  VehicleRepository _vehicleRepository = Get.find();

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

  bool get isSaving => _isSaving.value;
  bool get isLoadingCategories => _isLoadingCategories.value;
  bool get isLoadingSubCategories => _isLoadingSubCategories.value;
  bool get isLoadingBrands => _isLoadingBrands.value;
  bool get isLoadingModels => _isLoadingModels.value;

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
  DateTime selectedDate = DateTime.now();
  RxString registeredDate = ''.obs;
  RxString formattedRegisteredDate = ''.obs;

  List<S2Choice<String>> colorOptions = [
    S2Choice<String>(value: 'Black', title: 'Black'),
    S2Choice<String>(value: 'Blue', title: 'Blue'),
    S2Choice<String>(value: 'Green', title: 'Green'),
    S2Choice<String>(value: 'White', title: 'White'),
    S2Choice<String>(value: 'Grey', title: 'Grey'),
  ];

  List<S2Choice<String>> fuelOptions = [
    S2Choice<String>(value: 'gas', title: 'Gasoline'),
    S2Choice<String>(value: 'diesel', title: 'Diesel'),
    S2Choice<String>(value: 'hybrid', title: 'Hybrid'),
    S2Choice<String>(value: 'electric', title: 'Electric'),
  ];

  List<S2Choice<String>> transmissionOptions = [
    S2Choice<String>(value: 'manual', title: 'Manual'),
    S2Choice<String>(value: 'auto', title: 'Automatic'),
  ];

  List<S2Choice<String>> conditionOptions = [
    S2Choice<String>(value: 'New', title: 'Novo'),
    S2Choice<String>(value: 'Used', title: 'Usado'),
    S2Choice<String>(value: 'Saved', title: 'Salvado'),
  ];

  List<S2Choice<String>> negotiableOptions = [
    S2Choice<String>(value: '1', title: 'Yes'),
    S2Choice<String>(value: '0', title: 'No'),
  ];

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

  void create({List<File> photos}) async {
    _isSaving.value = true;
    try {
      await _productRepository.create(
        photos: photos,
        title: title.value.text,
        description: description.value.text,
        brand: selectedBrand.value,
        model: selectedModel.value,
        year: year.value.text,
        color: selectedColor.value,
        engineDisplacement: engineDisplacement.value.text,
        enginePower: enginePower.value.text,
        transmission: selectedTransmission.value,
        miliage: miliage.value.text,
        numberOfSeats: numberOfSeats.value.text,
        numberOfDoors: numberOfDoors.value.text,
        fuelType: selectedFuel.value,
        condition: selectedCondition.value,
        price: price.value.text,
        negotiable: selectedNegotiable.value,
        registered: registeredDate.value,
        category: selectedCategory.value,
        subcategory: selectedSubCategory.value,
      );
      successDialog(title: 'Success', message: 'Your ad has been published successfully.', dismiss: () => Get.back());
    } on DioError catch (err) {
      print(err);
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
          message: 'Ops, something went wrong.',
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        );
      }
    } finally {
      _isSaving.value = false;
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
}
