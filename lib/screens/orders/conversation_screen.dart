import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:list_tile_more_customizable/list_tile_more_customizable.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:octo_image/octo_image.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:procura_online/controllers/conversation_controller.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:procura_online/models/order_model.dart';
import 'package:procura_online/models/upload_media_model.dart';
import 'package:procura_online/widgets/buble_item.dart';

class ConversationScreen extends StatefulWidget {
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final String chatId = Get.parameters['id'];
  final ConversationController _conversationController = Get.find();
  final UserController _userController = Get.find();
  final ScrollController _scrollController = ScrollController();
  bool showSearch = false;

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

  void selectImages() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path)).toList();
      _conversationController.setImages(files);

      for (File photo in files) {
        _conversationController.currentUploadImage.value = photo.path;
        UploadMedia media = await _conversationController.mediaUpload(photo);
        if (media != null) {
          _conversationController.setImagesUrl(media.name);
        } else {
          _conversationController.removeImage(photo);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: showSearch
            ? TextFormField(
                autofocus: true,
                onChanged: (value) => _conversationController.filterMessages(value),
                decoration: InputDecoration(
                  hintText: 'Pesquisar',
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
              )
            : GetX<ConversationController>(
                builder: (_) {
                  if (_.isLoading || _.hasError) {
                    return Container();
                  }
                  bool isMe = _.conversation.userOne.id == _userController.userData?.id;
                  String avatar =
                      isMe ? _.conversation.userTwo.logo?.thumbnail : _.conversation.userOne.logo?.thumbnail;
                  int profile = isMe ? _.conversation.userTwo.id : _.conversation.userOne.id;
                  String name = isMe ? _.conversation.userTwo.name : _.conversation.userOne.name;
                  String address = isMe ? _.conversation.userTwo.address : _.conversation.userOne.address;
                  String phone = isMe ? _.conversation.userTwo.phone : _.conversation.userOne.phone;
                  String email = isMe ? _.conversation.userTwo.email : _.conversation.userOne.email;
                  String register = isMe ? _.conversation.userTwo.createdAt : _.conversation.userOne.createdAt;
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => Get.toNamed('/chat/user-info', arguments: {
                      'profileId': profile,
                      'avatar': avatar,
                      'name': name,
                      'address': address,
                      'phone': phone,
                      'email': email,
                      'register': register,
                    }),
                    child: Row(
                      children: <Widget>[
                        ClipOval(
                          child: OctoImage(
                            width: 30,
                            height: 30,
                            image: CachedNetworkImageProvider(avatar),
                            placeholderBuilder: OctoPlaceholder.blurHash('LAI#u-9XM[D\$GdIU4oIA-sWFxwRl'),
                            errorBuilder: OctoError.icon(color: Colors.grey[400]),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              name,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
        actions: [
          IconButton(
            icon: Icon(showSearch ? Icons.clear : Icons.search),
            onPressed: () {
              setState(() {
                showSearch = !showSearch;
              });

              if (showSearch) {
                // searchFocus.requestFocus(s);
              }

              if (!showSearch) {
                _conversationController.filterMessages('');
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => Get.bottomSheet(
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTileMoreCustomizable(
                          leading: Icon(
                            _conversationController.conversation.mute == 0
                                ? CupertinoIcons.speaker_slash
                                : CupertinoIcons.speaker_2,
                            color: Colors.black,
                          ),
                          title: Text(
                            _conversationController.conversation.mute == 0 ? 'Silenciar conversa' : 'Restaurar som',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          horizontalTitleGap: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onTap: (_) => _conversationController.muteConversationToggle(),
                        ),
                      ],
                    ),
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
                    Text('Ops, ocorreu um erro ao carregar messagens.'),
                    TextButton(
                      style: TextButton.styleFrom(primary: Colors.blue),
                      onPressed: () => _.findOne(),
                      child: Text('Tentar novamente'),
                    ),
                  ],
                ),
              );
            }
            Order order = _.conversation.order;
            return ModalProgressHUD(
              inAsyncCall: _.isDeleting,
              child: SafeArea(
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
                                            placeholderBuilder:
                                                OctoPlaceholder.blurHash('LAI#u-9XM[D\$GdIU4oIA-sWFxwRl'),
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
                                              '${order.make} / ${order.model} / ${order.year}',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                                'Combustível: ${order.fuelType ?? ''} / Cilindrada: ${order.engineDisplacement ?? ''} / Nº portas: ${order.numberOfDoors ?? ''}'),
                                            Divider(),
                                            Text('${order.noteText}'),
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
                                                              image: CachedNetworkImageProvider(
                                                                  '${order.media[index].image}'),
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
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _.conversation.messages.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
                                  var message = _.conversation.messages[index];
                                  return Bubble(
                                    id: message.id.toString(),
                                    photos: message.hasAttachments ? message.media : null,
                                    message: message.message,
                                    time: message.humanReadDate,
                                    isMe: _userController.userData.id.toString() == message.userId.toString(),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(
                        minHeight: 50,
                      ),
                      color: Colors.grey[200],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                              visible: _.images.length > 0,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10, bottom: 2),
                                child: SizedBox(
                                  height: 120,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: _.images.length,
                                      itemBuilder: (context, index) {
                                        return Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 8.0),
                                              child: SizedBox(
                                                width: 180,
                                                height: 120,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(5),
                                                  child: Image.file(
                                                    File(_.images[index].path),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 4,
                                              right: 8,
                                              child: GestureDetector(
                                                  behavior: HitTestBehavior.translucent,
                                                  onTap: () {
                                                    setState(() {
                                                      _.images.removeAt(index);
                                                    });
                                                  },
                                                  child: Icon(Icons.delete, color: Colors.red)),
                                            ),
                                            Obx(
                                              () => Visibility(
                                                visible: _.isUploadingImage &&
                                                    _.currentUploadImage.value == _.images[index].path,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(5),
                                                  child: Container(
                                                    width: 180,
                                                    height: 120,
                                                    color: Colors.grey.withOpacity(0.8),
                                                    child: Center(
                                                      child: CircularPercentIndicator(
                                                        radius: 60.0,
                                                        lineWidth: 5.0,
                                                        percent: _.uploadImageProgress.value,
                                                        center: Text(
                                                          '${(_.uploadImageProgress.value * 100).round()}%',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        progressColor: Colors.blue,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: _.images.length > 0,
                              child: Divider(),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.attachment,
                                  ),
                                  onPressed: () => selectImages(),
                                ),
                                Expanded(
                                  child: Obx(
                                    () => TextField(
                                      controller: _conversationController.messageInput.value,
                                      textCapitalization: TextCapitalization.sentences,
                                      decoration: InputDecoration.collapsed(
                                        hintText: 'Escreva sua mensagem',
                                      ),
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
                                            photos: _.imagesUrl,
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
