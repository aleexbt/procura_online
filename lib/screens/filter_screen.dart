import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/controllers/home_controller.dart';
import 'package:procura_online/controllers/search_controller.dart';
import 'package:procura_online/widgets/better_expandable_tile.dart';
import 'package:procura_online/widgets/gradient_button.dart';

class FilterScreen extends GetView<SearchController> {
  final GlobalKey<BetterExpansionTileState> _categoryKey = GlobalKey();
  final GlobalKey<BetterExpansionTileState> _brandsKey = GlobalKey();
  final GlobalKey<BetterExpansionTileState> _modelsKey = GlobalKey();
  final GlobalKey<BetterExpansionTileState> _priceKey = GlobalKey();
  final GlobalKey<BetterExpansionTileState> _locationKey = GlobalKey();
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Filter results'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                BetterExpansionTile(
                  key: _categoryKey,
                  title: Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Obx(() => Text(controller.categoryName)),
                  children: [
                    ListTile(
                      title: Text('Peças Auto'),
                      onTap: () => {
                        _categoryKey.currentState.closeExpansion(),
                        controller.setCategory(name: 'Peças Auto', value: 'pecas'),
                      },
                    ),
                    ListTile(
                      title: Text('Automóveis'),
                      onTap: () => {
                        _categoryKey.currentState.closeExpansion(),
                        controller.setCategory(name: 'Automóveis', value: 'auto'),
                      },
                    ),
                    ListTile(
                      title: Text('Salvados'),
                      onTap: () => {
                        _categoryKey.currentState.closeExpansion(),
                        controller.setCategory(name: 'Salvados', value: 'salvados'),
                      },
                    ),
                  ],
                ),
                BetterExpansionTile(
                  key: _brandsKey,
                  title: Text(
                    'Brands',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Obx(() => Text(controller.brand)),
                  children: [
                    Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.brands.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (controller.isLoadingMakers) {
                            return LinearProgressIndicator();
                          }
                          return ListTile(
                            title: Text(controller.brands[index]),
                            onTap: () => {
                              controller.setBrand(controller.brands[index]),
                              _brandsKey.currentState.closeExpansion(),
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                BetterExpansionTile(
                  key: _modelsKey,
                  title: Text(
                    'Models',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Obx(() => Text(controller.model)),
                  children: [
                    Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.models.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (controller.isLoadingModels) {
                            return LinearProgressIndicator();
                          }
                          return ListTile(
                            title: Text(controller.models[index]),
                            onTap: () => {
                              controller.setModel(controller.models[index]),
                              _modelsKey.currentState.closeExpansion(),
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                BetterExpansionTile(
                  key: _priceKey,
                  title: Text(
                    'Price',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Obx(() => Text(controller.price)),
                  children: [
                    ListTile(
                      title: Text('\$30 - \$1250'),
                      onTap: () => {
                        controller.setPrice('\$30 - \$1250'),
                        _priceKey.currentState.closeExpansion(),
                      },
                    ),
                  ],
                ),
                BetterExpansionTile(
                  key: _locationKey,
                  title: Text(
                    'Location',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Obx(() => Text(controller.location)),
                  children: [
                    ListTile(
                      title: Text('Location A'),
                      onTap: () => {
                        controller.setLocation('Location A'),
                        _locationKey.currentState.closeExpansion(),
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(width: 230, child: GradientButton(text: 'Search', onPressed: () => [_homeController.doSearch(), Get.back()])),
          ],
        ),
      ),
    );
  }
}
