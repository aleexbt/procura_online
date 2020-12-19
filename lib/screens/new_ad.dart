import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:procura_online/widgets/select_option.dart';
import 'package:procura_online/widgets/text_input.dart';
import 'package:smart_select/smart_select.dart';

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

  String selectedBrand = '';
  String selectedModel = '';
  String selectedColor = '';

  List<S2Choice<String>> brandOptions = [
    S2Choice<String>(value: '1', title: 'BMW'),
    S2Choice<String>(value: '2', title: 'Ford'),
    S2Choice<String>(value: '3', title: 'Mercedes-Benz'),
  ];

  List<S2Choice<String>> modelOptions = [
    S2Choice<String>(value: '1', title: 'Sedan'),
    S2Choice<String>(value: '2', title: 'Sport'),
  ];

  List<S2Choice<String>> colorOptions = [
    S2Choice<String>(value: '1', title: 'Black'),
    S2Choice<String>(value: '2', title: 'Blue'),
    S2Choice<String>(value: '3', title: 'Green'),
    S2Choice<String>(value: '4', title: 'White'),
    S2Choice<String>(value: '5', title: 'Grey'),
  ];

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
                      height: 200,
                      decoration: BoxDecoration(color: Colors.grey[200]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
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
                                Text('Select photos'),
                              ],
                            ),
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
                      height: 200,
                      decoration: BoxDecoration(color: Colors.grey[200]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        width: double.infinity,
                        height: 180,
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
                                  child: Stack(
                                    children: [
                                      AssetThumb(
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
                                      Positioned(
                                        top: 4,
                                        right: 4,
                                        child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                images.removeAt(index);
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
                  SizedBox(height: 20),
                  Text(
                    'Brand',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  SelectOption(
                    placeholder: 'Select one',
                    modalTitle: 'Brands',
                    selectText: 'Select a brand',
                    value: selectedBrand,
                    choiceItems: brandOptions,
                    onChange: (state) => setState(() => selectedBrand = state.value),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Model',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  SelectOption(
                    placeholder: 'Select one',
                    modalTitle: 'Models',
                    selectText: 'Select a model',
                    value: selectedModel,
                    choiceItems: modelOptions,
                    onChange: (state) => setState(() => selectedModel = state.value),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Year',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomTextInput(
                    fillColor: Colors.grey[200],
                    hintText: 'Enter the year',
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Color',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  SelectOption(
                    modalTitle: 'Colors',
                    selectText: 'Select a color',
                    value: selectedColor,
                    choiceItems: colorOptions,
                    onChange: (state) => setState(() => selectedColor = state.value),
                  ),
                  SizedBox(height: 60),
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
