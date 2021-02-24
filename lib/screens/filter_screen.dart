import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/controllers/home_controller.dart';
import 'package:procura_online/controllers/search_controller.dart';
import 'package:procura_online/widgets/gradient_button.dart';
import 'package:procura_online/widgets/select_option.dart';
import 'package:procura_online/widgets/select_option_logo.dart';
import 'package:procura_online/widgets/text_input.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> with TickerProviderStateMixin {
  final HomeController _homeController = Get.find();
  final SearchController _searchController = Get.find();
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.index = _searchController.searchType.value;
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _searchController.searchType.value = _tabController.index;
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Filter results'),
        actions: [
          FlatButton(
            onPressed: () =>
                [_searchController.clearFilter(), _homeController.clear(), _homeController.findAll(), Get.back()],
            child: Text(
              'CLEAR',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Vehicle'),
            Tab(text: 'Auto Parts'),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Text(
                    'Brand',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Obx(
                    () => SelectOptionLogo(
                      enableFilter: true,
                      isLoading: _searchController.isLoadingBrands.value,
                      placeholder: 'Select one',
                      modalTitle: 'Brands',
                      selectText: 'Select a brand',
                      value: _searchController.brand.value,
                      choiceItems: _searchController.brands,
                      onChange: (state) => _searchController.setBrand(state.value),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Model',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Obx(
                    () => SelectOption(
                      enableFilter: true,
                      isLoading: _searchController.isLoadingModels.value,
                      isDisabled: _searchController.brand.value == '',
                      placeholder: 'Select one',
                      modalTitle: 'Models',
                      selectText: 'Select a model',
                      value: _searchController.model.value,
                      choiceItems: _searchController.models,
                      onChange: (state) => [_searchController.model.value = state.value],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Year',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextInput(
                          controller: _searchController.yearFrom.value,
                          fillColor: Colors.grey[200],
                          hintText: 'From',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CustomTextInput(
                          controller: _searchController.yearTo.value,
                          fillColor: Colors.grey[200],
                          hintText: 'To',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Price',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextInput(
                          controller: _searchController.priceFrom.value,
                          fillColor: Colors.grey[200],
                          hintText: 'From',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CustomTextInput(
                          controller: _searchController.priceTo.value,
                          fillColor: Colors.grey[200],
                          hintText: 'To',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Miliage',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextInput(
                          controller: _searchController.miliageFrom.value,
                          fillColor: Colors.grey[200],
                          hintText: 'From',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CustomTextInput(
                          controller: _searchController.miliageTo.value,
                          fillColor: Colors.grey[200],
                          hintText: 'To',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Fuel',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Obx(
                    () => SelectOption(
                      placeholder: 'Select one',
                      modalTitle: 'Fuel Type',
                      selectText: 'Select a fuel type',
                      value: _searchController.fuel.value,
                      choiceItems: _searchController.fuelOptions,
                      onChange: (state) => _searchController.fuel.value = state.value,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Location',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Obx(
                    () => SelectOption(
                      enableFilter: true,
                      isLoading: _searchController.isLoadingDistricts.value,
                      placeholder: 'Select one',
                      modalTitle: 'Location',
                      selectText: 'Select a location',
                      value: _searchController.district.value,
                      choiceItems: _searchController.districts,
                      onChange: (state) => _searchController.district.value = state.value,
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 280,
                    child: GradientButton(
                      text: 'Filter',
                      onPressed: () =>
                          [_searchController.isFiltered.value = true, _homeController.doSearch(), Get.back()],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Text(
                    'Brands',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Obx(
                    () => SelectOption(
                      enableFilter: true,
                      isLoading: _searchController.isLoadingBrands.value,
                      placeholder: 'Select one',
                      modalTitle: 'Brands',
                      selectText: 'Select a brand',
                      value: _searchController.brand.value,
                      choiceItems: _searchController.brands,
                      onChange: (state) => _searchController.setBrand(state.value),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Models',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Obx(
                    () => SelectOption(
                      enableFilter: true,
                      isLoading: _searchController.isLoadingModels.value,
                      isDisabled: _searchController.brand.value == '',
                      placeholder: 'Select one',
                      modalTitle: 'Models',
                      selectText: 'Select a model',
                      value: _searchController.model.value,
                      choiceItems: _searchController.models,
                      onChange: (state) => _searchController.model.value = state.value,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Location',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Obx(
                    () => SelectOption(
                      enableFilter: true,
                      isLoading: _searchController.isLoadingDistricts.value,
                      placeholder: 'Select one',
                      modalTitle: 'Location',
                      selectText: 'Select a location',
                      value: _searchController.district.value,
                      choiceItems: _searchController.districts,
                      onChange: (state) => _searchController.district.value = state.value,
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 280,
                    child: GradientButton(
                      text: 'Filter',
                      onPressed: () =>
                          [_searchController.isFiltered.value = true, _homeController.doSearch(), Get.back()],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
