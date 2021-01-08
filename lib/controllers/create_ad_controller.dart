import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile;
import 'package:procura_online/repositories/product_repository.dart';
import 'package:smart_select/smart_select.dart';

class CreateAdController extends GetxController {
  ProductRepository _productRepository = Get.find();

  RxBool _isCreatingAd = false.obs;
  RxBool _isAdCreated = false.obs;

  bool get isCreatingAd => _isCreatingAd.value;
  bool get isAdCreated => _isAdCreated.value;

  Rx<TextEditingController> title = TextEditingController().obs;
  Rx<TextEditingController> description = TextEditingController().obs;
  Rx<TextEditingController> year = TextEditingController().obs;
  Rx<TextEditingController> engineDisplacement = TextEditingController().obs;
  Rx<TextEditingController> enginePower = TextEditingController().obs;
  Rx<TextEditingController> miliage = TextEditingController().obs;
  Rx<TextEditingController> numberOfSeats = TextEditingController().obs;
  Rx<TextEditingController> numberOfDoors = TextEditingController().obs;
  Rx<TextEditingController> price = TextEditingController().obs;

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

  void create({
    List<File> photos,
    String brand,
    String model,
  }) async {
    _isCreatingAd.value = true;
    try {
      await _productRepository.create(
        photos: photos,
        title: title.value.text,
        description: description.value.text,
        brand: brand,
        model: model,
        year: year.value.text,
        color: selectedColor.value,
        engineDisplacement: engineDisplacement.value.text,
        enginePower: enginePower.value.text,
        transmission: selectedTransmission.value,
        miliage: miliage.value.text,
        numberOfSeats: numberOfSeats.value.text,
        numberOfDoors: numberOfDoors.value.text,
        fuelType: selectedFuel.value,
        condition: selectedColor.value,
        price: price.value.text,
        negotiable: selectedNegotiable.value,
        registered: registeredDate.value,
      );
      _isAdCreated.value = true;
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
      _isCreatingAd.value = false;
    }
  }
}
