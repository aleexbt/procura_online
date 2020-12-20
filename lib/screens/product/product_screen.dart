import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:procura_online/screens/product/product_controller.dart';
import 'package:share/share.dart';

class ProductScreen extends StatelessWidget {
  final ProductController _productScreenController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              if (_productScreenController.state?.title != null) {
                Share.share(_productScreenController.state.title);
              }
            },
          )
        ],
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              _productScreenController.obx(
                (state) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Image.network(
                          'https://quatrorodas.abril.com.br/wp-content/uploads/2020/02/bmw_x5_xdrive45e-1-e1581517888476.jpeg?quality=70&strip=info'),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                      child: Container(
                        constraints: BoxConstraints(minHeight: 60),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300],
                              offset: Offset(2.0, 1.0), //(x,y)
                              blurRadius: 5.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    '\$${state.price}',
                                    style: TextStyle(color: Colors.blueAccent),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '\$${state.oldPrice}',
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 2),
                      child: Container(
                        constraints: BoxConstraints(minHeight: 60),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300],
                              offset: Offset(2.0, 1.0), //(x,y)
                              blurRadius: 5.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 12, left: 8),
                              child: Text(
                                'Product detail',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Html(data: state.description),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                onLoading: LinearProgressIndicator(),
                onError: (error) => Padding(
                  padding: EdgeInsets.only(top: Get.height / 4),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/not_found_towing.svg', width: 350),
                      SizedBox(height: 20),
                      Text(
                        error,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
                ),
              ),
              SizedBox(height: 80),
            ],
          ),
          // _productScreenController.obx(
          //   (state) => Positioned(
          //     width: MediaQuery.of(context).size.width,
          //     bottom: 0.0,
          //     child: SafeArea(
          //       top: false,
          //       child: Padding(
          //         padding: const EdgeInsets.all(15.0),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             SizedBox(
          //               width: 170,
          //               height: 60,
          //               child: Container(
          //                 decoration: BoxDecoration(
          //                   gradient: LinearGradient(
          //                     begin: Alignment.centerLeft,
          //                     end: Alignment.centerRight,
          //                     colors: [
          //                       Colors.blue[200],
          //                       Colors.blue[700],
          //                     ],
          //                   ),
          //                   borderRadius: BorderRadius.circular(6),
          //                   boxShadow: [
          //                     BoxShadow(
          //                       color: Colors.grey[600],
          //                       offset: Offset(2.0, 1.0), //(x,y)
          //                       blurRadius: 5.0,
          //                     ),
          //                   ],
          //                 ),
          //                 child: Center(
          //                     child: Text(
          //                   'Message',
          //                   style: TextStyle(
          //                     color: Colors.white,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 )),
          //               ),
          //             ),
          //             SizedBox(
          //               width: 170,
          //               height: 60,
          //               child: Container(
          //                 decoration: BoxDecoration(
          //                   gradient: LinearGradient(
          //                     begin: Alignment.centerLeft,
          //                     end: Alignment.centerRight,
          //                     colors: [
          //                       Colors.blue[200],
          //                       Colors.blue[700],
          //                     ],
          //                   ),
          //                   borderRadius: BorderRadius.circular(6),
          //                   boxShadow: [
          //                     BoxShadow(
          //                       color: Colors.grey[600],
          //                       offset: Offset(2.0, 1.0), //(x,y)
          //                       blurRadius: 5.0,
          //                     ),
          //                   ],
          //                 ),
          //                 child: Center(
          //                     child: Text(
          //                   'Call',
          //                   style: TextStyle(
          //                     color: Colors.white,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 )),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          //   onLoading: Container(),
          //   onError: (_) => Container(),
          // ),
        ],
      ),
      floatingActionButton: _productScreenController.obx(
        (state) => SpeedDial(
          // animatedIcon: AnimatedIcons.menu_close,
          child: Icon(CupertinoIcons.ellipses_bubble_fill),
          curve: Curves.bounceIn,
          overlayOpacity: 0.5,
          children: [
            SpeedDialChild(
              child: Icon(CupertinoIcons.phone),
              backgroundColor: Colors.green,
              label: 'Phone call',
              onTap: () => print('Phone call'),
            ),
            SpeedDialChild(
              child: Icon(CupertinoIcons.chat_bubble_fill),
              backgroundColor: Colors.blue,
              label: 'Send message',
              onTap: () => print('Send message'),
            ),
          ],
        ),
        onLoading: Container(),
        onError: (_) => Container(),
      ),
    );
  }
}
