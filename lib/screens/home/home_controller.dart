import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/models/product_model.dart';
import 'package:procura_online/repositories/product_repository.dart';

class HomeController extends GetxController with StateMixin<ProductModel> {
  final ProductRepository _repository = Get.find();

  RxBool _isLoading = true.obs;
  RxBool _isLoadingMore = false.obs;
  RxBool _hasError = false.obs;

  RxInt _page = 1.obs;

  bool get isLoading => _isLoading.value;
  bool get isLoadingMore => _isLoadingMore.value;
  bool get hasError => _hasError.value;

  int get page => _page.value;
  Rx<ProductModel> _results = ProductModel().obs;
  List<Products> get results => _results.value.products;

  bool get isLastPage => page == _results.value.meta.lastPage;

  @override
  void onInit() {
    super.onInit();
    findAll();
  }

  // void findAll() {
  //   _repository.findAll(page: page).then((res) {
  //     change(res, status: RxStatus.success());
  //     _results.value = res;
  //   }, onError: (err) {
  //     change(null, status: RxStatus.error('Error on get listings'));
  //   });
  // }

  void findAll() async {
    _isLoading.value = true;
    await _repository.findAll(page: page).then((res) {
      change(res, status: RxStatus.success());
      _results.value = res;
      _isLoading.value = false;
    }, onError: (err) {
      change(null, status: RxStatus.error('Error on get listings'));
      print(err);
      _hasError.value = true;
      _isLoading.value = false;
      Get.rawSnackbar(
          message: 'Ops, something went wrong.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
    });
  }

  void nextPage() async {
    _isLoadingMore.value = true;
    _page.value = _page.value + 1;
    print('next_page $page');
    var response = await _repository.findAll(page: page);
    _results.update((val) {
      value.products.addAll(response.products);
    });
    _isLoadingMore.value = false;
  }

  void nextPage2() async {
    print('nextPage2');
    _isLoadingMore.value = true;
    _page.value = _page.value + 1;

    _repository.findAll(page: page).then((res) {
      // List<Products> products = [..._results.value.products, res.products];
      // ProductModel newList = ProductModel(products: products);
      res.products.forEach((element) {
        results.add(element);
      });
      change(_results.value, status: RxStatus.success());
      _results.value = res;
      _isLoading.value = false;
    }, onError: (err) {
      change(null, status: RxStatus.error('Error on get listings'));
      print(err);
      _hasError.value = true;
      _isLoading.value = false;
      Get.rawSnackbar(
          message: 'Ops, something went wrong.', backgroundColor: Colors.red, duration: Duration(seconds: 3));
    });
  }
}
