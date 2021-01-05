import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/controllers/chat_controller.dart';
import 'package:procura_online/controllers/orders_controller.dart';
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
  final OrdersController _ordersController = Get.put(OrdersController(), permanent: true);
  final ChatController _chatController = Get.put(ChatController(), permanent: true);

  int _selectedIndex = 0;

  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  color: _selectedIndex == 0 ? Colors.grey[300] : Colors.grey[200],
                  minWidth: 120,
                  height: 40,
                  onPressed: () =>
                      _pageController.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.linear),
                  child: Text('Orders'),
                ),
                FlatButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  color: _selectedIndex == 1 ? Colors.grey[300] : Colors.grey[200],
                  minWidth: 120,
                  height: 40,
                  onPressed: () =>
                      _pageController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.linear),
                  child: Text('Conversations'),
                ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/orders/new'),
        child: Icon(Icons.add),
      ),
    );
  }
}
