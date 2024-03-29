import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:procura_online/controllers/chat_controller.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:shimmer/shimmer.dart';

class ChatWidget extends StatelessWidget {
  final ChatController _chatController = Get.find();
  final ScrollController _scrollController = ScrollController();
  final UserController _userController = Get.find();

  Future<void> refresItems() async {
    return _chatController.findAll(skipLoading: true);
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.40;
      if (maxScroll - currentScroll < delta) {
        if (!_chatController.isLoadingMore && !_chatController.isLastPage) {
          _chatController.nextPage();
        }
      }
    });

    return GetX<ChatController>(builder: (_) {
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
              Text('Ops, erro ao carregar mensagens.'),
              TextButton(
                style: TextButton.styleFrom(primary: Colors.blue),
                onPressed: () => _.findAll(),
                child: Text('Tentar novamente'),
              ),
            ],
          ),
        );
      }
      if (_.chats.chats.length == 0) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/emptyinbox.svg', width: 280),
              SizedBox(height: 10),
              Text('Sem conversas de momento'),
              TextButton(
                style: TextButton.styleFrom(primary: Colors.blue),
                onPressed: () => _.findAll(),
                child: Text('Verificar novamente'),
              ),
            ],
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
                itemCount: _chatController.chats.chats.length,
                controller: _scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  bool isMe = _.chats.chats[index].userOne.id == _userController.userData?.id;
                  String avatar =
                      isMe ? _.chats.chats[index].userTwo.logo.thumbnail : _.chats.chats[index].userOne.logo.thumbnail;
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: OctoImage(
                          image: CachedNetworkImageProvider(avatar),
                          placeholderBuilder: OctoPlaceholder.circularProgressIndicator(),
                          errorBuilder: OctoError.icon(color: Colors.grey[400]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                        '${_.chats.chats[index].order?.model ?? ''} ${_.chats.chats[index].order?.year ?? ''}'), // messages.messages[index].usertwo.name
                    subtitle: Text(_.chats?.chats[index]?.latestMessage?.message ?? ''),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _.chats?.chats[index]?.latestMessage?.humanReadDate ?? '',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                        Visibility(
                          visible: !_.chats.chats[index].seen,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: ClipOval(
                              child: Container(
                                width: 8,
                                height: 8,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _.chats?.chats[index]?.mute,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Icon(
                              CupertinoIcons.volume_off,
                              size: 18,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () => Get.toNamed('/chat/conversation/${_.chats.chats[index].id}'),
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
    });
  }
}
