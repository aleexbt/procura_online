import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/components/text_widget.dart';
import 'package:procura_online/controllers/search_controller.dart';
import 'package:procura_online/widgets/better_expandable_tile.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final GlobalKey<BetterExpansionTileState> _categoryKey = GlobalKey();
  final GlobalKey<BetterExpansionTileState> _brandsKey = GlobalKey();
  final GlobalKey<BetterExpansionTileState> _priceKey = GlobalKey();
  final GlobalKey<BetterExpansionTileState> _locationKey = GlobalKey();
  final SearchController _searchController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Filter results'),
      ),
      body: Column(
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
                subtitle: Obx(() => Text(_searchController.category)),
                children: [
                  ListTile(
                    title: Text('Category A'),
                    onTap: () => {
                      _categoryKey.currentState.closeExpansion(),
                      _searchController.setCategory('Category A'),
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
                subtitle: Obx(() => Text(_searchController.brand)),
                children: [
                  ListTile(
                    title: Text('Brand A'),
                    onTap: () => {
                      _searchController.setBrand('Brand A'),
                      _brandsKey.currentState.closeExpansion(),
                    },
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
                subtitle: Obx(() => Text(_searchController.price)),
                children: [
                  ListTile(
                    title: Text('\$30 - \$1250'),
                    onTap: () => {
                      _searchController.setPrice('\$30 - \$1250'),
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
                subtitle: Obx(() => Text(_searchController.location)),
                children: [
                  ListTile(
                    title: Text('Location A'),
                    onTap: () => {
                      _searchController.setLocation('Location A'),
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
                      text: '578399 Ads',
                      colorText: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
