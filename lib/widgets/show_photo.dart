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

  bool showOverlays = true;

  @override
  initState() {
    // SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
  }

  void changeOverlays() {
    if (showOverlays) {
      SystemChrome.setEnabledSystemUIOverlays([]);
    } else {
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    }
    setState(() => showOverlays = !showOverlays);
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
    return GestureDetector(
      onTap: () => changeOverlays(),
      child: Material(
        color: Colors.white,
        child: Container(
          constraints: BoxConstraints.expand(
            height: Get.size.height,
          ),
          child: Stack(
            children: [
              PhotoView(
                imageProvider: CachedNetworkImageProvider(photoUrl),
                backgroundDecoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                initialScale: PhotoViewComputedScale.contained * 1.0,
                minScale: PhotoViewComputedScale.contained * 1.0,
                maxScale: PhotoViewComputedScale.contained * 4.0,
                heroAttributes: PhotoViewHeroAttributes(tag: photoId),
              ),
              Visibility(
                visible: showOverlays,
                child: Padding(
                  padding: EdgeInsets.only(left: 3, top: MediaQuery.of(context).padding.top + 3),
                  child: IconButton(
                    icon: ClipOval(
                      child: Container(
                        width: 35,
                        height: 35,
                        color: Colors.white54,
                        child: Icon(
                          Icons.arrow_back,
                        ),
                      ),
                    ),
                    onPressed: () => Get.back(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
