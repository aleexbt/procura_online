import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class NewAdScreen2 extends StatefulWidget {
  @override
  _NewAdScreen2State createState() => _NewAdScreen2State();
}

class _NewAdScreen2State extends State<NewAdScreen2> {
  List<Asset> images = [];
  String _error;

  Future<void> loadAssets() async {
    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        materialOptions: MaterialOptions(
            actionBarTitle: "Action bar",
            allViewTitle: "Gallery",
            actionBarColor: "#2196F3",
            statusBarColor: '#1976D2',
            startInAllView: true,
            selectCircleStrokeColor: "#000000",
            selectionLimitReachedText: 'You can\'t select any more.',
            textOnNothingSelected: 'You have to select at least 1 picture.'),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    if (resultList.isNotEmpty) {
      setState(() {
        images = resultList;
        if (error == null) _error = 'No Error Dectected';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('New ad test'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: loadAssets,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(4),
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
                            Text('Select photos'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      Asset asset = images[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: AssetThumb(
                            asset: asset,
                            width: 250,
                            height: 200,
                            spinner: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
