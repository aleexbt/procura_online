// import 'package:flutter/material.dart';
// import 'package:procura_online/screens/chat_details_screen.dart';
// import 'package:procura_online/screens/product_details_screen.dart';
// import 'package:procura_online/utils/colors.dart';
//
// import 'text_widget.dart';
// //This class return a ListView widget to show the details for Accident and breakdown
//
// class ListChatItem extends StatelessWidget {
//   final List<Map<String, dynamic>> listItems;
//
//   const ListChatItem({Key key, @required this.listItems}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: 10,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: InkWell(
//               child: Row(
//                 children: <Widget>[
//                   //Column for user profile
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: ClipOval(
//                         child: Image.asset(
//                       'images/ic_user.jpg',
//                       width: 40,
//                       height: 40,
//                       fit: BoxFit.cover,
//                     )),
//                   ),
//                   Expanded(
//                       child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Padding(
//                           padding: const EdgeInsets.all(4.0),
//                           child: Row(
//                             children: <Widget>[
//                               Expanded(
//                                 child: TextWidget(
//                                   text: 'Ankit',
//                                 ),
//                               ),
//                               Expanded(
//                                 child: TextWidget(
//                                   text: 'Just Now',
//                                   colorText: Colors.grey,
//                                   textAlign: TextAlign.right,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(4.0),
//                           child: TextWidget(
//                             text: 'Sound good! Catch you later mate.',
//                             colorText: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ))
//                 ],
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => ChatDetailsScreen()),
//                 );
//               },
//             ),
//           );
//         });
//   }
// }
