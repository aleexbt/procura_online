import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/controllers/search_controller.dart';
import 'package:procura_online/models/listing_model.dart';
import 'package:procura_online/models/product_model.dart';
import 'package:procura_online/repositories/product_repository.dart';
import 'package:smart_select/smart_select.dart';

class HomeController extends GetxController with StateMixin<Listing> {
  final ProductRepository _productRepository = Get.find();
  final SearchController _searchController = Get.find();

  @override
  void onInit() {
    super.onInit();
    findAll();
  }

  RxBool _isLoading = true.obs;
  RxBool _isLoadingMore = false.obs;
  RxBool _hasError = false.obs;
  RxBool _loadingMoreError = false.obs;
  RxBool _isSearch = false.obs;
  RxList<Product> _featured = List<Product>.empty(growable: true).obs;

  RxString _category = 'All'.obs;
  RxString _categoryValue = 'listings'.obs;
  RxInt _page = 1.obs;

  bool get isLoading => _isLoading.value;
  bool get isLoadingMore => _isLoadingMore.value;
  bool get hasError => _hasError.value;
  bool get loadingMoreError => _loadingMoreError.value;
  bool get isSearch => _isSearch.value;
  int get page => _page.value;
  String get category => _category.value;
  String get categoryValue => _categoryValue.value;

  int get total => _results.value.meta?.total ?? 0;
  Rx<Listing> _results = Listing().obs;
  List<Product> get results => _results.value.products;
  bool get isLastPage => _page.value >= _results.value.meta.lastPage;

  List<Product> get featured => _featured;

  List<S2Choice<String>> categoryOptions = [
    S2Choice<String>(value: 'listings', title: 'All'),
    S2Choice<String>(value: 'vehicles', title: 'Vehicles'),
    S2Choice<String>(value: 'auto-parts', title: 'Auto Parts'),
  ];

  void findAll({bool skipLoading = false}) async {
    _isLoading.value = !skipLoading;
    _hasError.value = false;
    _page.value = 1;
    try {
      Listing response = await _productRepository.findAll(category: _categoryValue.value, page: page);
      _results.value = response;

      Iterable<Product> featured = response.products.where((item) => item.featured == 1);
      _featured.assignAll(featured);
    } on DioError catch (err) {
      print(err);
      _hasError.value = true;
    } finally {
      _isLoading.value = false;
    }
  }

  void changeCategory({String name, String value}) {
    _category.value = name;
    _categoryValue.value = value;
    findAll();
  }

  void setCategory({String name, String value}) {
    _category.value = name;
    _categoryValue.value = value;
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
      Listing response = await _productRepository.findAll(category: _categoryValue.value, page: page);
      _results.update((val) {
        val.products.addAll(response.products);
      });
    } on DioError catch (err) {
      _loadingMoreError.value = true;
      Get.rawSnackbar(
          message: 'Ops, erro ao carregar mais items.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
    } catch (err) {
      _loadingMoreError.value = true;
      Get.rawSnackbar(
          message: 'Ops, erro ao carregar mais items.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
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
          await _productRepository.productSearch(_categoryValue.value, _searchController.keyword.value, page: page);
      _results.update((val) {
        val.products.addAll(response.products);
      });
    } on DioError catch (err) {
      _loadingMoreError.value = true;
      Get.rawSnackbar(
          message: 'Ops, erro ao carregar mais items.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
    } catch (err) {
      _loadingMoreError.value = true;
      Get.rawSnackbar(
          message: 'Ops, erro ao carregar mais items.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
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
      if (!_searchController.isFiltered.value && _searchController.keyword.value.isBlank) {
        _isSearch.value = false;
        Listing response = await _productRepository.findAll(page: page);
        _results.value = response;
      } else {
        Listing response = await _productRepository.productSearch(
          _searchController.searchType.value,
          _searchController.keyword.value,
          brand: _searchController.brand.value,
          model: _searchController.model.value,
          fuelType: _searchController.fuel.value,
          priceFrom: int.tryParse(_searchController.priceFrom.value.value.text) ?? 0,
          priceTo: int.tryParse(_searchController.priceTo.value.value.text) ?? 999999999,
          miliageFrom: int.tryParse(_searchController.miliageFrom.value.value.text) ?? 0,
          miliageTo: int.tryParse(_searchController.miliageTo.value.value.text) ?? 999999999,
          yearFrom: int.tryParse(_searchController.yearFrom.value.value.text) ?? 0,
          yearTo: int.tryParse(_searchController.yearTo.value.value.text) ?? 9999,
          districtId: _searchController.district.value,
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

  void clear() {
    _isSearch.value = false;
  }
}
