import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_tile_more_customizable/list_tile_more_customizable.dart';
import 'package:procura_online/controllers/chat_controller.dart';
import 'package:procura_online/controllers/orders_controller.dart';
import 'package:procura_online/repositories/chat_repository.dart';
import 'package:procura_online/screens/conversations/widgets/chat_widget.dart';
import 'package:procura_online/screens/conversations/widgets/orders_widget.dart';
import 'package:procura_online/utils/no_glow_behavior.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final PageController _pageController = PageController();
  final TextEditingController _ordersTerm = TextEditingController();
  final TextEditingController _chatTerm = TextEditingController();
  final ChatRepository _chatRepository = Get.put(ChatRepository());
  final OrdersController _ordersController = Get.put(OrdersController(), permanent: true);
  final ChatController _chatController = Get.put(ChatController(), permanent: true);

  int _selectedIndex = 0;
  bool _fabDisabled = false;

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
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                children: [
                  FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    color: _selectedIndex == 0 ? Colors.grey[300] : Colors.grey[200],
                    minWidth: 120,
                    height: 40,
                    onPressed: () => _selectedIndex != 0
                        ? _pageController.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.linear)
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
                                        "Unread",
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
                                          [_ordersController.changeFilter(name: 'Unread', value: 'unread'), Get.back()],
                                    ),
                                    Divider(),
                                    ListTileMoreCustomizable(
                                      leading: Icon(
                                        Icons.visibility_outlined,
                                        color: Colors.black,
                                      ),
                                      title: Text(
                                        "Read",
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
                                        "Sent",
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
                                        "All",
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
                              borderRadius: BorderRadius.circular(8),
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
                  SizedBox(width: 10),
                  FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    color: _selectedIndex == 1 ? Colors.grey[300] : Colors.grey[200],
                    minWidth: 120,
                    height: 40,
                    onPressed: () =>
                        _pageController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.linear),
                    child: Text('Conversations'),
                  ),
                  SizedBox(width: 10),
                  FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    color: Colors.grey[200],
                    minWidth: 120,
                    height: 40,
                    onPressed: () {},
                    child: Text('Others'),
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
      floatingActionButton: AnimatedOpacity(
        opacity: _selectedIndex == 0 ? 1.0 : 0.0,
        duration: Duration(milliseconds: 300),
        onEnd: () => setState(() => _fabDisabled = !_fabDisabled),
        child: !_fabDisabled
            ? FloatingActionButton(
                onPressed: () => Get.toNamed('/orders/new'),
                child: Icon(Icons.add),
              )
            : Container(),
      ),
    );
  }
}
