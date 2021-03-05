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
import 'package:procura_online/widgets/photo_gallery.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductScreen extends StatelessWidget {
  final ProductController _productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              if (_productController.product.title != null) {
                Share.share(
                    'Acho que você pode gostar disso: ${_productController.product.title}, https://procuraonline-dev.pt/listings/${_productController.product.slug}/${_productController.product.id}');
              }
            },
          )
        ],
      ),
      body: ListView(
        // padding: EdgeInsets.only(top: 0),
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
                          'Ops, anúncio não encontrado.',
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
                      onImageTap: (value) {
                        Get.to(
                          PhotoGallery(buildImage(_.product.gallery?.original, _.product.mainPhoto?.original), value),
                        );
                      },
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
                                // SizedBox(width: 10),
                                // Visibility(
                                //   visible: _.product.oldPrice != '0.00',
                                //   child: Text(
                                //     '\$${_.product.oldPrice}',
                                //     style: TextStyle(
                                //       color: Colors.grey[400],
                                //       decoration: TextDecoration.lineThrough,
                                //     ),
                                //   ),
                                // ),
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
                              'Descrição',
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
                              'Detalhes',
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
                                          text: 'Marca: ',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: _.product.make.capitalizeFirst ?? 'Não informado',
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
                                          text: 'Modelo: ',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: _.product.model ?? 'Não informado',
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
                                          text: 'Ano: ',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: _.product.year.toString() ?? 'Não especificado',
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
                                          text: 'Mês registro: ',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: _.product.registered != null
                                                    ? _.product.registered.split('-')[1]
                                                    : 'Não especificado',
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
                                          text: 'Ano registro: ',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: _.product.registered != null
                                                    ? _.product.registered.split('-')[0]
                                                    : 'Não especificado',
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
                                          text: 'Combustível: ',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: _.product.fuelType.capitalizeFirst ?? 'Não especificado',
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
                                          text: 'Quilómetros: ',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: _.product.mileage.toString() ?? 'Não especificado',
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
                                          text: 'Cilindrada: ',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: _.product.engineDisplacement.toString() ?? 'Não especificado',
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
                                          text: 'Potência: ',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: _.product.enginePower.toString() ?? 'Não especificado',
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
                                          text: 'Portas: ',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: _.product.numberOfDoors.toString() ?? 'Não especificado',
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
                                          text: 'Lotação: ',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: _.product.numberOfSeats.toString() ?? 'Não especificado',
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
                                          text: 'Cor: ',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: _.product.color ?? 'Não especificado',
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
                                          text: 'Condição: ',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: _.product.condition ?? 'Não especificado',
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
                                          text: 'Negociável: ',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: _.product.negotiable != null
                                                    ? _.product.negotiable == 0
                                                        ? 'Não'
                                                        : 'Sim'
                                                    : 'Não especificado',
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 80),
                    child: Ink(
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
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4),
                        onTap: () => Get.offNamed('/profile/${_.product.user.id}'),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 0, 2),
                              child: Text(
                                'Anunciante',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 12, 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: ClipOval(
                                      child: Image.network(_.product.user.logo.thumbnail),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _.product.user.name,
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          _.product.user.company ?? '',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(_.product.user.address ?? ''),
                                        // Text(),
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
                  label: 'Ligar',
                  onTap: () => launch('tel://${_.product.user.phone}')),
              SpeedDialChild(
                child: Icon(CupertinoIcons.mail_solid),
                backgroundColor: Colors.blue,
                label: 'E-mail',
                onTap: () => launch('mailto:${_.product.user.email}?subject=Re: ${_.product.title}'),
              ),
            ],
          );
        },
      ),
    );
  }

  List buildImage(Map<String, dynamic> photos, String mainPhoto) {
    List<OctoImage> images = [];

    if (mainPhoto != null) {
      images.add(
        OctoImage(
          image: CachedNetworkImageProvider(mainPhoto),
          placeholderBuilder: OctoPlaceholder.blurHash('LAI#u-9XM[D\$GdIU4oIA-sWFxwRl'),
          errorBuilder: OctoError.icon(color: Colors.grey[400]),
          fit: BoxFit.cover,
        ),
      );
    }

    if (photos != null) {
      images.addAll(photos.entries
          .map((entry) => OctoImage(
                image: CachedNetworkImageProvider(entry.value),
                placeholderBuilder: OctoPlaceholder.blurHash('LAI#u-9XM[D\$GdIU4oIA-sWFxwRl'),
                errorBuilder: OctoError.icon(color: Colors.grey[400]),
                fit: BoxFit.cover,
              ))
          .toList());
    }

    if (mainPhoto == null && photos == null) {
      images.add(
        OctoImage(
          image: CachedNetworkImageProvider('https://source.unsplash.com/600x500/?bmw,audi,volvo'),
          placeholderBuilder: OctoPlaceholder.blurHash('LAI#u-9XM[D\$GdIU4oIA-sWFxwRl'),
          errorBuilder: OctoError.icon(color: Colors.grey[400]),
          fit: BoxFit.cover,
        ),
      );
    }
    return images;
  }
}
