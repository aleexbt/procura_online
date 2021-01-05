import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:procura_online/models/media_upload_model.dart';
import 'package:procura_online/models/orders_model.dart';
import 'package:procura_online/repositories/orders_repository.dart';

class OrdersController extends GetxController {
  OrdersRepository _repository = Get.put(OrdersRepository(), permanent: true);

  @override
  onInit() {
    findAll();
    super.onInit();
  }

  RxBool _isLoading = false.obs;
  RxBool _isLoadingMore = false.obs;
  RxBool _isUploadingImage = false.obs;
  RxBool _hasError = false.obs;
  RxInt _page = 1.obs;
  Rx<OrdersModel> _orders = OrdersModel().obs;

  bool get isLoading => _isLoading.value;
  bool get isLoadingMore => _isLoadingMore.value;
  bool get isUploadingImage => _isUploadingImage.value;
  bool get hasError => _hasError.value;
  int get page => _page.value;
  OrdersModel get orders => _orders.value;
  int get totalOrders => _orders.value.order?.length ?? 0;
  bool get isLastPage => false;
  List<Order> filteredOrders;

  void findAll() async {
    _isLoading.value = true;
    _hasError.value = false;
    _page.value = 1;
    try {
      OrdersModel orders = await _repository.findAll(page: _page.value);
      _orders.value = orders;
      filteredOrders = List.from(orders.order);
    } on DioError catch (err) {
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
    try {
      Map<String, dynamic> data = {
        "make": brand,
        "model": model,
        "year": int.parse(year) ?? null,
        "note_text": note,
        "mpn": mpn,
        "number_of_doors": int.parse(numberOfDoors) ?? null,
        "fuel_type": fuelType,
        "attachments": images,
      };
      await _repository.createOrder(data);
    } on DioError catch (err) {
      print(err);
      print({
        "make": brand,
        "model": model,
        "year": int.parse(year),
        "note_text": note,
        "mpn": mpn,
        "number_of_doors": int.parse(numberOfDoors),
        "fuel_type": fuelType,
        "attachments": images,
      });
    }
  }

  void replyOrder({String message, String orderId, String conversationId}) async {
    Map<String, dynamic> data = {"message": message, "order_id": orderId, "conversation_id": conversationId ?? ""};
    await _repository.replyOrder(data);
  }

  void nextPage() async {
    _isLoadingMore.value = true;
    _page.value = _page.value + 1;
    OrdersModel orders = await _repository.findAll(page: _page.value);

    if (orders != null) {
      _orders.update((val) {
        val.order.addAll(orders.order);
      });
      filteredOrders.addAll(orders.order);
    }
    _isLoadingMore.value = false;
  }

  void resetState() {
    _isLoading.value = false;
    _isLoadingMore.value = false;
    _hasError.value = false;
    _page.value = 1;
    _orders.value = OrdersModel();
  }

  void filterResults(String term) {
    List<Order> filtered =
        filteredOrders.where((order) => order.model.toLowerCase().contains(term.toLowerCase())).toList();
    _orders.value.order = filtered;
    _orders.refresh();
  }

  Future<MediaUploadModel> mediaUpload(File photo) async {
    _isUploadingImage.value = true;
    var _result;
    try {
      MediaUploadModel response = await _repository.mediaUpload(photo);
      _result = response;
    } on DioError catch (err) {
      print(err);
    } finally {
      _isUploadingImage.value = false;
    }
    return _result;
  }
}
