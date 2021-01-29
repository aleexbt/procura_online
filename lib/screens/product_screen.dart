import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:procura_online/controllers/product_controller.dart';
import 'package:share/share.dart';

class ProductScreen extends StatelessWidget {
  final ProductController _productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              if (_productController.product.title != null) {
                Share.share(
                    'I think I found a product you may like ${_productController.product.title}, https://procuraonline-dev.pt/listings/${_productController.product.slug}/${_productController.product.id}');
              }
            },
          )
        ],
      ),
      body: ListView(
        children: [
          GetX<ProductController>(
            init: _productController,
            builder: (_) {
              if (_.isLoading) {
                return LinearProgressIndicator();
              }
              if (_.hasError) {
                return Padding(
                  padding: EdgeInsets.only(top: Get.height / 4),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/not_found_towing.svg', width: 350),
                        SizedBox(height: 20),
                        Text(
                          'Ops, we cannot find this product.',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: Carousel(
                      dotSize: 5.0,
                      dotSpacing: 15.0,
                      dotBgColor: Colors.transparent,
                      dotColor: Colors.blue.withOpacity(0.5),
                      overlayShadow: true,
                      dotIncreasedColor: Colors.blue,
                      autoplay: false,
                      images: buildImage(_.product.gallery?.original, _.product.mainPhoto?.original),
                    ),
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
                              _.product.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  '\$${_.product.price}',
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                                SizedBox(width: 10),
                                Visibility(
                                  visible: _.product.oldPrice != '0.00',
                                  child: Text(
                                    '\$${_.product.oldPrice}',
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      decoration: TextDecoration.lineThrough,
                                    ),
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
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 2),
                            child: Text(
                              'Description',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(),
                          Html(data: _.product.description),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 80),
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
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 2),
                            child: Text(
                              'Details',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: 'Make: ',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: _.product.make.capitalizeFirst ?? 'Not specified',
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontWeight: FontWeight.normal,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Divider(height: 30),
                                      RichText(
                                        text: TextSpan(
                                          text: 'Model: ',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: _.product.model ?? 'Not specified',
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontWeight: FontWeight.normal,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Divider(height: 30),
                                      RichText(
                                        text: TextSpan(
                                          text: 'Year: ',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: _.product.year ?? 'Not specified',
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontWeight: FontWeight.normal,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                VerticalDivider(),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: 'Fuel: ',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: _.product.fuelType.capitalizeFirst ?? 'Not specified',
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontWeight: FontWeight.normal,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Divider(height: 30),
                                      RichText(
                                        text: TextSpan(
                                          text: 'Milage: ',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: _.product.mileage ?? 'Not specified',
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontWeight: FontWeight.normal,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Divider(height: 30),
                                      RichText(
                                        text: TextSpan(
                                          text: 'E. power: ',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: _.product.enginePower ?? 'Not specified',
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontWeight: FontWeight.normal,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                VerticalDivider(),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: 'Doors: ',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: _.product.numberOfDoors ?? 'Not specified',
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontWeight: FontWeight.normal,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Divider(height: 30),
                                      RichText(
                                        text: TextSpan(
                                          text: 'Seats: ',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: _.product.numberOfSeats ?? 'Not specified',
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontWeight: FontWeight.normal,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Divider(height: 30),
                                      RichText(
                                        text: TextSpan(
                                          text: 'Color: ',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: _.product.color ?? 'Not specified',
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontWeight: FontWeight.normal,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      floatingActionButton: GetX<ProductController>(
        builder: (_) {
          if (_.isLoading || _.hasError) {
            return Container();
          }
          return SpeedDial(
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
          );
        },
      ),
    );
  }

  List buildImage(Map<String, dynamic> photos, String mainPhoto) {
    List images = [];

    if (mainPhoto != null) {
      images.add(
        GestureDetector(
          onTap: () => Get.toNamed(
            '/show-photos',
            arguments: {
              "photoId": "photo",
              "photoUrl": "$mainPhoto",
            },
          ),
          child: Hero(
            tag: 'photo',
            child: OctoImage(
              image: CachedNetworkImageProvider(mainPhoto),
              placeholderBuilder: OctoPlaceholder.blurHash('LAI#u-9XM[D\$GdIU4oIA-sWFxwRl'),
              errorBuilder: OctoError.icon(color: Colors.grey[400]),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

    if (photos != null) {
      images.addAll(photos.entries
          .map((entry) => GestureDetector(
                onTap: () => Get.toNamed(
                  '/show-photos',
                  arguments: {
                    "photoId": "photo_${entry.key}",
                    "photoUrl": "${entry.value}",
                  },
                ),
                child: Hero(
                  tag: 'photo_${entry.key}',
                  child: OctoImage(
                    image: CachedNetworkImageProvider(entry.value),
                    placeholderBuilder: OctoPlaceholder.blurHash('LAI#u-9XM[D\$GdIU4oIA-sWFxwRl'),
                    errorBuilder: OctoError.icon(color: Colors.grey[400]),
                    fit: BoxFit.cover,
                  ),
                ),
              ))
          .toList());
    }

    if (mainPhoto == null && photos == null) {
      images.add(
        GestureDetector(
          onTap: () => Get.toNamed(
            '/show-photos',
            arguments: {
              "photoId": "photo",
              "photoUrl": "https://source.unsplash.com/600x500/?bmw,audi,volvo",
            },
          ),
          child: Hero(
            tag: 'photo',
            child: OctoImage(
              image: CachedNetworkImageProvider('https://source.unsplash.com/600x500/?bmw,audi,volvo'),
              placeholderBuilder: OctoPlaceholder.blurHash('LAI#u-9XM[D\$GdIU4oIA-sWFxwRl'),
              errorBuilder: OctoError.icon(color: Colors.grey[400]),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }
    return images;
  }
}
