import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_tile_more_customizable/list_tile_more_customizable.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:octo_image/octo_image.dart';
import 'package:procura_online/controllers/conversation_controller.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:procura_online/models/order_model.dart';
import 'package:procura_online/widgets/buble_item.dart';

class ConversationScreenPusher extends StatefulWidget {
  @override
  _ConversationScreenPusherState createState() => _ConversationScreenPusherState();
}

class _ConversationScreenPusherState extends State<ConversationScreenPusher> {
  final String chatId = Get.parameters['id'];
  final ConversationController _conversationController = Get.put(ConversationController());
  final UserController _userController = Get.find();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 500),
      );
    } else {
      Timer(Duration(milliseconds: 400), () => _scrollToBottom());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: GetX<ConversationController>(
            init: _conversationController,
            builder: (_) {
              if (_.isLoading || _.hasError) {
                return Container();
              }
              return Row(
                children: <Widget>[
                  ClipOval(
                    child: Image.network(
                      'https://mindbodygreen-res.cloudinary.com/images/w_767,q_auto:eco,f_auto,fl_lossy/usr/RetocQT/sarah-fielding.jpg',
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _conversationController.messages?.messages[0]?.sender?.name,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              );
            }),
        actions: [
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
                          CupertinoIcons.speaker_slash,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Mute conversation",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        horizontalTitleGap: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onTap: (_) => _conversationController.muteConversation(),
                      ),
                      Divider(),
                      ListTileMoreCustomizable(
                        leading: Icon(
                          CupertinoIcons.delete,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Delete conversation",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        horizontalTitleGap: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onTap: (_) => _conversationController.deleteConversation(),
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
        ],
      ),
      body: GetX<ConversationController>(
          init: _conversationController,
          builder: (_) {
            if (_.isLoading) {
              return LinearProgressIndicator();
            }
            if (_.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Ops, error retrieving message data.'),
                    FlatButton(
                      onPressed: () => _.findOne(),
                      child: Text(
                        'Try again',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              );
            }
            Order order = _.messages.messages[0].conversation.order;
            return ModalProgressHUD(
              inAsyncCall: _.isDeleting,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
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
                                                            placeholderBuilder:
                                                                OctoPlaceholder.circularProgressIndicator(),
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
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: StreamBuilder(
                                // stream: _.pusherService.eventStream,
                                builder: (context, snapshot) {
                              print(snapshot.data);
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: _.messages.messages.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
                                  var message = _.messages.messages[index];
                                  return Bubble(
                                    photo: message.hasAttachments ? message.media[0].image : null,
                                    message: message.message,
                                    time: message.humanReadDate,
                                    delivered: true,
                                    isMe: _userController.userData.id.toString() == message.userId,
                                  );
                                },
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
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
                              controller: _conversationController.messageInput.value,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration.collapsed(
                                hintText: "Write your message",
                              ),
                            ),
                          ),
                          Obx(
                            () => _conversationController.isReplying
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(strokeWidth: 2.5),
                                    ),
                                  )
                                : IconButton(
                                    color: Colors.blue,
                                    icon: Icon(
                                      Icons.send,
                                    ),
                                    onPressed: () => _.replyMessage(
                                      message: _.messageInput.value.text,
                                      orderId: order.id.toString(),
                                      chatId: chatId,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
