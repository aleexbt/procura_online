import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_tile_more_customizable/list_tile_more_customizable.dart';
import 'package:procura_online/controllers/chat_controller.dart';
import 'package:procura_online/controllers/orders_controller.dart';
import 'package:procura_online/repositories/chat_repository.dart';
import 'package:procura_online/utils/no_glow_behavior.dart';

import 'widgets/chat_widget.dart';
import 'widgets/orders_widget.dart';

class OrdersAndChatScreen extends StatefulWidget {
  @override
  _OrdersAndChatScreenState createState() => _OrdersAndChatScreenState();
}

class _OrdersAndChatScreenState extends State<OrdersAndChatScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final PageController _pageController = PageController();
  final TextEditingController _ordersTerm = TextEditingController();
  final TextEditingController _chatTerm = TextEditingController();
  final ChatRepository _chatRepository = Get.put(ChatRepository());
  final OrdersController _ordersController = Get.put(OrdersController(), permanent: true);
  final ChatController _chatController = Get.put(ChatController(), permanent: true);

  int _selectedIndex = 0;

  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    Expanded(
                      child: TextField(
                        controller: _selectedIndex == 0 ? _ordersTerm : _chatTerm,
                        decoration: InputDecoration(
                          hintText: 'Search',
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
                        onChanged: (value) => _selectedIndex == 0
                            ? _ordersController.filterResults(value)
                            : _chatController.filterResults(value),
                        textInputAction: TextInputAction.search,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      color: _selectedIndex == 0 ? Colors.grey[300] : Colors.grey[200],
                      height: 40,
                      onPressed: () => _selectedIndex != 0
                          ? _pageController.animateToPage(0,
                              duration: Duration(milliseconds: 300), curve: Curves.linear)
                          : Get.bottomSheet(
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTileMoreCustomizable(
                                        leading: Icon(
                                          Icons.visibility_off_outlined,
                                          color: Colors.black,
                                        ),
                                        title: Text(
                                          'Unread',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        horizontalTitleGap: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        onTap: (_) => [
                                          _ordersController.changeFilter(name: 'Unread', value: 'unread'),
                                          Get.back()
                                        ],
                                      ),
                                      Divider(),
                                      ListTileMoreCustomizable(
                                        leading: Icon(
                                          Icons.visibility_outlined,
                                          color: Colors.black,
                                        ),
                                        title: Text(
                                          'Read',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        horizontalTitleGap: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        onTap: (_) =>
                                            [_ordersController.changeFilter(name: 'Read', value: 'read'), Get.back()],
                                      ),
                                      Divider(),
                                      ListTileMoreCustomizable(
                                        leading: Icon(
                                          Icons.send_outlined,
                                          color: Colors.black,
                                        ),
                                        title: Text(
                                          'Sent',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        horizontalTitleGap: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        onTap: (_) =>
                                            [_ordersController.changeFilter(name: 'Sent', value: 'sent'), Get.back()],
                                      ),
                                      Divider(),
                                      ListTileMoreCustomizable(
                                        leading: Icon(
                                          Icons.clear,
                                          color: Colors.black,
                                        ),
                                        title: Text(
                                          'All',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        horizontalTitleGap: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        onTap: (_) =>
                                            [_ordersController.changeFilter(name: 'All', value: 'vazio'), Get.back()],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                              ),
                            ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() => Text(_ordersController.filterName)),
                          _selectedIndex == 0 ? Icon(Icons.arrow_drop_down) : Container()
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        color: _selectedIndex == 1 ? Colors.grey[300] : Colors.grey[200],
                        height: 40,
                        onPressed: () => _pageController.animateToPage(1,
                            duration: Duration(milliseconds: 300), curve: Curves.linear),
                        child: Text('Chat'),
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      color: Colors.grey[200],
                      height: 40,
                      onPressed: () {},
                      child: Text('Others'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ScrollConfiguration(
                behavior: NoGlowBehavior(),
                child: PageView(
                  controller: _pageController,
                  onPageChanged: onPageChanged,
                  children: [
                    OrdersWidget(),
                    ChatWidget(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        transitionBuilder: (Widget child, Animation<double> animation) {
          final scaleTween = TweenSequence([
            TweenSequenceItem(tween: Tween(begin: 0.1, end: 1.0), weight: 1),
          ]);
          return ScaleTransition(
            scale: scaleTween.animate(animation),
            child: child,
          );
        },
        child: _selectedIndex == 0
            ? FloatingActionButton(
                key: UniqueKey(),
                onPressed: () => Get.toNamed('/orders/new'),
                child: Icon(Icons.add),
              )
            : null,
      ),
    );
  }
}
