import 'package:get/get.dart';
import 'package:procura_online/models/listing_model.dart';
import 'package:procura_online/repository/api_repository.dart';

class ProductScreenController extends GetxController with StateMixin<ListingItem> {
  final ApiRepository _repository = Get.find();

  @override
  void onInit() {
    _repository.findOne(Get.parameters['id']).then((res) {
      change(res, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error('Oh no, this product can\'t be found :('));
    });
    super.onInit();
  }
}
