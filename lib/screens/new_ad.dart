import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:procura_online/widgets/text_input.dart';

class NewAdScreen extends StatefulWidget {
  @override
  _NewAdScreenState createState() => _NewAdScreenState();
}

class _NewAdScreenState extends State<NewAdScreen> {
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
        title: Text('New Ad'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Center(child: Text('Error: $_error')),
            Visibility(
              visible: images.length == 0 ? true : false,
              child: GestureDetector(
                onTap: loadAssets,
                behavior: HitTestBehavior.translucent,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(color: Colors.grey[200]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        width: double.infinity,
                        height: 280,
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
                  ],
                ),
              ),
            ),
            Visibility(
              visible: images.length > 0 ? true : false,
              child: GestureDetector(
                onTap: loadAssets,
                behavior: HitTestBehavior.translucent,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(color: Colors.grey[200]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        width: double.infinity,
                        height: 280,
                        child: Center(
                          child: ListView.builder(
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
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ad title',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomTextInput(
                    fillColor: Colors.grey[200],
                    hintText: 'Enter the title of your ad',
                    textCapitalization: TextCapitalization.words,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Description',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomTextInput(
                    fillColor: Colors.grey[200],
                    hintText: 'Enter the description of the item',
                    textCapitalization: TextCapitalization.words,
                    maxLines: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('Publish Ads'),
        icon: Icon(Icons.save),
      ),
    );
  }
}
