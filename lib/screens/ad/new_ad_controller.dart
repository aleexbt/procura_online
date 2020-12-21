import 'package:get/get.dart';
import 'package:procura_online/repositories/vehicle_repository.dart';
import 'package:smart_select/smart_select.dart';

class NewAdController extends GetxController {
  VehicleRepository _vehicleRepository = Get.put(VehicleRepository());

  @override
  onInit() {
    getBrands();
    super.onInit();
  }

  RxString _selectedBrand = ''.obs;
  RxString _selectedModel = ''.obs;

  String get selectedBrand => _selectedBrand.value;
  String get selectedModel => _selectedModel.value;

  RxBool _isLoadingBrands = false.obs;
  RxBool _isLoadingModels = false.obs;
  bool get isLoadingBrands => _isLoadingBrands.value;
  bool get isLoadingModels => _isLoadingModels.value;

  RxList<S2Choice<String>> _brands = List<S2Choice<String>>().obs;
  RxList<S2Choice<String>> _models = List<S2Choice<String>>().obs;
  List<S2Choice<String>> get brands => _brands;
  List<S2Choice<String>> get models => _models;

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

  void setBrand(String value) {
    if (value != '' && value != _selectedBrand.value) {
      getModels(value);
    }
    _selectedBrand.value = value;
  }

  void setModel(String value) {
    _selectedModel.value = value;
  }
}
