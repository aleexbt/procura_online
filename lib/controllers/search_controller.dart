import 'package:get/get.dart';
import 'package:procura_online/repositories/product_repository.dart';
import 'package:procura_online/repositories/vehicle_repository.dart';

class SearchController extends GetxController {
  VehicleRepository _vehicleRepository = Get.put(VehicleRepository());
  ProductRepository _productRepository = Get.put(ProductRepository());

  @override
  onInit() {
    getBrands();
    super.onInit();
  }

  RxString _searchTerm = ''.obs;
  RxList _results = [].obs;

  RxString _category = 'Select a category'.obs;
  RxString _categoryValue = 'auto'.obs;
  RxString _brand = 'Select a brand'.obs;
  RxString _model = 'Select a model'.obs;
  RxString _price = 'Select a price'.obs;
  RxString _location = 'Select a location'.obs;

  RxBool _isLoadingMakers = false.obs;
  RxBool _isLoadingModels = false.obs;

  bool get isLoadingMakers => _isLoadingMakers.value;
  bool get isLoadingModels => _isLoadingModels.value;

  RxList<String> _brands = List<String>().obs;
  RxList<String> _models = List<String>().obs;

  List<String> get brands => _brands;
  List<String> get models => _models;

  String get searchTerm => _searchTerm.value;
  List get results => _results;

  String get categoryName => _category.value;
  String get category => _categoryValue.value;
  String get brand => _brand.value;
  String get model => _model.value;

  String get price => _price.value;
  String get location => _location.value;

  void getBrands() async {
    try {
      _isLoadingMakers.value = true;
      List<String> makers = await _vehicleRepository.getMakers();
      if (makers.length > 0) {
        _brands.assignAll(makers);
      }
    } catch (err) {
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

  void setSearchTerm(String value) => _searchTerm.value = value;

  void setCategory({String name, String value}) {
    _category.value = name;
    _categoryValue.value = value;
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
}
