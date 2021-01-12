import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/models/listing_model.dart';
import 'package:procura_online/repositories/user_repository.dart';

class AdsListingController extends GetxController {
  final UserRepository _userRepository = Get.find();

  @override
  void onInit() {
    findAll();
    super.onInit();
  }

  RxBool _isLoading = true.obs;
  RxBool _isLoadingMore = false.obs;
  RxBool _hasError = false.obs;
  RxBool _loadingMoreError = false.obs;
  Rx<Listing> _result = Listing().obs;
  RxInt _page = 1.obs;

  bool get isLoading => _isLoading.value;
  bool get isLoadingMore => _isLoadingMore.value;
  bool get hasError => _hasError.value;
  bool get loadingMoreError => _loadingMoreError.value;
  Listing get result => _result.value;
  int get page => _page.value;
  bool get isLastPage => _page.value == _result.value.meta.lastPage;

  void findAll({skipLoading = false}) async {
    _isLoading.value = !skipLoading;
    _hasError.value = false;
    try {
      Listing response = await _userRepository.adsListing(page: _page.value);
      _result.value = response;
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

  void nextPage() async {
    _isLoadingMore.value = true;
    _loadingMoreError.value = false;
    try {
      _page.value = _page.value + 1;
      Listing response = await _userRepository.adsListing(page: page);
      _result.update((val) {
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
}
