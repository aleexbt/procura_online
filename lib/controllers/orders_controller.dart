import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/models/message_model.dart';
import 'package:procura_online/models/order_model.dart';
import 'package:procura_online/models/orders_model.dart';
import 'package:procura_online/models/upload_media_model.dart';
import 'package:procura_online/repositories/chat_repository.dart';
import 'package:procura_online/repositories/orders_repository.dart';

class OrdersController extends GetxController {
  OrdersRepository _ordersRepository = Get.find();
  ChatRepository _chatRepository = Get.find();

  @override
  onInit() {
    findAll();
    super.onInit();
  }

  RxBool _isLoading = false.obs;
  RxBool _isLoadingMore = false.obs;
  RxBool _loadingMoreError = false.obs;
  RxBool _isUploadingImage = false.obs;
  RxBool _isPublishingOrder = false.obs;
  RxBool _publishingOrderError = false.obs;
  RxBool _isReplyingMsg = false.obs;
  RxBool _replyingMsgError = false.obs;
  RxDouble uploadImageProgress = 0.0.obs;
  RxBool _hasError = false.obs;

  Rx<Orders> _orders = Orders().obs;
  RxString _filter = 'vazio'.obs;
  RxString _filterName = 'Unread'.obs;
  RxInt _page = 1.obs;

  bool get isLoading => _isLoading.value;
  bool get isLoadingMore => _isLoadingMore.value;
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

  void findAll() async {
    _isLoading.value = true;
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
    String mpn,
    String note,
    String brand,
    String model,
    String year,
    String engineDisplacement,
    String numberOfDoors,
    String fuelType,
  }) async {
    _isPublishingOrder.value = true;
    _publishingOrderError.value = false;
    try {
      Map<String, dynamic> data = {
        "make": brand,
        "model": model,
        "year": year,
        "note_text": note,
        "mpn": mpn,
        "number_of_doors": numberOfDoors,
        "fuel_type": fuelType,
        "engine_displacement": engineDisplacement,
        "attachments": images,
      };
      await _ordersRepository.createOrder(data);
      successDialog(title: 'Success', message: 'Your order has been published successfully.');
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

  AwesomeDialog successDialog({String title, String message}) {
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
      onDissmissCallback: () {
        Get.back();
      },
      btnOkIcon: Icons.check_circle,
      btnOkColor: Colors.blue,
    )..show();
  }

  void changeFilter({@required String value, @required String name}) {
    _filter.value = value;
    _filterName.value = name;
    findAll();
  }
}
