import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:procura_online/controllers/home_controller.dart';
import 'package:procura_online/controllers/search_controller.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:procura_online/utils/no_glow_behavior.dart';
import 'package:procura_online/widgets/featured_box.dart';
import 'package:procura_online/widgets/normal_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final SearchController _searchController = Get.find();
  final HomeController _homeController = Get.find();
  final UserController _userController = Get.find();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.40;
      if (maxScroll - currentScroll < delta) {
        if (!_homeController.isLoadingMore && !_homeController.isLastPage && !_homeController.hasErrorMore) {
          _homeController.getNextPage();
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> refresItems() async {
    return _homeController.findAll();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
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
                      onSubmitted: (_) => _homeController.doSearch(),
                      textInputAction: TextInputAction.search,
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => Get.toNamed('/search-filter'),
                    child: Icon(CupertinoIcons.slider_horizontal_3),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                color: Colors.grey[200],
                minWidth: 120,
                height: 40,
                onPressed: () => _userController.isLoggedIn ? Get.toNamed('/ad/new') : Get.toNamed('/auth/login'),
                child: Text('Sell'),
              ),
              FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                color: Colors.grey[200],
                minWidth: 120,
                height: 40,
                onPressed: () {},
                child: Text('Vehicles'),
              ),
              FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                color: Colors.grey[200],
                minWidth: 120,
                height: 40,
                onPressed: () {},
                child: Text('Auto Parts'),
              ),
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: ScrollConfiguration(
              behavior: NoGlowBehavior(),
              child: RefreshIndicator(
                onRefresh: refresItems,
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
                                image: 'https://source.unsplash.com/600x500/?bmw,audi,volvo˚?ad=$index',
                                title: 'Sport car',
                                salePrice: '19,000',
                                onTap: () => Get.toNamed('/product/$index'),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      GetX<HomeController>(
                        init: _homeController,
                        builder: (_) {
                          if (_.isLoading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (_.hasError) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Ops, error retrieving items.'),
                                  FlatButton(
                                    onPressed: () => _.findAll(),
                                    child: Text(
                                      'Try again',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              childAspectRatio: 0.80,
                            ),
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: _.results?.length ?? 0,
                            itemBuilder: (context, index) {
                              return NormalBox(
                                image: 'https://source.unsplash.com/600x500/?bmw,audi,volvo?ad=${_.results[index].id}',
                                title: _.results[index].title,
                                salePrice: _.results[index].price,
                                normalPrice: _.results[index].oldPrice,
                                onTap: () => Get.toNamed('/product/${_.results[index].id}'),
                              );
                            },
                          );
                        },
                      ),
                      Obx(
                        () => Visibility(
                          visible: _homeController.isLoadingMore,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
