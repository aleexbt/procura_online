import 'package:get/get.dart';

class SearchController extends GetxController {
  @override
  onInit() {
    print('INICIADO_SEARCH_CONTROLLER');
    doSearch();
  }

  RxString _searchTerm = ''.obs;
  RxBool _loadingResults = true.obs;
  RxList _results = [].obs;

  RxString _category = 'Select a category'.obs;
  RxString _brand = 'Select a brand'.obs;
  RxString _price = 'Select a price'.obs;
  RxString _location = 'Select a location'.obs;

  String get searchTerm => _searchTerm.value;
  List get results => _results;
  String get category => _category.value;
  String get brand => _brand.value;
  String get price => _price.value;
  String get location => _location.value;

  void setSearchTerm(String value) {
    _searchTerm.value = value;
  }

  void setCategory(String value) {
    _category.value = value;
  }

  void setBrand(String value) {
    _brand.value = value;
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
