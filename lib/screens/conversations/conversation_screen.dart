import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/models/chat_model.dart';
import 'package:procura_online/widgets/buble_item.dart';
import 'package:procura_online/widgets/text_widget.dart';

class ConversationScreen extends StatelessWidget {
  final String params = Get.parameters['id'];
  final Conversation conversation = Get.arguments;

  @override
  Widget build(BuildContext context) {
    print(params);
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
                    onPressed: () {},
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
