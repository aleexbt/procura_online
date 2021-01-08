import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadEditor extends StatefulWidget {
  final Map<String, dynamic> remoteImages;
  final List<File> selectedImages;
  final Function deleteRemote;
  final Function deleteSelected;

  const UploadEditor({Key key, this.remoteImages, this.selectedImages, this.deleteRemote, this.deleteSelected})
      : super(key: key);

  @override
  _UploadEditorState createState() => _UploadEditorState();
}

class _UploadEditorState extends State<UploadEditor> {
  Map<String, dynamic> remoteImages;
  List<File> selectedImages;
  Function deleteRemote;
  Function deleteSelected;

  void selectImages() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path)).toList();

      if (files.length > 5) {
        List<File> limitedSelect = files.sublist(0, 5);
        setState(() => selectedImages.addAll(limitedSelect));
      } else {
        setState(() => selectedImages.addAll(files));
      }
      if (selectedImages.length >= 5) {
        setState(() => selectedImages = selectedImages.sublist(0, 5));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(color: Colors.grey[200]),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            width: double.infinity,
            height: 180,
            child: Center(
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                children: [
                  // ListView of remote images
                  ListView.builder(
                    itemCount: remoteImages.length,
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      // Map<String, dynamic> entry = _editAdController.product.photos.original;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(
                            children: [
                              SizedBox(
                                width: 250,
                                height: 200,
                                child: Image.network(
                                  remoteImages.values.elementAt(index),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      // imagesToRemove.add(entry.keys.elementAt(index));
                                      remoteImages.removeWhere((key, value) => remoteImages.values.elementAt(index));
                                    });
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  // ListView of selected images
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: selectedImages.length + 1,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      Map<String, dynamic> entry = remoteImages ?? {"": ""};
                      if (index == selectedImages.length) {
                        return selectedImages.length + entry.length < 5
                            ? GestureDetector(
                                onTap: selectImages,
                                behavior: HitTestBehavior.translucent,
                                child: Container(
                                  width: 220,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.camera_alt_outlined,
                                          size: 50,
                                          color: Colors.blue,
                                        ),
                                        Text('Select a picture0'),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Container();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(
                            children: [
                              SizedBox(
                                width: 250,
                                height: 200,
                                child: Image.file(
                                  File(selectedImages[index].path),
                                  width: 250,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedImages.removeAt(index);
                                      });
                                    },
                                    child: Icon(Icons.delete, color: Colors.red)),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
