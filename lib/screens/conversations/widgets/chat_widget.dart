import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/controllers/chat_controller.dart';
import 'package:shimmer/shimmer.dart';

class ChatWidget extends StatelessWidget {
  final ChatController _chatController = Get.find();
  final ScrollController _scrollController = ScrollController();

  Future<void> refresItems() async {
    return _chatController.findAll();
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

    return GetX<ChatController>(
        init: _chatController,
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
                  Text('Ops, error retrieving your chats.'),
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
          if (_.totalConversations == 0) {
            return Center(
              child: Text('You don\'t have any conversations to show.'),
            );
          }
          return RefreshIndicator(
            onRefresh: refresItems,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _chatController.totalConversations,
              controller: _scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      'https://mindbodygreen-res.cloudinary.com/images/w_767,q_auto:eco,f_auto,fl_lossy/usr/RetocQT/sarah-fielding.jpg',
                      height: 50.0,
                      width: 50.0,
                    ),
                  ),
                  title: Text(_.conversations[index].userone.name),
                  subtitle: Text(_.conversations[index].latestMessage.message),
                  trailing: Text(
                    _.conversations[index].latestMessage.humanReadDate,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                  onTap: () =>
                      Get.toNamed('/chat/conversation/${_.conversations[index].id}', arguments: _.conversations[index]),
                );
              },
            ),
          );
        });
  }
}
