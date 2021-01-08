import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:procura_online/models/product_model.dart';
import 'package:procura_online/repositories/product_repository.dart';

class ProductController extends GetxController {
  final ProductRepository _productRepository = Get.find();
  final String productId = Get.parameters['id'];

  RxBool _isLoading = false.obs;
  RxBool _hasError = false.obs;
  Rx<Product> _product = Product().obs;

  bool get isLoading => _isLoading.value;
  bool get hasError => _hasError.value;
  Product get product => _product.value;

  @override
  void onInit() {
    findOne();
    super.onInit();
  }

  void findOne() async {
    _isLoading.value = true;
    _hasError.value = false;
    try {
      Product response = await _productRepository.findOne(productId);
      _product.value = response;
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
