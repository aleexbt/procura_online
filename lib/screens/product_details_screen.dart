import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:procura_online/controllers/details_controller.dart';
import 'package:procura_online/models/listing_model.dart';
import 'package:share/share.dart';

class ProductDetailsScreen extends StatelessWidget {
  final DetailsController _detailsController = Get.put(DetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share(_detailsController.data?.title ?? 'Sharing');
            },
          )
        ],
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              FutureBuilder<ListingItem>(
                  future: _detailsController.getOne(Get.parameters['id']),
                  builder: (context, AsyncSnapshot<ListingItem> snapshot) {
                    if (_detailsController.isLoading) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    }

                    if (_detailsController.hasError) {
                      return Padding(
                        padding: const EdgeInsets.all(30),
                        child: Center(child: Text('OPS, PRODUCT NOT FOUND!')),
                      );
                    }
                    return Column(
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
                                    _detailsController.data.title,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        '\$${_detailsController.data.price}',
                                        style: TextStyle(color: Colors.blueAccent),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        '\$${_detailsController.data.oldPrice}',
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
                                  // child: Text(
                                  //   _detailsController.data.description,
                                  //   style: TextStyle(
                                  //     color: Colors.grey[600],
                                  //   ),
                                  // ),
                                  child: Html(data: _detailsController.data.description),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
              SizedBox(height: 80),
            ],
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: 0.0,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 170,
                      height: 60,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.blue[200],
                              Colors.blue[700],
                            ],
                          ),
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[600],
                              offset: Offset(2.0, 1.0), //(x,y)
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Center(
                            child: Text(
                          'Message',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                    ),
                    SizedBox(
                      width: 170,
                      height: 60,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.blue[200],
                              Colors.blue[700],
                            ],
                          ),
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[600],
                              offset: Offset(2.0, 1.0), //(x,y)
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Center(
                            child: Text(
                          'Call',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
