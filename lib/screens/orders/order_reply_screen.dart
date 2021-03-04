import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_tile_more_customizable/list_tile_more_customizable.dart';
import 'package:octo_image/octo_image.dart';
import 'package:procura_online/controllers/orders_controller.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:procura_online/models/order_model.dart';
import 'package:procura_online/repositories/orders_repository.dart';

class OrderReplyScreen extends StatelessWidget {
  final OrdersController _ordersController = Get.find();
  final OrdersRepository _ordersRepository = Get.find();
  final UserController _userController = Get.find();
  final String orderId = Get.parameters['id'];
  final Order order = Get.arguments;
  final TextEditingController _message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _ordersRepository.markOrderAsRead(orderId);
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => Get.toNamed('/profile/${order.userInfo.id}'),
          child: Row(
            children: <Widget>[
              ClipOval(
                  child: Image.network(
                order.userInfo.logo.thumbnail,
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    order.userInfo.name,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            ],
          ),
        ),
        actions: order.userId == _userController.userData.id
            ? [
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () => Get.bottomSheet(
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTileMoreCustomizable(
                              leading: Icon(
                                CupertinoIcons.archivebox,
                                color: Colors.black,
                              ),
                              title: Text(
                                "Mark as sold",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              horizontalTitleGap: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onTap: (_) => _ordersController.markOrderAsSold(orderId),
                            ),
                          ],
                        ),
                      ),
                    ),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                    ),
                  ),
                ),
              ]
            : null,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xfff5ca99),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 70,
                                height: 70,
                                child: ClipOval(
                                  child: OctoImage(
                                    image: CachedNetworkImageProvider(order.makeLogoUrl),
                                    placeholderBuilder: OctoPlaceholder.blurHash('LAI#u-9XM[D\$GdIU4oIA-sWFxwRl'),
                                    errorBuilder: OctoError.icon(color: Colors.grey[400]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${order.make} ${order.model} ${order.year}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text('MPN: ${order.mpn}'),
                                    Divider(),
                                    Text('Model: ${order.model}'),
                                    Divider(),
                                    Text('Number of Doors: ${order.numberOfDoors}'),
                                    Divider(),
                                    Text('Fuel Type: ${order.fuelType}'),
                                    Divider(),
                                    Text('Notes: ${order.noteText}'),
                                    Visibility(
                                      visible: order.media.length > 0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: SizedBox(
                                          height: 40,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: order.media.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(right: 5),
                                                child: GestureDetector(
                                                  onTap: () => Get.toNamed(
                                                    '/show-photos',
                                                    arguments: {
                                                      "photoId": "${order.media[index].id}",
                                                      "photoUrl": "${order.media[index].image}",
                                                    },
                                                  ),
                                                  child: Hero(
                                                    tag: '${order.media[index].id}',
                                                    child: OctoImage(
                                                      image: CachedNetworkImageProvider('${order.media[index].image}'),
                                                      placeholderBuilder: OctoPlaceholder.circularProgressIndicator(),
                                                      errorBuilder: OctoError.icon(color: Colors.grey[400]),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: order.userId != _userController.userData.id && !order.sold,
              child: Container(
                height: 50,
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      // IconButton(
                      //   icon: Icon(
                      //     Icons.attachment,
                      //   ),
                      //   onPressed: () {},
                      // ),
                      Expanded(
                        child: TextField(
                          controller: _message,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration.collapsed(
                            hintText: "Write your message",
                          ),
                        ),
                      ),
                      Obx(
                        () => _ordersController.isReplyingMsg
                            ? Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2.5),
                                ),
                              )
                            : IconButton(
                                icon: Icon(
                                  Icons.send,
                                  color: Colors.blue,
                                ),
                                onPressed: () => _ordersController.replyOrder(message: _message.text, orderId: orderId),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
