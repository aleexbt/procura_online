import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:procura_online/controllers/orders_controller.dart';
import 'package:procura_online/models/chat_model.dart';
import 'package:procura_online/widgets/buble_item.dart';
import 'package:procura_online/widgets/text_widget.dart';

class OrderReplyScreen extends StatelessWidget {
  final OrdersController _ordersController = Get.find();
  final String orderId = Get.parameters['id'];
  final Conversation conversation = Get.arguments;
  final TextEditingController _message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(orderId);
    print(conversation);
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
                text: 'Emma Liam',
                textType: TextType.TEXT_MEDIUM,
                colorText: Colors.black,
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
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
                            image: CachedNetworkImageProvider(
                                'https://procuraonline-dev.pt/images/makes/logos/64/AIXAM.png'),
                            placeholderBuilder: OctoPlaceholder.circularProgressIndicator(),
                            errorBuilder: OctoError.icon(color: Colors.grey[400]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Titulo',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('Some text goes here as note for this item.'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Bubble(
                        message: 'Hi Ankit',
                        time: 'Nov,12:00',
                        delivered: true,
                        isMe: false,
                      ),
                      Bubble(
                        message: 'Hi Ankit',
                        time: 'Nov,12:00',
                        delivered: true,
                        isMe: false,
                      ),
                      Bubble(
                        message: 'Hi Ankit',
                        time: 'Nov,12:00',
                        delivered: true,
                        isMe: false,
                      ),
                      Bubble(
                        message: 'Hi Ankit',
                        time: 'Nov,12:00',
                        delivered: true,
                        isMe: false,
                      ),
                      Bubble(
                        message: 'Hi Ankit',
                        time: 'Nov,12:00',
                        delivered: true,
                        isMe: false,
                      ),
                      Bubble(
                        message: 'Hi Ankit',
                        time: 'Nov,12:00',
                        delivered: true,
                        isMe: false,
                      ),
                      Bubble(
                        message: 'how are you?',
                        time: 'Nov,12:01',
                        delivered: true,
                        isMe: false,
                      ),
                      Bubble(
                        message: 'Hello!',
                        time: 'Nov,12:00',
                        delivered: true,
                        isMe: true,
                      ),
                      Bubble(
                        message: 'Are you free tonight',
                        time: 'Nov,12:00',
                        delivered: true,
                        isMe: true,
                      ),
                      Bubble(
                        message: 'No! I am busy!',
                        time: 'Nov,12:00',
                        delivered: true,
                        isMe: false,
                      ),
                    ],
                  ),
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
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.blue,
                    ),
                    onPressed: () => _ordersController.replyOrder(message: _message.text, orderId: orderId),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
