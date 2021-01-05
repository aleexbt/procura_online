import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ShowPhotos extends StatefulWidget {
  @override
  _ShowPhotosState createState() => _ShowPhotosState();
}

class _ShowPhotosState extends State<ShowPhotos> {
  final String photoUrl = Get.arguments['photoUrl'];
  final String photoId = Get.arguments['photoId'];

  @override
  initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    //SystemChrome.restoreSystemUIOverlays();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        // color: Colors.white,
        constraints: BoxConstraints.expand(
          height: Get.size.height,
        ),
        child: Stack(
          children: [
            PhotoView(
              imageProvider: CachedNetworkImageProvider(photoUrl),
              backgroundDecoration: BoxDecoration(
                  // color: Colors.white,
                  ),
              initialScale: PhotoViewComputedScale.contained * 1.0,
              minScale: PhotoViewComputedScale.contained * 1.0,
              maxScale: PhotoViewComputedScale.contained * 4.0,
              heroAttributes: PhotoViewHeroAttributes(tag: photoId),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, top: MediaQuery.of(context).padding.top + 15),
              child: ClipOval(
                child: Container(
                  color: Colors.white,
                  child: IconButton(
                    icon: Icon(Icons.close, size: 33),
                    onPressed: () => Get.back(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
