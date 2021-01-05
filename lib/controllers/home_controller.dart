import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/controllers/search_controller.dart';
import 'package:procura_online/models/product_model.dart';
import 'package:procura_online/repositories/product_repository.dart';

class HomeController extends GetxController with StateMixin<ProductModel> {
  final ProductRepository _repository = Get.find();
  final SearchController _searchController = Get.find();

  RxBool _isLoading = true.obs;
  RxBool _isLoadingMore = false.obs;
  RxBool _hasError = false.obs;
  RxBool _hasErrorMore = false.obs;
  RxBool _isSearch = false.obs;

  RxString _category = 'listings'.obs;
  RxInt _page = 1.obs;

  bool get isLoading => _isLoading.value;
  bool get isLoadingMore => _isLoadingMore.value;
  bool get hasError => _hasError.value;
  bool get hasErrorMore => _hasErrorMore.value;
  bool get isSearch => _isSearch.value;

  int get page => _page.value;
  String get category => _category.value;

  int get total => _results.value.meta?.total ?? 0;
  Rx<ProductModel> _results = ProductModel().obs;
  List<Product> get results => _results.value.products;
  bool get isLastPage => _page.value >= _results.value.meta.lastPage;

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
      ProductModel response = await _repository.findAll(category: category, page: page);
      _results.value = response;
    } on DioError catch (err) {
      _hasError.value = true;
    } finally {
      _isLoading.value = false;
    }
  }

  void changeCategory(String category) {
    _category.value = category;
    findAll();
  }

  void getNextPage() {
    if (isLastPage) {
      return;
    } else if (_isSearch.value) {
      return nextPageSearch();
    } else {
      nextPage();
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

  void nextPageSearch() async {
    _page.value = 1;
    _isLoadingMore.value = true;
    _hasErrorMore.value = false;
    try {
      _page.value = _page.value + 1;
      ProductModel response =
          await _repository.productSearch(_searchController.category, _searchController.searchTerm, page: page);
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

  Future<void> doSearch() async {
    _page.value = 1;
    _isSearch.value = true;
    _isLoading.value = true;
    _hasError.value = false;
    try {
      if (_searchController.searchTerm.isNullOrBlank) {
        _isSearch.value = false;
        ProductModel response = await _repository.findAll(page: page);
        _results.value = response;
      } else {
        ProductModel response =
            await _repository.productSearch(_searchController.category, _searchController.searchTerm);
        _results.value = response;
      }
    } catch (err) {
      print(err);
    } finally {
      _isLoading.value = false;
    }
  }
}
