import 'package:get/get.dart';
import 'package:procura_online/models/product_model.dart';
import 'package:procura_online/repositories/product_repository.dart';

class ProductController extends GetxController with StateMixin<Products> {
  final ProductRepository _repository = Get.find();

  @override
  void onInit() {
    findOne();
    super.onInit();
  }

  void findOne() {
    _repository.findOne(Get.parameters['id']).then((res) {
      change(res, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error('Oh no, this product can\'t be found :('));
    });
  }
}
