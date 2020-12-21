// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:procura_online/models/product_model.dart';
// import 'package:procura_online/screens/product_details_screen.dart';
// import 'package:procura_online/utils/colors.dart';
//
// import 'text_widget.dart';
// //This class return a ListView widget to show the details for Accident and breakdown
//
// class ListHomeItem extends StatelessWidget {
//   final List<Datum> listItems;
//
//   const ListHomeItem({Key key, @required this.listItems}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//         gridDelegate:
//             SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//         itemCount: listItems.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(0.0),
//             child: InkWell(
//               child: Card(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Expanded(
//                       child: Container(
//                         width: double.infinity,
//                         child: CachedNetworkImage(
//                           imageUrl: listItems[index].gallery.length > 0
//                               ? 'http://pofill2019.tk/' +
//                                   listItems[index].gallery[0].url
//                               : 'http://pofill2019.tk/abc.png',
//                           fit: BoxFit.fill,
//                           placeholder: (context, url) =>
//                               new Image.asset('images/logo.png'),
//                           errorWidget: (context, url, error) =>
//                               new Image.asset('images/raw_icon.png'),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextWidget(
//                         text: listItems[index].title,
//                         textType: TextType.TEXT_MEDIUM,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                           left: 8.0, top: 8.0, bottom: 16),
//                       child: TextWidget(
//                         text: listItems[index].price,
//                         colorText: Colors.blue,
//                         textType: TextType.TEXT_MEDIUM,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) =>
//                           ProductDetailsScreen(listItems[index])),
//                 );
//               },
//             ),
//           );
//         });
//   }
// }
