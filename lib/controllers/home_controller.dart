import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/models/product_model.dart';
import 'package:procura_online/repositories/product_repository.dart';

class HomeController extends GetxController with StateMixin<ProductModel> {
  final ProductRepository _repository = Get.find();

  RxBool _isLoading = true.obs;
  RxBool _isLoadingMore = false.obs;
  RxBool _hasError = false.obs;
  RxBool _hasErrorMore = false.obs;

  RxInt _page = 1.obs;

  bool get isLoading => _isLoading.value;
  bool get isLoadingMore => _isLoadingMore.value;
  bool get hasError => _hasError.value;
  bool get hasErrorMore => _hasErrorMore.value;

  int get page => _page.value;
  Rx<ProductModel> _results = ProductModel().obs;
  List<Product> get results => _results.value.products;

  bool get isLastPage => page == _results.value.meta.lastPage;

  @override
  void onInit() {
    super.onInit();
    findAll();
  }

  void findAll() async {
    _isLoading.value = true;
    _hasError.value = false;
    _page.value = 1;
    try {
      ProductModel response = await _repository.findAll(page: page);
      _results.value = response;
    } on DioError catch (err) {
      _hasError.value = true;
    } finally {
      _isLoading.value = false;
    }
  }

  void nextPage() async {
    _isLoadingMore.value = true;
    _hasErrorMore.value = false;
    try {
      _page.value = _page.value + 1;
      ProductModel response = await _repository.findAll(page: page);
      _results.update((val) {
        val.products.addAll(response.products);
      });
    } on DioError catch (err) {
      _hasErrorMore.value = true;
      Get.rawSnackbar(
          message: 'Ops, error getting more items.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
    }
    _isLoadingMore.value = false;
  }
}
