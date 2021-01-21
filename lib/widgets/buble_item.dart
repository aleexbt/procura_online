import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:procura_online/models/message_media.dart';

class Bubble extends StatelessWidget {
  Bubble({
    this.id,
    this.photos,
    this.message,
    this.time,
    this.isMe,
  });

  final String id, message, time;
  final List<MessageMedia> photos;
  final isMe;

  @override
  Widget build(BuildContext context) {
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
                : LinearGradient(colors: <Color>[Colors.grey[200], Colors.grey[200]]),
            borderRadius: radius,
          ),
          child: Padding(
            padding: EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: align,
              children: [
                photosGallery(photos),
                photos != null ? SizedBox(height: 5) : Container(width: 0, height: 0),
                Text(
                  message,
                  style: TextStyle(color: isMe ? Colors.white : Colors.black),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            time,
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget photosGallery(List<MessageMedia> photos) {
    if (photos == null) {
      return Container(width: 0, height: 0);
    } else if (photos.length == 1) {
      return GestureDetector(
        onTap: () => Get.toNamed(
          '/show-photos',
          arguments: {
            "photoId": "${photos[0].id}",
            "photoUrl": "${photos[0].image}",
          },
        ),
        child: Hero(
          tag: '${photos[0].id}',
          child: SizedBox(
            width: 250,
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: OctoImage(
                image: CachedNetworkImageProvider(photos[0].image),
                placeholderBuilder: OctoPlaceholder.blurHash('LAI#u-9XM[D\$GdIU4oIA-sWFxwRl'),
                errorBuilder: OctoError.icon(color: Colors.grey[400]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        width: 250,
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              childAspectRatio: 1.0,
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: photos.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Get.toNamed(
                  '/show-photos',
                  arguments: {
                    "photoId": "${photos[index].id}",
                    "photoUrl": "${photos[index].image}",
                  },
                ),
                child: Hero(
                  tag: '${photos[index].id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: SizedBox(
                      width: 250,
                      child: OctoImage(
                        image: CachedNetworkImageProvider(photos[index].image),
                        placeholderBuilder: OctoPlaceholder.blurHash('LAI#u-9XM[D\$GdIU4oIA-sWFxwRl'),
                        errorBuilder: OctoError.icon(color: Colors.grey[400]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            }),
      );
    }
  }
}
