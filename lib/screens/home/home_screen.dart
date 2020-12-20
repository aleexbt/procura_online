import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:procura_online/controllers/search_controller.dart';
import 'package:procura_online/screens/home/home_controller.dart';
import 'package:procura_online/utils/no_glow_behavior.dart';
import 'package:procura_online/widgets/featured_box.dart';
import 'package:procura_online/widgets/normal_box.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final SearchController _searchController = Get.find();
  final HomeController _homeController = Get.find();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.40;
      if (maxScroll - currentScroll < delta) {
        if (!_homeController.isLoadingMore && !_homeController.isLastPage) {
          _homeController.nextPage();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Icon(Icons.search),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent, width: 0.0),
                        ),
                      ),
                      onChanged: (value) => _searchController.setSearchTerm(value),
                      onSubmitted: (_) => _searchController.doSearch(),
                      textInputAction: TextInputAction.search,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed('/search-filter'),
                    child: Icon(CupertinoIcons.slider_horizontal_3),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                constraints: BoxConstraints(
                  minWidth: 120,
                ),
                decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text('Sell'),
                  ),
                ),
              ),
              Container(
                height: 40,
                constraints: BoxConstraints(
                  minWidth: 120,
                ),
                decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text('Vehicles'),
                  ),
                ),
              ),
              Container(
                height: 40,
                constraints: BoxConstraints(
                  minWidth: 120,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text('Auto Parts'),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: ScrollConfiguration(
              behavior: NoGlowBehavior(),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: FeaturedBox(
                              image:
                                  'https://quatrorodas.abril.com.br/wp-content/uploads/2020/02/bmw_x5_xdrive45e-1-e1581517888476.jpeg?quality=70&strip=info',
                              title: 'Sport car',
                              salePrice: '19,000',
                              onTap: () => Get.toNamed('/product-details/$index'),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Obx(
                      () => GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          childAspectRatio: 0.80,
                        ),
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: _homeController.results.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return NormalBox(
                            image:
                                'https://quatrorodas.abril.com.br/wp-content/uploads/2020/02/bmw_x5_xdrive45e-1-e1581517888476.jpeg?quality=70&strip=info',
                            title: _homeController.results.data[index].title,
                            salePrice: _homeController.results.data[index].price,
                            normalPrice: _homeController.results.data[index].oldPrice,
                            onTap: () => Get.toNamed('/product-details/${_homeController.results.data[index].id}'),
                          );
                        },
                      ),
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
