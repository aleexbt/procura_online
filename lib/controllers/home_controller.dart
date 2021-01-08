import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/models/listing_model.dart';
import 'package:procura_online/models/product_model.dart';
import 'package:procura_online/repositories/product_repository.dart';
import 'package:procura_online/repositories/vehicle_repository.dart';
import 'package:smart_select/smart_select.dart';

class HomeController extends GetxController with StateMixin<Listing> {
  final ProductRepository _productRepository = Get.find();
  VehicleRepository _vehicleRepository = Get.find();

  @override
  void onInit() {
    super.onInit();
    findAll();
    getBrands();
  }

  RxBool _isLoading = true.obs;
  RxBool _isLoadingMore = false.obs;
  RxBool _isLoadingBrands = false.obs;
  RxBool _isLoadingModels = false.obs;
  RxBool _hasError = false.obs;
  RxBool _loadingMoreError = false.obs;
  RxBool _isSearch = false.obs;
  RxList<Product> _featured = List<Product>().obs;
  RxList<S2Choice<String>> _brands = List<S2Choice<String>>().obs;
  RxList<S2Choice<String>> _models = List<S2Choice<String>>().obs;

  RxString _searchTerm = ''.obs;
  RxString _category = 'All'.obs;
  RxString _categoryValue = 'listings'.obs;
  RxInt _page = 1.obs;

  bool get isLoading => _isLoading.value;
  bool get isLoadingMore => _isLoadingMore.value;
  bool get isLoadingBrands => _isLoadingBrands.value;
  bool get isLoadingModels => _isLoadingModels.value;
  bool get hasError => _hasError.value;
  bool get loadingMoreError => _loadingMoreError.value;
  bool get isSearch => _isSearch.value;
  int get page => _page.value;
  String get category => _category.value;
  String get categoryValue => _categoryValue.value;
  String get searchTerm => _searchTerm.value;

  int get total => _results.value.meta?.total ?? 0;
  Rx<Listing> _results = Listing().obs;
  List<Product> get results => _results.value.products;
  bool get isLastPage => _page.value >= _results.value.meta.lastPage;

  List<Product> get featured => _featured;

  List<S2Choice<String>> get brands => _brands;
  List<S2Choice<String>> get models => _models;

  List<S2Choice<String>> categoryOptions = [
    S2Choice<String>(value: 'listings', title: 'All'),
    S2Choice<String>(value: 'vehicles', title: 'Vehicles'),
    S2Choice<String>(value: 'auto-parts', title: 'Auto Parts'),
  ];

  RxString selectedBrand = ''.obs;
  RxString selectedModel = ''.obs;

  void setBrand(String value) {
    if (value != '' && value != selectedBrand.value) {
      getModels(value);
    }
    selectedBrand.value = value;
  }

  void setSearchTerm(String value) => _searchTerm.value = value;
  void setModel(String value) => selectedModel.value = value;

  void findAll({bool skipLoading = false}) async {
    _isLoading.value = !skipLoading;
    _hasError.value = false;
    _page.value = 1;
    print(_categoryValue.value);
    try {
      Listing response = await _productRepository.findAll(category: _categoryValue.value, page: page);
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
      Listing response = await _productRepository.productSearch(_categoryValue.value, _searchTerm.value, page: page);
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
      if (_searchTerm.value.isNullOrBlank && selectedBrand.value.isNullOrBlank && selectedModel.value.isNullOrBlank) {
        _isSearch.value = false;
        Listing response = await _productRepository.findAll(page: page);
        _results.value = response;
      } else {
        Listing response = await _productRepository.productSearch(
          _categoryValue.value,
          _searchTerm.value,
          brand: selectedBrand.value,
          model: selectedModel.value,
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

  void clear() {
    print('clear');
    _isSearch.value = false;
    selectedBrand.value = '';
    selectedModel.value = '';
  }
}
