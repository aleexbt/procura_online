import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImagePreview extends StatefulWidget {
  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  final String photoUrl =
      'https://procuraonline-dev.pt/storage/56/conversions/194af8b8-8ab7-4f85-99d6-c632c42df8d9-big_thumb.jpg';
  final String photoId = '1';

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ExtendedImage.network(
        photoUrl,
        fit: BoxFit.contain,
        enableSlideOutPage: true,
        mode: ExtendedImageMode.gesture,
        initGestureConfigHandler: (state) {
          return GestureConfig(
            minScale: 1.0,
            animationMinScale: 1.0,
            maxScale: 4.0,
            animationMaxScale: 4.0,
            speed: 1.0,
            inertialSpeed: 100.0,
            initialScale: 1.0,
            inPageView: false,
            initialAlignment: InitialAlignment.center,
          );
        },
        onDoubleTap: (_) => {},
      ),
    );
  }
}
