import 'package:get/get.dart';
import 'package:procura_online/models/listing_model.dart';
import 'package:procura_online/repositories/product_repository.dart';

class HomeController extends GetxController with StateMixin<ListingModel> {
  final ProductRepository _repository = Get.find();

  RxBool _isLoadingMore = false.obs;
  RxInt _page = 1.obs;

  bool get isLoadingMore => _isLoadingMore.value;
  int get page => _page.value;
  Rx<ListingModel> _results = ListingModel().obs;
  ListingModel get results => _results.value;

  bool get isLastPage => page == results.meta.lastPage;

  @override
  void onInit() {
    super.onInit();
    findAll();
  }

  void findAll() {
    _repository.findAll(page: page).then((res) {
      change(res, status: RxStatus.success());
      _results.value = res;
    }, onError: (err) {
      change(null, status: RxStatus.error('Error on get listings'));
    });
  }

  void nextPage() async {
    _isLoadingMore.value = true;
    _page.value = _page.value + 1;
    var response = await _repository.findAll(page: page);
    _results.update((val) {
      value.data.addAll(response.data);
    });
    _isLoadingMore.value = false;
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
