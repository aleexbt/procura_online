import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoGallery extends StatefulWidget {
  final List<OctoImage> galleryItems;
  final int initialPhoto;

  PhotoGallery(this.galleryItems, this.initialPhoto);

  @override
  _PhotoGalleryState createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  int currentIndex;
  bool showOverlays = true;
  PageController _controller;

  @override
  void initState() {
    print(widget.galleryItems.length);
    _controller = PageController(initialPage: widget.initialPhoto);
    currentIndex = widget.initialPhoto;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
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
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => changeOverlays(),
      child: Material(
        child: Container(
          constraints: BoxConstraints.expand(
            height: Get.size.height,
          ),
          child: Stack(
            children: [
              Container(
                child: PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: widget.galleryItems[index].image,
                      initialScale: PhotoViewComputedScale.contained * 1.0,
                      minScale: PhotoViewComputedScale.contained * 1.0,
                      maxScale: PhotoViewComputedScale.contained * 4.0,
                      heroAttributes: PhotoViewHeroAttributes(tag: widget.galleryItems[index]),
                    );
                  },
                  itemCount: widget.galleryItems.length,
                  loadingBuilder: (context, event) => Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  backgroundDecoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  pageController: _controller,
                  onPageChanged: onPageChanged,
                ),
              ),
              Visibility(
                visible: showOverlays,
                child: Padding(
                  padding: EdgeInsets.only(left: 3, top: MediaQuery.of(context).padding.top + 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
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
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          '${currentIndex + 1} / ${widget.galleryItems.length.toString()}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
