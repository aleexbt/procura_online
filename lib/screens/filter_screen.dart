import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/components/text_widget.dart';
import 'package:procura_online/controllers/search_controller.dart';
import 'package:procura_online/widgets/better_expandable_tile.dart';

class FilterScreen extends GetView<SearchController> {
  final GlobalKey<BetterExpansionTileState> _categoryKey = GlobalKey();
  final GlobalKey<BetterExpansionTileState> _brandsKey = GlobalKey();
  final GlobalKey<BetterExpansionTileState> _modelsKey = GlobalKey();
  final GlobalKey<BetterExpansionTileState> _priceKey = GlobalKey();
  final GlobalKey<BetterExpansionTileState> _locationKey = GlobalKey();

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
                  subtitle: Obx(() => Text(controller.category)),
                  children: [
                    ListTile(
                      title: Text('Category A'),
                      onTap: () => {
                        _categoryKey.currentState.closeExpansion(),
                        controller.setCategory('Category A'),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  border: Border.all(
                    color: Colors.blue,
                  ),
                  gradient: LinearGradient(
                    colors: <Color>[
                      Colors.lightBlueAccent,
                      Colors.blue,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 72.0, right: 72, top: 8, bottom: 8),
                  child: Column(
                    children: <Widget>[
                      TextWidget(
                        text: 'Show Results',
                        colorText: Colors.white,
                      ),
                      TextWidget(
                        text: '0 ads',
                        colorText: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
