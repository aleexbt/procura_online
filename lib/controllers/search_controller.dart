import 'package:get/get.dart';
import 'package:procura_online/repositories/vehicle_repository.dart';
import 'package:smart_select/smart_select.dart';

class SearchController extends GetxController {
  VehicleRepository _vehicleRepository = Get.find();

  @override
  onInit() {
    getBrands();
    super.onInit();
  }

  RxString _searchTerm = ''.obs;

  RxString _brand = 'Select a brand'.obs;
  RxString _model = 'Select a model'.obs;
  RxString _category = 'Listings'.obs;
  RxString _categoryValue = 'listings'.obs;

  RxBool _isLoadingBrands = false.obs;
  RxBool _isLoadingModels = false.obs;

  bool get isLoadingBrands => _isLoadingBrands.value;
  bool get isLoadingModels => _isLoadingModels.value;

  RxList<S2Choice<String>> _brands = List<S2Choice<String>>().obs;
  RxList<S2Choice<String>> _models = List<S2Choice<String>>().obs;

  List<S2Choice<String>> get brands => _brands;
  List<S2Choice<String>> get models => _models;

  String get searchTerm => _searchTerm.value;

  String get brand => _brand.value;
  String get model => _model.value;
  String get category => _category.value;
  String get categoryValue => _categoryValue.value;

  RxString _selectedBrand = ''.obs;
  RxString _selectedModel = ''.obs;

  String get selectedBrand => _selectedBrand.value;
  String get selectedModel => _selectedModel.value;

  void getBrands() async {
    try {
      _isLoadingBrands.value = true;
      List<String> brands = await _vehicleRepository.getMakers();
      if (brands.length > 0) {
        List<S2Choice<String>> options = S2Choice.listFrom<String, dynamic>(
          source: brands,
          value: (index, item) => item,
          title: (index, item) => item,
        );
        _brands.assignAll(options);
      }
    } catch (err) {
      print(err);
    } finally {
      _isLoadingBrands.value = false;
    }
  }

  void getModels(String brand) async {
    try {
      _isLoadingModels.value = true;
      List<String> models = await _vehicleRepository.getModels(brand);
      if (models.length > 0) {
        List<S2Choice<String>> options = S2Choice.listFrom<String, dynamic>(
          source: models,
          value: (index, item) => item,
          title: (index, item) => item,
        );
        _models.assignAll(options);
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
    if (value != '' && value != _selectedBrand.value) {
      getModels(value);
    }
    _selectedBrand.value = value;
  }

  void setModel(String value) {
    _selectedModel.value = value;
  }

  void clear() {
    print('clear');
    _selectedBrand.update((val) {
      val = '';
    });
    _selectedModel.update((val) {
      val = '';
    });
    _selectedBrand.value = '';
    _selectedModel.value = '';
    _selectedBrand.refresh();
    _selectedModel.refresh();
  }
}
