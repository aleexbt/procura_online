import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:procura_online/models/product_model.dart';
import 'package:procura_online/repositories/product_repository.dart';
import 'package:procura_online/repositories/vehicle_repository.dart';
import 'package:smart_select/smart_select.dart';

class EditAdController extends GetxController {
  final ProductRepository _productRepository = Get.find();
  final VehicleRepository _vehicleRepository = Get.find();
  final String productId = Get.parameters['id'];

  @override
  void onInit() {
    findOne();
    getBrands();
    super.onInit();
  }

  final currency = NumberFormat('##,###,00', 'pt_BR');
  // final currency = NumberFormat.currency(locale: 'pt_PT', symbol: 'EUR', decimalDigits: 1);
  RxBool _isLoading = false.obs;
  RxBool _isSaving = false.obs;
  RxBool _isAdEdited = false.obs;
  RxBool _isLoadingBrands = false.obs;
  RxBool _isLoadingModels = false.obs;
  Rx<Product> _product = Product().obs;

  bool get isLoading => _isLoading.value;
  bool get isSaving => _isSaving.value;
  bool get isAdEdited => _isAdEdited.value;
  bool get isLoadingBrands => _isLoadingBrands.value;
  bool get isLoadingModels => _isLoadingModels.value;
  Product get product => _product.value;

  Rx<TextEditingController> title = TextEditingController().obs;
  Rx<TextEditingController> description = TextEditingController().obs;
  Rx<TextEditingController> year = TextEditingController().obs;
  Rx<TextEditingController> engineDisplacement = TextEditingController().obs;
  Rx<TextEditingController> enginePower = TextEditingController().obs;
  Rx<TextEditingController> miliage = TextEditingController().obs;
  Rx<TextEditingController> numberOfSeats = TextEditingController().obs;
  Rx<TextEditingController> numberOfDoors = TextEditingController().obs;
  Rx<TextEditingController> price = TextEditingController().obs;

  RxList<S2Choice<String>> _brands = List<S2Choice<String>>().obs;
  RxList<S2Choice<String>> _models = List<S2Choice<String>>().obs;
  List<S2Choice<String>> get brands => _brands;
  List<S2Choice<String>> get models => _models;

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
    if (value != '' && value != selectedBrand.value) {
      getModels(value);
    }
    selectedBrand.value = value;
  }

  void setModel(String value) => selectedModel.value = value;

  void findOne() async {
    _isLoading.value = true;
    try {
      Product response = await _productRepository.findOne(productId);
      _product.value = response;
      title.value.text = response.title;
      description.value.text = response.description;
      year.value.text = response.year;
      engineDisplacement.value.text = response.engineDisplacement;
      enginePower.value.text = response.enginePower;
      miliage.value.text = response.mileage;
      numberOfSeats.value.text = response.numberOfSeats;
      numberOfDoors.value.text = response.numberOfDoors;
      price.value.text = response.price;
      selectedColor.value = response.color;
      selectedFuel.value = response.fuelType;
      selectedTransmission.value = response.transmission;
      selectedCondition.value = response.condition;
      selectedNegotiable.value = response.negotiable;
      registeredDate.value = response.registered;
      setBrand(response.make);
      setModel(response.model);
      DateTime date = DateTime.parse(response.registered.toString());
      formattedRegisteredDate.value = '${date.day}/${date.month}/${date.year}';
    } on DioError catch (err) {
      print(err);
    } finally {
      _isLoading.value = false;
    }
  }

  void edit({List<File> photos, List<String> photosToRemove}) async {
    _isSaving.value = true;
    try {
      await _productRepository.edit(
        id: productId,
        photos: photos,
        photosToRemove: photosToRemove,
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
      );
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
      _isAdEdited.value = false;
    }
  }
}
