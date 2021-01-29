import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/controllers/home_controller.dart';
import 'package:procura_online/widgets/gradient_button.dart';
import 'package:procura_online/widgets/select_option.dart';

class FilterScreen extends StatelessWidget {
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Filter results'),
        actions: [
          FlatButton(
            onPressed: () => [_homeController.clear(), _homeController.findAll(), Get.back()],
            child: Text(
              'CLEAR',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
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
                            'Category',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Obx(
                            () => SelectOption(
                              placeholder: 'Select one',
                              modalTitle: 'Categories',
                              selectText: 'Select a category',
                              value: _homeController.categoryValue,
                              choiceItems: _homeController.categoryOptions,
                              onChange: (state) =>
                                  _homeController.changeCategory(name: state.valueTitle, value: state.value),
                            ),
                          ),
                          SizedBox(height: 20),
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
                              isLoading: _homeController.isLoadingBrands,
                              placeholder: 'Select one',
                              modalTitle: 'Brands',
                              selectText: 'Select a brand',
                              value: _homeController.selectedBrand.value,
                              choiceItems: _homeController.brands,
                              onChange: (state) => _homeController.setBrand(state.value),
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
                              isLoading: _homeController.isLoadingModels,
                              isDisabled: _homeController.selectedBrand.value == '',
                              placeholder: 'Select one',
                              modalTitle: 'Models',
                              selectText: 'Select a model',
                              value: _homeController.selectedModel.value,
                              choiceItems: _homeController.models,
                              onChange: (state) => _homeController.setModel(state.value),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                          width: 280,
                          child: GradientButton(
                              text: 'Search', onPressed: () => [_homeController.doSearch(), Get.back()])),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
