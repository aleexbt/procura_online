import 'package:get/get.dart';
import 'package:procura_online/repositories/vehicle_repository.dart';

class SearchController extends GetxController {
  VehicleRepository _vehicleRepository = Get.put(VehicleRepository());

  @override
  onInit() {
    getMakers();
    super.onInit();
  }

  RxString _searchTerm = ''.obs;
  RxBool _loadingResults = true.obs;
  RxList _results = [].obs;

  RxString _category = 'Select a category'.obs;
  RxString _brand = 'Select a brand'.obs;
  RxString _model = 'Select a model'.obs;
  RxString _price = 'Select a price'.obs;
  RxString _location = 'Select a location'.obs;

  RxBool _isLoadingMakers = false.obs;
  RxBool _isLoadingModels = false.obs;

  bool get isLoadingMakers => _isLoadingMakers.value;
  bool get isLoadingModels => _isLoadingModels.value;

  RxList<String> _makers = List<String>().obs;
  RxList<String> _models = List<String>().obs;

  List<String> get makers => _makers;
  List<String> get models => _models;

  String get searchTerm => _searchTerm.value;
  List get results => _results;
  String get category => _category.value;
  String get brand => _brand.value;
  String get model => _model.value;
  String get price => _price.value;
  String get location => _location.value;

  void getMakers() async {
    try {
      print('GETTING MAKERS...');
      _isLoadingMakers.value = true;
      List<String> makers = await _vehicleRepository.getMakers();
      if (makers.length > 0) {
        _makers.assignAll(makers);
      }
    } catch (err) {
      print('GETTING MAKERS FAILED');
      print(err);
    } finally {
      _isLoadingMakers.value = false;
    }
  }

  void getModels(String model) async {
    try {
      _isLoadingModels.value = true;
      List<String> models = await _vehicleRepository.getModels(model);
      if (models.length > 0) {
        _models.assignAll(models);
      }
    } catch (err) {
      print(err);
    } finally {
      _isLoadingModels.value = false;
    }
  }

  void setSearchTerm(String value) {
    _searchTerm.value = value;
  }

  void setCategory(String value) {
    _category.value = value;
  }

  void setBrand(String value) {
    _brand.value = value;
    _model.value = 'Select a model';
    _models.assignAll([]);
    getModels(_brand.value);
  }

  void setModel(String value) {
    _model.value = value;
  }

  void setPrice(String value) {
    _price.value = value;
  }

  void setLocation(String value) {
    _location.value = value;
  }

  Future<void> doSearch() async {
    print('SEARCHING FOR: $searchTerm');
    _loadingResults.value = true;
    await Future.delayed(Duration(seconds: 2));
    _loadingResults.value = false;
    return null;
  }
}
