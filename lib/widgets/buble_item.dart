import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:procura_online/widgets/text_widget.dart';

class Bubble extends StatelessWidget {
  Bubble({this.photo, this.message, this.time, this.delivered, this.isMe});

  final String photo, message, time;
  final delivered, isMe;

  @override
  Widget build(BuildContext context) {
    final bg = isMe ? Colors.grey : Colors.lightBlueAccent;
    final align = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = !isMe
        ? BorderRadius.only(
            topRight: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          );
    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(3.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            gradient: isMe
                ? LinearGradient(colors: <Color>[Colors.lightBlueAccent, Colors.blue])
                : LinearGradient(colors: <Color>[Colors.grey[400], Colors.grey[350]]),
            boxShadow: [BoxShadow(blurRadius: .5, spreadRadius: 1.0, color: Colors.black.withOpacity(.12))],
            borderRadius: radius,
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 4.0, bottom: 4.0, right: 4.0),
            child: Column(
              crossAxisAlignment: align,
              children: [
                photo != null
                    ? GestureDetector(
                        onTap: () => Get.toNamed(
                          '/show-photos',
                          arguments: {
                            "photoId": "photo",
                            "photoUrl": "$photo",
                          },
                        ),
                        child: Hero(
                          tag: 'photo',
                          child: SizedBox(
                            width: 250,
                            child: OctoImage(
                              image: CachedNetworkImageProvider(photo),
                              placeholderBuilder: OctoPlaceholder.circularProgressIndicator(),
                              errorBuilder: OctoError.icon(color: Colors.grey[400]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : Container(width: 0, height: 0),
                TextWidget(
                  text: message,
                  colorText: isMe ? Colors.white : Colors.black,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextWidget(
            text: time,
            colorText: Colors.grey,
          ),
        ),
      ],
    );
  }
}
