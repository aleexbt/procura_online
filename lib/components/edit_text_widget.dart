// import 'package:flutter/material.dart';
// import 'package:procura_online/utils/constants.dart';
//
// class EditTextWidget extends StatelessWidget {
//   final String hintText, labelText;
//   final int maxLines;
//   final TextInputType keyboardType;
//   final TextEditingController controller;
//   final ValueChanged valueChanged;
//   final bool enabled;
//
//   const EditTextWidget(
//       {Key key,
//       this.hintText,
//       this.labelText,
//       this.maxLines,
//       this.controller,
//       this.keyboardType,
//       this.valueChanged,
//       this.enabled})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 16),
//       child: Container(
//         color: Colors.grey[50],
//         width: double.infinity,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(left: 8.0),
//               child: TextField(
//                 enabled: enabled ==null ? true: enabled,
//                 keyboardType:
//                     keyboardType == null ? TextInputType.text : keyboardType,
//                 controller: controller,
//                 maxLines: maxLines == null ? 1 : maxLines,
//                 decoration: InputDecoration(
//                   hintStyle: TextStyle(fontSize: 14),
//                   labelText: labelText,
//                   hintText:
//                       hintText == null ? Constants.TEXT_TYPE_HERE : hintText,
//                   border: InputBorder.none,
//                 ),
//                 onChanged: valueChanged,
//               ),
//             ),
//             Divider(
//               height: 2,
//               color: Colors.grey,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
