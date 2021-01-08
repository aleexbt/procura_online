import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/controllers/search_controller.dart';
import 'package:procura_online/models/listing_model.dart';
import 'package:procura_online/models/product_model.dart';
import 'package:procura_online/repositories/product_repository.dart';

class HomeController extends GetxController with StateMixin<Listing> {
  final ProductRepository _repository = Get.find();
  final SearchController _searchController = Get.find();

  RxBool _isLoading = true.obs;
  RxBool _isLoadingMore = false.obs;
  RxBool _hasError = false.obs;
  RxBool _loadingMoreError = false.obs;
  RxBool _isSearch = false.obs;
  RxList<Product> _featured = List<Product>().obs;

  RxString _category = 'listings'.obs;
  RxInt _page = 1.obs;

  bool get isLoading => _isLoading.value;
  bool get isLoadingMore => _isLoadingMore.value;
  bool get hasError => _hasError.value;
  bool get loadingMoreError => _loadingMoreError.value;
  bool get isSearch => _isSearch.value;

  int get page => _page.value;
  String get category => _category.value;

  int get total => _results.value.meta?.total ?? 0;
  Rx<Listing> _results = Listing().obs;
  List<Product> get results => _results.value.products;
  bool get isLastPage => _page.value >= _results.value.meta.lastPage;

  List<Product> get featured => _featured;

  @override
  void onInit() {
    super.onInit();
    findAll();
  }

  void findAll({bool skipLoading = false}) async {
    _isLoading.value = !skipLoading;
    _hasError.value = false;
    _page.value = 1;
    try {
      Listing response = await _repository.findAll(category: category, page: page);
      _results.value = response;

      Iterable<Product> featured = response.products.where((element) => element.featured == "1");
      _featured.assignAll(featured);
    } on DioError catch (err) {
      print(err);
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
    _loadingMoreError.value = false;
    try {
      _page.value = _page.value + 1;
      Listing response = await _repository.findAll(page: page);
      _results.update((val) {
        val.products.addAll(response.products);
      });
    } on DioError catch (err) {
      _loadingMoreError.value = true;
      Get.rawSnackbar(
          message: 'Ops, error getting more items.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
    } catch (err) {
      _loadingMoreError.value = true;
      Get.rawSnackbar(
          message: 'Ops, error getting more items.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
    } finally {
      _isLoadingMore.value = false;
    }
  }

  void nextPageSearch() async {
    _page.value = 1;
    _isLoadingMore.value = true;
    _loadingMoreError.value = false;
    try {
      _page.value = _page.value + 1;
      Listing response =
          await _repository.productSearch(_searchController.category, _searchController.searchTerm, page: page);
      _results.update((val) {
        val.products.addAll(response.products);
      });
    } on DioError catch (err) {
      _loadingMoreError.value = true;
      Get.rawSnackbar(
          message: 'Ops, error getting more items.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
    } catch (err) {
      _loadingMoreError.value = true;
      Get.rawSnackbar(
          message: 'Ops, error getting more items.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
    } finally {
      _isLoadingMore.value = false;
    }
  }

  Future<void> doSearch({bool skipLoading = false}) async {
    _page.value = 1;
    _isSearch.value = true;
    _isLoading.value = !skipLoading;
    _hasError.value = false;
    try {
      if (_searchController.searchTerm.isNullOrBlank) {
        _isSearch.value = false;
        Listing response = await _repository.findAll(page: page);
        _results.value = response;
      } else {
        Listing response = await _repository.productSearch(
          _searchController.category,
          _searchController.searchTerm,
          brand: _searchController.selectedBrand,
          model: _searchController.selectedModel,
        );
        _results.value = response;
      }
    } on DioError catch (err) {
      print(err);
      _hasError.value = true;
    } catch (err) {
      print(err);
      _hasError.value = true;
    } finally {
      _isLoading.value = false;
    }
  }
}
