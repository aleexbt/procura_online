import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:procura_online/models/message_model.dart';
import 'package:procura_online/models/order_model.dart';
import 'package:procura_online/models/orders_model.dart';
import 'package:procura_online/models/upload_media_model.dart';
import 'package:procura_online/repositories/chat_repository.dart';
import 'package:procura_online/repositories/orders_repository.dart';
import 'package:procura_online/repositories/vehicle_repository.dart';
import 'package:smart_select/smart_select.dart';

class OrdersController extends GetxController {
  OrdersRepository _ordersRepository = Get.find();
  ChatRepository _chatRepository = Get.find();
  VehicleRepository _vehicleRepository = Get.find();
  UserController _userController = Get.find();

  @override
  onInit() {
    findAll();
    getBrands();
    super.onInit();
  }

  RxBool _isLoading = false.obs;
  RxBool _isLoadingMore = false.obs;
  RxBool _isLoadingBrands = false.obs;
  RxBool _isLoadingModels = false.obs;
  RxBool _loadingMoreError = false.obs;
  RxBool _isUploadingImage = false.obs;
  RxBool _isPublishingOrder = false.obs;
  RxBool _publishingOrderError = false.obs;
  RxBool _isReplyingMsg = false.obs;
  RxBool _replyingMsgError = false.obs;
  RxDouble uploadImageProgress = 0.0.obs;
  RxBool _hasError = false.obs;

  Rx<Orders> _orders = Orders().obs;
  RxString _filter = 'unread'.obs;
  RxString _filterName = 'Unread'.obs;
  RxInt _page = 1.obs;

  RxList<File> images = List<File>.empty(growable: true).obs;
  RxList<String> imagesUrl = List<String>.empty(growable: true).obs;
  RxString currentUploadImage = ''.obs;

  bool get isLoading => _isLoading.value;
  bool get isLoadingMore => _isLoadingMore.value;
  bool get isLoadingBrands => _isLoadingBrands.value;
  bool get isLoadingModels => _isLoadingModels.value;
  bool get loadingMoreError => _loadingMoreError.value;
  bool get isUploadingImage => _isUploadingImage.value;
  bool get isPublishingOrder => _isPublishingOrder.value;
  bool get publishingOrderError => _publishingOrderError.value;
  bool get isReplyingMsg => _isReplyingMsg.value;
  bool get replyingMsgError => _replyingMsgError.value;
  bool get hasError => _hasError.value;

  Orders get orders => _orders.value;
  int get page => _page.value;
  String get filter => _filter.value;
  String get filterName => _filterName.value;
  int get perPage => _orders.value.meta.perPage;
  int get totalOrders => _orders.value.meta.total;
  bool get isLastPage => _page.value == _orders.value.meta.lastPage;

  List<Order> filteredOrders;

  Rx<TextEditingController> mpn = TextEditingController().obs;
  Rx<TextEditingController> note = TextEditingController().obs;
  Rx<TextEditingController> year = TextEditingController().obs;
  Rx<TextEditingController> engineDisplacement = TextEditingController().obs;
  Rx<TextEditingController> numberOfDoors = TextEditingController().obs;

  RxList<S2Choice<String>> _brands = List<S2Choice<String>>.empty(growable: true).obs;
  RxList<S2Choice<String>> _models = List<S2Choice<String>>.empty(growable: true).obs;
  List<S2Choice<String>> get brands => _brands;
  List<S2Choice<String>> get models => _models;

  RxString selectedBrand = ''.obs;
  RxString selectedModel = ''.obs;
  RxString selectedFuel = ''.obs;

  List<S2Choice<String>> fuelOptions = [
    S2Choice<String>(value: 'gas', title: 'Gasoline'),
    S2Choice<String>(value: 'diesel', title: 'Diesel'),
    S2Choice<String>(value: 'hybrid', title: 'Hybrid'),
    S2Choice<String>(value: 'electric', title: 'Electric'),
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

  void setFuel(String value) => selectedFuel.value = value;

  void findAll({skipLoading = false}) async {
    if (filter == 'sent') {
      _userController.setListOrdersPermission(true);
    }
    if (filter != 'sent') {
      _userController.checkSubscription('orders-access');
    }
    _isLoading.value = !skipLoading;
    _hasError.value = false;
    _page.value = 1;
    try {
      Orders response = await _ordersRepository.findAll(filter: _filter.value, page: _page.value);
      _orders.value = response;
      filteredOrders = List.from(response.orders);
    } on DioError catch (err) {
      _hasError.value = true;
      print(err);
    } catch (err) {
      _hasError.value = true;
      print(err);
    } finally {
      _isLoading.value = false;
    }
  }

  void createOrder({
    List<String> images,
  }) async {
    _isPublishingOrder.value = true;
    _publishingOrderError.value = false;
    try {
      Map<String, dynamic> data = {
        "make": selectedBrand.value,
        "model": selectedModel.value,
        "year": year.value.text,
        "note_text": note.value.text,
        "mpn": mpn.value.text,
        "number_of_doors": numberOfDoors.value.text,
        "fuel_type": selectedFuel.value,
        "engine_displacement": engineDisplacement.value.text,
        "attachments": imagesUrl,
      };
      await _ordersRepository.createOrder(data);
      findAll(skipLoading: true);
      successDialog(
          title: 'Success', message: 'Your order has been published successfully.', dismiss: () => Get.back());
    } on DioError catch (err) {
      print(err);
      _publishingOrderError.value = true;
      Get.rawSnackbar(
          message: 'Ops, something went wrong.', backgroundColor: Colors.red, duration: Duration(seconds: 5));
    } catch (err) {
      print(err);
      _publishingOrderError.value = true;
      Get.rawSnackbar(
          message: 'Ops, something went wrong.', backgroundColor: Colors.red, duration: Duration(seconds: 5));
    } finally {
      _isPublishingOrder.value = false;
    }
  }

  void replyOrder({String message, String orderId}) async {
    if (message.isBlank) {
      return;
    }
    _isReplyingMsg.value = true;
    _replyingMsgError.value = false;
    try {
      Map<String, dynamic> data = {"message": message, "order_id": orderId};
      Message response = await _chatRepository.replyMessage(data);
      _chatRepository.findAll();
      Get.offNamed('/chat/conversation/${response.conversationId}');
    } on DioError catch (err) {
      print(err);
      _replyingMsgError.value = true;
      Get.rawSnackbar(
          message: 'Ops, something went wrong.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
    } catch (err) {
      print(err);
      _replyingMsgError.value = true;
      Get.rawSnackbar(
          message: 'Ops, something went wrong.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
    } finally {
      _isReplyingMsg.value = false;
    }
  }

  void nextPage() async {
    _isLoadingMore.value = true;
    _loadingMoreError.value = false;
    try {
      _page.value = _page.value + 1;
      Orders response = await _ordersRepository.findAll(page: _page.value);
      if (response != null) {
        _orders.update((val) {
          val.orders.addAll(response.orders);
        });
        filteredOrders.addAll(response.orders);
      }
    } on DioError catch (err) {
      print(err);
      _loadingMoreError.value = true;
      Get.rawSnackbar(
          message: 'Ops, something went wrong.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
    } catch (err) {
      print(err);
      _loadingMoreError.value = true;
      Get.rawSnackbar(
          message: 'Ops, something went wrong.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
    } finally {
      _isLoadingMore.value = false;
    }
  }

  void resetState() {
    _isLoading.value = false;
    _isLoadingMore.value = false;
    _hasError.value = false;
    _page.value = 1;
    _orders.value = Orders();
  }

  void filterResults(String term) {
    List<Order> filtered =
        filteredOrders.where((order) => order.model.toLowerCase().contains(term.toLowerCase())).toList();
    _orders.value.orders = filtered;
    _orders.refresh();
  }

  Future<UploadMedia> mediaUpload(File photo) async {
    uploadImageProgress.value = 0.0;
    _isUploadingImage.value = true;
    var _result;
    try {
      UploadMedia response = await _ordersRepository.mediaUpload(photo);
      _result = response;
    } on DioError catch (err) {
      print(err);
      Get.rawSnackbar(
          message: 'Ops, error while uploading image', backgroundColor: Colors.red, duration: Duration(seconds: 5));
    } catch (err) {
      print(err);
      Get.rawSnackbar(
          message: 'Ops, error while uploading image', backgroundColor: Colors.red, duration: Duration(seconds: 5));
    } finally {
      _isUploadingImage.value = false;
      uploadImageProgress.value = 0.0;
    }
    return _result;
  }

  void markOrderAsSold(String orderId) {
    try {
      _ordersRepository.markOrderAsSold(orderId);
    } on DioError catch (err) {
      print(err);
    } finally {
      Get.back();
    }
  }

  void changeFilter({@required String value, @required String name}) {
    _filter.value = value;
    _filterName.value = name;
    findAll();
  }

  void resetFields() {
    mpn.value.clear();
    note.value.clear();
    selectedBrand.value = '';
    selectedModel.value = '';
    year.value.clear();
    engineDisplacement.value.clear();
    numberOfDoors.value.clear();
    selectedFuel.value = '';
    images.clear();
    imagesUrl.clear();
    currentUploadImage.value = '';
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
