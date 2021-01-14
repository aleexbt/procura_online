import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_tile_more_customizable/list_tile_more_customizable.dart';
import 'package:octo_image/octo_image.dart';
import 'package:procura_online/controllers/ads_listing_controller.dart';

class AdsListingScreen extends StatefulWidget {
  @override
  _AdsListingScreenState createState() => _AdsListingScreenState();
}

class _AdsListingScreenState extends State<AdsListingScreen> {
  AdsListingController _adsListingController = Get.put(AdsListingController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.40;
      if (maxScroll - currentScroll < delta) {
        if (!_adsListingController.isLoadingMore &&
            !_adsListingController.isLastPage &&
            !_adsListingController.loadingMoreError) {
          _adsListingController.nextPage();
        }
      }
    });
    super.initState();
  }

  Future<void> refresItems() async {
    return _adsListingController.findAll(skipLoading: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('My ads'),
      ),
      body: GetX<AdsListingController>(
        init: _adsListingController,
        builder: (_) {
          if (_.isLoading) {
            return LinearProgressIndicator();
          }
          if (_.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Ops, error retrieving your ads.'),
                  TextButton(
                    style: TextButton.styleFrom(primary: Colors.blue),
                    onPressed: () => _.findAll(),
                    child: Text('Try again'),
                  ),
                ],
              ),
            );
          }
          if (_.result.products.length == 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('You don\'t have any published ad.'),
                  TextButton(
                    style: TextButton.styleFrom(primary: Colors.blue),
                    onPressed: () => _.findAll(skipLoading: true),
                    child: Text('Check again'),
                  ),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: refresItems,
            child: ListView.builder(
              itemCount: _.result.products.length,
              itemBuilder: (context, index) {
                return ListTileMoreCustomizable(
                  onTap: (item) =>
                      Get.toNamed('/settings/ads/${_.result.products[index].id}', arguments: _.result.products[index]),
                  leading: _.result.products[index].mainPhoto?.original != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: SizedBox(
                            width: 50,
                            child: OctoImage(
                              image: CachedNetworkImageProvider(_.result.products[index].mainPhoto?.thumb),
                              placeholderBuilder: OctoPlaceholder.circularProgressIndicator(),
                              errorBuilder: OctoError.icon(color: Colors.grey[400]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : null,
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue),
                  title: Text(_.result.products[index].title),
                  horizontalTitleGap: 5,
                  subtitle: Text(
                    _.result.products[index].description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
