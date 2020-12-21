import 'package:get/get.dart';
import 'package:procura_online/api/listing.dart';
import 'package:procura_online/models/product_model.dart';
import 'package:procura_online/models/response_handler.dart';

class DetailsController extends GetxController {
  // @override
  // onInit() {
  //   // getOne('20');
  //   super.onInit();
  // }

  RxBool _isLoading = true.obs;
  RxBool _hasError = false.obs;
  Rx<Products> _data = Products().obs;

  bool get isLoading => _isLoading.value;
  bool get hasError => _hasError.value;
  Products get data => _data.value;

  Future<Products> getOne(String id) async {
    ResponseHandler data = await ListingApi.getOne(id);
    if (data.hasError) {
      _hasError.value = true;
      _isLoading.value = false;
    } else {
      Products dados = Products.fromJson(data.response['data']);
      _data.value = dados;
      _hasError.value = false;
      _isLoading.value = false;
    }
    return null;
  }
}
