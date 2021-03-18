import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:procura_online/repositories/user_repository.dart';
import 'package:procura_online/repositories/vehicle_repository.dart';
import 'package:smart_select/smart_select.dart';

class SearchController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getBrands();
    getDistricts();
  }

  VehicleRepository _vehicleRepository = Get.find();
  UserRepository _userRepository = Get.find();

  RxBool isFiltered = false.obs;
  RxBool isLoadingBrands = false.obs;
  RxBool isLoadingModels = false.obs;
  RxBool isLoadingDistricts = false.obs;
  RxList<S2Choice<String>> _brands = List<S2Choice<String>>.empty(growable: true).obs;
  RxList<S2Choice<String>> _models = List<S2Choice<String>>.empty(growable: true).obs;
  RxList<S2Choice<int>> _districts = List<S2Choice<int>>.empty(growable: true).obs;

  RxString keyword = ''.obs;
  RxInt searchType = 0.obs;
  RxString brand = ''.obs;
  RxString model = ''.obs;
  Rx<TextEditingController> yearFrom = TextEditingController().obs;
  Rx<TextEditingController> yearTo = TextEditingController().obs;
  Rx<TextEditingController> priceFrom = TextEditingController().obs;
  Rx<TextEditingController> priceTo = TextEditingController().obs;
  Rx<TextEditingController> miliageFrom = TextEditingController().obs;
  Rx<TextEditingController> miliageTo = TextEditingController().obs;
  RxString fuel = ''.obs;
  RxInt district = 0.obs;

  List<S2Choice<String>> get brands => _brands;
  List<S2Choice<String>> get models => _models;
  List<S2Choice<int>> get districts => _districts;

  List<S2Choice<String>> fuelOptions = [
    S2Choice<String>(value: 'gas', title: 'Gás'),
    S2Choice<String>(value: 'electric', title: 'Eléctrico'),
    S2Choice<String>(value: 'diesel', title: 'Gásoleo'),
    S2Choice<String>(value: 'gasoline', title: 'Gasolina'),
    S2Choice<String>(value: 'hybrid', title: 'Híbrido'),
  ];

  void setBrand(String value) {
    if (value != '' && value != brand.value) {
      getModels(value);
    }
    brand.value = value;
  }

  void getBrands() async {
    try {
      isLoadingBrands.value = true;
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
      isLoadingBrands.value = false;
    }
  }

  void getModels(String brand) async {
    try {
      isLoadingModels.value = true;
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
      isLoadingModels.value = false;
    }
  }

  void getDistricts() async {
    isLoadingDistricts.value = true;
    try {
      List response = await _userRepository.getDistricts();
      List<S2Choice<int>> districtsList = List<S2Choice<int>>.empty(growable: true);

      if (response != null) {
        response.forEach((district) {
          districtsList.add(S2Choice<int>(value: district['id'], title: district['name']));
        });
        _districts.assignAll(districtsList);
      }
    } catch (err) {
      print(err);
    } finally {
      isLoadingDistricts.value = false;
    }
  }

  void clearFilter() {
    brand.value = '';
    model.value = '';
    yearFrom.value.clear();
    yearTo.value.clear();
    priceFrom.value.clear();
    priceTo.value.clear();
    miliageFrom.value.clear();
    miliageTo.value.clear();
    fuel.value = '';
    district.value = 0;
  }
}
