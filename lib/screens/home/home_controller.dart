import 'package:get/get.dart';
import 'package:procura_online/models/listing_model.dart';
import 'package:procura_online/repository/api_repository.dart';

class HomeScreenController extends GetxController with StateMixin<ListingModel> {
  final ApiRepository _repository = Get.find();

  @override
  void onInit() {
    super.onInit();
    _repository.findAll().then((res) {
      change(res, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error('Error on get listings'));
    });
  }

  // RxBool _isLoading = true.obs;
  // RxBool _hasError = false.obs;
  // RxList _listing = [].obs;
  //
  // bool get isLoading => _isLoading.value;
  // bool get hasError => _hasError.value;
  // List get listings => _listing;

  // Future<ListingModel> getAll() async {
  //   print('CALLED');
  //   ResponseHandler data = await ListingApi.getAll();
  //   ListingModel dados = ListingModel.fromJson(data.response);
  //   // List<ListingModel> dados = data.response.map((i) => ListingModel.fromJson(i)).toList();
  //   // List<Data> dataa = Data.fromJson(json)
  //
  //   // print(dados.data[0].title);
  //   return dados;
  // }
}
