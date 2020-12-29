import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ShowPhotos extends StatelessWidget {
  final String photoUrl = Get.arguments['photoUrl'];
  final String photoId = Get.arguments['photoId'];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      constraints: BoxConstraints.expand(
        height: Get.size.height,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            PhotoView(
              imageProvider: CachedNetworkImageProvider(photoUrl),
              backgroundDecoration: BoxDecoration(
                color: Colors.white,
              ),
              initialScale: PhotoViewComputedScale.contained * 1.0,
              minScale: PhotoViewComputedScale.contained * 1.0,
              maxScale: PhotoViewComputedScale.contained * 3.0,
              heroAttributes: PhotoViewHeroAttributes(tag: photoId),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.0, top: MediaQuery.of(context).padding.top),
              child: IconButton(
                icon: Icon(Icons.close, size: 35),
                onPressed: () => Get.back(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
