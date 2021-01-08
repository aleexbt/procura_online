import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/controllers/home_controller.dart';
import 'package:procura_online/controllers/search_controller.dart';
import 'package:procura_online/widgets/gradient_button.dart';
import 'package:procura_online/widgets/select_option.dart';

class FilterScreen extends StatelessWidget {
  final HomeController _homeController = Get.find();
  final SearchController _searchController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Filter results'),
        actions: [
          FlatButton(
            onPressed: () => [_searchController.clear(), _homeController.doSearch(), Get.back()],
            child: Text(
              'CLEAR',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            isLoading: _searchController.isLoadingBrands,
                            placeholder: 'Select one',
                            modalTitle: 'Brands',
                            selectText: 'Select a brand',
                            value: _searchController.selectedBrand,
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
                            isLoading: _searchController.isLoadingModels,
                            isDisabled: _searchController.selectedBrand == '',
                            placeholder: 'Select one',
                            modalTitle: 'Models',
                            selectText: 'Select a model',
                            value: _searchController.selectedModel,
                            choiceItems: _searchController.models,
                            onChange: (state) => _searchController.setModel(state.value),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                        width: 230,
                        child:
                            GradientButton(text: 'Search', onPressed: () => [_homeController.doSearch(), Get.back()])),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
