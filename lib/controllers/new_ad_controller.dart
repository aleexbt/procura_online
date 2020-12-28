import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile;
import 'package:procura_online/repositories/product_repository.dart';
import 'package:procura_online/repositories/vehicle_repository.dart';
import 'package:smart_select/smart_select.dart';

class NewAdController extends GetxController {
  VehicleRepository _vehicleRepository = Get.put(VehicleRepository());
  ProductRepository _productRepository = Get.find();

  @override
  onInit() {
    getBrands();
    super.onInit();
  }

  RxString _selectedBrand = ''.obs;
  RxString _selectedModel = ''.obs;

  String get selectedBrand => _selectedBrand.value;
  String get selectedModel => _selectedModel.value;

  RxBool _isLoadingBrands = false.obs;
  RxBool _isLoadingModels = false.obs;
  RxBool _isCreatingAd = false.obs;
  RxBool _isAdCreated = false.obs;
  bool get isLoadingBrands => _isLoadingBrands.value;
  bool get isLoadingModels => _isLoadingModels.value;
  bool get isCreatingAd => _isCreatingAd.value;
  bool get isAdCreated => _isAdCreated.value;

  RxList<S2Choice<String>> _brands = List<S2Choice<String>>().obs;
  RxList<S2Choice<String>> _models = List<S2Choice<String>>().obs;
  List<S2Choice<String>> get brands => _brands;
  List<S2Choice<String>> get models => _models;

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

  void setBrand(String value) {
    if (value != '' && value != _selectedBrand.value) {
      getModels(value);
    }
    _selectedBrand.value = value;
  }

  void setModel(String value) {
    _selectedModel.value = value;
  }

  void create({
    List<File> photos,
    String title,
    String description,
    String brand,
    String model,
    String year,
    String color,
    String engineDisplacement,
    String enginePower,
    String transmission,
    String miliage,
    String numberOfSeats,
    String numberOfDoors,
    String fuelType,
    String condition,
    String price,
    String negotiable,
    String registered,
  }) async {
    _isCreatingAd.value = true;
    try {
      await _productRepository.create(
        photos: photos,
        title: title,
        description: description,
        brand: brand,
        model: model,
        year: year,
        color: color,
        engineDisplacement: engineDisplacement,
        enginePower: enginePower,
        transmission: transmission,
        miliage: miliage,
        numberOfSeats: numberOfSeats,
        numberOfDoors: numberOfDoors,
        fuelType: fuelType,
        condition: condition,
        price: price,
        negotiable: negotiable,
        registered: registered,
      );
      _isAdCreated.value = true;
    } on DioError catch (err) {
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
      _isCreatingAd.value = false;
    }
  }
}
