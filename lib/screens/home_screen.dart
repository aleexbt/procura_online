import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:procura_online/controllers/home_controller.dart';
import 'package:procura_online/controllers/search_controller.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:procura_online/utils/no_glow_behavior.dart';
import 'package:procura_online/widgets/item_box.dart';
import 'package:procura_online/widgets/scroll_keyboard_closer.dart';

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
  final ScrollController _scrollController = ScrollController(initialScrollOffset: 0.0);
  final TextEditingController _keywordController = TextEditingController();

  @override
  void initState() {
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.40;
      if (maxScroll - currentScroll < delta) {
        if (!_homeController.isLoadingMore && !_homeController.isLastPage && !_homeController.loadingMoreError) {
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
    if (_homeController.isSearch) {
      _homeController.doSearch(skipLoading: true);
    } else {
      return _homeController.findAll(skipLoading: true);
    }
  }

  void changeCategory({String name, String value}) {
    _searchController.clearFilter();
    _homeController.clear();
    _keywordController.clear();
    if (_homeController.categoryValue == value) {
      _homeController.changeCategory(name: 'Listings', value: 'listings');
    } else {
      _homeController.changeCategory(name: name, value: value);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
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
                      controller: _keywordController,
                      decoration: InputDecoration(
                        hintText: 'Pesquisar',
                        suffix: Obx(
                          () => Text(
                            _searchController.searchType.value == 0 ? 'AUTOMÓVEIS' : 'PEÇAS',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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
                      onChanged: (value) => _searchController.keyword.value = value,
                      onSubmitted: (_) => _homeController.doSearch(),
                      textInputAction: TextInputAction.search,
                      textCapitalization: TextCapitalization.sentences,
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
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    color: Colors.blue,
                    height: 40,
                    onPressed: () => _userController.isLoggedIn ? Get.toNamed('/ad/new') : Get.toNamed('/auth/login'),
                    child: Text(
                      'Anunciar',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Obx(
                      () => FlatButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        color: _homeController.categoryValue == 'vehicles' ? Colors.grey[300] : Colors.grey[200],
                        height: 40,
                        onPressed: () => changeCategory(name: 'Automóveis', value: 'vehicles'),
                        child: Text('Automóveis'),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Obx(
                    () => FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      color: _homeController.categoryValue == 'autoparts' ? Colors.grey[300] : Colors.grey[200],
                      height: 40,
                      onPressed: () => changeCategory(name: 'Peças', value: 'autoparts'),
                      child: Text('Peças'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ScrollConfiguration(
              behavior: NoGlowBehavior(),
              child: RefreshIndicator(
                onRefresh: refresItems,
                child: ScrollKeyboardCloser(
                  child: GestureDetector(
                    onPanDown: (DragDownDetails dragDownDetails) {
                      if (FocusScope.of(context).isFirstFocus) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      }
                    },
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: GetX<HomeController>(
                          init: _homeController,
                          builder: (_) {
                            if (_.isLoading) {
                              return Padding(
                                padding: EdgeInsets.only(top: Get.size.height / 3),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            if (_.hasError) {
                              return Padding(
                                padding: EdgeInsets.only(top: Get.size.height / 4),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Ops, erro ao carregar anúncios.'),
                                      TextButton(
                                        style: TextButton.styleFrom(primary: Colors.blue),
                                        onPressed: () => _.findAll(),
                                        child: Text('Tentar novamente'),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            if (_.total == 0) {
                              return Padding(
                                padding: EdgeInsets.only(top: Get.size.height / 5),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset('assets/images/semresultado.svg', width: 280),
                                      SizedBox(height: 20),
                                      Text(
                                        'Oh, não conseguimos encontrar nenhum resultado.',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            return Column(
                              children: [
                                SizedBox(
                                  height: _.featured.length > 0 ? 250 : 0,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: _.featured.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: ItemBox(
                                          width: 50,
                                          height: 100,
                                          image: _.featured[index].mainPhoto?.bigThumb ??
                                              'https://source.unsplash.com/600x500/?bmw,audi,volvo',
                                          title: _.featured[index].title ?? 'Title',
                                          salePrice: _.featured[index].price ?? '0',
                                          normalPrice: _.featured[index].oldPrice,
                                          onTap: () => Get.toNamed('/product/${_homeController.featured[index].id}'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: _.featured.length > 0 ? 20 : 0),
                                GridView.builder(
                                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                                    return ItemBox(
                                      width: 200,
                                      height: 250,
                                      image: _.results[index].mainPhoto?.thumb ??
                                          'https://source.unsplash.com/600x500/?bmw,audi,volvo?ad=${_.results[index].id}',
                                      title: _.results[index].title,
                                      salePrice: _.results[index].price,
                                      normalPrice: _.results[index].oldPrice,
                                      onTap: () => Get.toNamed('/product/${_.results[index].id}'),
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
                            );
                          }),
                    ),
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
