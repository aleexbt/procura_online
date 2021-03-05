import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:procura_online/controllers/orders_controller.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:shimmer/shimmer.dart';

class OrdersWidget extends StatelessWidget {
  final OrdersController _ordersController = Get.find();
  final UserController _userController = Get.find();
  final ScrollController _scrollController = ScrollController();

  Future<void> refresItems() async {
    return _ordersController.findAll(skipLoading: true);
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
                Text('Ops, erro ao carregar pedidos.'),
                TextButton(
                  style: TextButton.styleFrom(primary: Colors.blue),
                  onPressed: () => _.findAll(),
                  child: Text('Tentar novamente'),
                ),
              ],
            ),
          );
        }
        if (!_userController.listOrdersPermission) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Text(
                'Você só pode ver pedidos enviados. Mude seu plano para ver pedidos de outros usuários.',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        if (_.totalOrders == 0) {
          return Padding(
            padding: const EdgeInsets.all(18),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/emptyinbox.svg', width: 280),
                  SizedBox(height: 10),
                  Text('Sem pedidos no momento'),
                  TextButton(
                    style: TextButton.styleFrom(primary: Colors.blue),
                    onPressed: () => _.findAll(),
                    child: Text('Verificar novamente'),
                  ),
                ],
              ),
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: refresItems,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _.orders.orders.length + 1,
                  controller: _scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index == _.orders.orders.length) {
                      return SizedBox(height: 70);
                    }
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: OctoImage(
                            image: CachedNetworkImageProvider(_.orders.orders[index].makeLogoUrl),
                            placeholderBuilder: OctoPlaceholder.circularProgressIndicator(),
                            errorBuilder: OctoError.icon(color: Colors.grey[400]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(_.orders.orders[index].model),
                      subtitle: Text(
                        _.orders.orders[index].noteText,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            _.orders.orders[index].humanReadDate,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 12,
                            ),
                          ),
                          Visibility(
                            visible: _.orders.orders[index].sold,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Icon(
                                Icons.lock,
                                size: 17,
                                color: Colors.grey[400],
                              ),
                            ),
                          )
                        ],
                      ),
                      onTap: () =>
                          Get.toNamed('/chat/new/${_.orders.orders[index].id}', arguments: _.orders.orders[index]),
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
