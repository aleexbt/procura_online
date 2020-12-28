import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:procura_online/controllers/orders_controller.dart';
import 'package:shimmer/shimmer.dart';

class OrdersWidget extends StatelessWidget {
  final OrdersController _ordersController = Get.find();
  final ScrollController _scrollController = ScrollController();

  Future<void> refresItems() async {
    return _ordersController.findAll();
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.40;
      if (maxScroll - currentScroll < delta) {
        if (!_ordersController.isLoadingMore && !_ordersController.isLastPage) {
          _ordersController.nextPage();
        }
      }
    });

    return GetX<OrdersController>(
      init: _ordersController,
      builder: (_) {
        if (_.isLoading) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled: true,
            child: ListView.builder(
              itemBuilder: (_, __) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: 50,
                        height: 50,
                        color: Colors.white,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 10,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: 250,
                            height: 10,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: 150,
                            height: 10,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              itemCount: 15,
            ),
          );
        }
        if (_.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Ops, error retrieving your orders.'),
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
        if (_.totalOrders == 0) {
          return Center(
            child: Text('You don\'t have any orders to show.'),
          );
        }
        return RefreshIndicator(
          onRefresh: refresItems,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _.totalOrders,
                  controller: _scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var orders = _.orders;
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: OctoImage(
                            image: CachedNetworkImageProvider(orders.order[index].makeLogoUrl),
                            placeholderBuilder: OctoPlaceholder.circularProgressIndicator(),
                            errorBuilder: OctoError.icon(color: Colors.grey[400]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(orders.order[index].model),
                      subtitle: Text(
                        orders.order[index].noteText,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Text(
                        orders.order[index].humanReadDate,
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                        ),
                      ),
                      onTap: () {},
                    );
                  },
                ),
              ),
              Visibility(
                visible: _.isLoadingMore,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
