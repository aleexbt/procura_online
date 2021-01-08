import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:procura_online/controllers/orders_controller.dart';
import 'package:procura_online/models/order_model.dart';
import 'package:procura_online/widgets/text_widget.dart';

class OrderReplyScreen extends StatelessWidget {
  final OrdersController _ordersController = Get.find();
  final String orderId = Get.parameters['id'];
  final Order order = Get.arguments;
  final TextEditingController _message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: Row(
          children: <Widget>[
            ClipOval(
                child: Image.network(
              'https://mindbodygreen-res.cloudinary.com/images/w_767,q_auto:eco,f_auto,fl_lossy/usr/RetocQT/sarah-fielding.jpg',
              width: 30,
              height: 30,
              fit: BoxFit.cover,
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextWidget(
                text: order.userInfo.name,
                textType: TextType.TEXT_MEDIUM,
                colorText: Colors.black,
              ),
            )
          ],
        ),
      ),
      body: Column(
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
                                  placeholderBuilder: OctoPlaceholder.circularProgressIndicator(),
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
                                        width: 40,
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
                                                    "photoId": "photo_$index",
                                                    "photoUrl": "${order.media[index].image}",
                                                  },
                                                ),
                                                child: Hero(
                                                  tag: 'photo_$index',
                                                  child: OctoImage(
                                                    image: CachedNetworkImageProvider(order.media[index].thumb),
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
          Container(
            color: Colors.grey[200],
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.attachment,
                  ),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    controller: _message,
                    decoration: InputDecoration.collapsed(
                      hintText: "Write your message",
                    ),
                  ),
                ),
                Obx(
                  () => _ordersController.isReplyingMsg
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8),
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
          )
        ],
      ),
    );
  }
}
