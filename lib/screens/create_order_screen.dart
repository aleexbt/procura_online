import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:procura_online/controllers/new_ad_controller.dart';
import 'package:procura_online/controllers/orders_controller.dart';
import 'package:procura_online/models/media_upload_model.dart';
import 'package:procura_online/widgets/gradient_button.dart';
import 'package:procura_online/widgets/select_option.dart';
import 'package:procura_online/widgets/text_input.dart';
import 'package:smart_select/smart_select.dart';

class CreateOrderScreen extends StatefulWidget {
  @override
  _CreateOrderScreenState createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  final NewAdController _newAdController = Get.put(NewAdController());
  final OrdersController _ordersController = Get.find();

  final TextEditingController _mpn = TextEditingController();
  final TextEditingController _note = TextEditingController();
  final TextEditingController _year = TextEditingController();
  final TextEditingController _engineDisplacement = TextEditingController();
  final TextEditingController _numberOfDoors = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  initState() {
    super.initState();
  }

  List<File> images = List<File>();
  List<String> imagesUrl = List<String>();

  void selectImages() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
    );

    if (result != null) {
      List<File> file = result.paths.map((path) => File(path)).toList();
      setState(() => images.add(file[0]));
      MediaUploadModel media = await _ordersController.mediaUpload(file[0]);

      if (media != null) {
        setState(() {
          imagesUrl.add(media.name);
        });
      } else {
        setState(() {
          images.removeLast();
        });
      }
    }
  }

  String selectedFuel = '';
  List<S2Choice<String>> fuelOptions = [
    S2Choice<String>(value: 'gas', title: 'Gasoline'),
    S2Choice<String>(value: 'diesel', title: 'Diesel'),
    S2Choice<String>(value: 'hybrid', title: 'Hybrid'),
    S2Choice<String>(value: 'electric', title: 'Electric'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Create order'),
        elevation: 0,
      ),
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: _ordersController.isPublishingOrder,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                images.length == 0 ? selectImageBox() : uploadBox(),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MPN',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomTextInput(
                        controller: _mpn,
                        fillColor: Colors.grey[200],
                        hintText: 'Enter the MPN',
                        textCapitalization: TextCapitalization.sentences,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Note',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomTextInput(
                        controller: _note,
                        fillColor: Colors.grey[200],
                        hintText: 'Enter a note',
                        textCapitalization: TextCapitalization.sentences,
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
                      Obx(
                        () => SelectOption(
                          isLoading: _newAdController.isLoadingBrands,
                          placeholder: 'Select one',
                          modalTitle: 'Brands',
                          selectText: 'Select a brand',
                          value: _newAdController.selectedBrand,
                          choiceItems: _newAdController.brands,
                          onChange: (state) => _newAdController.setBrand(state.value),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Model',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => SelectOption(
                          isLoading: _newAdController.isLoadingModels,
                          isDisabled: _newAdController.selectedBrand == '',
                          placeholder: 'Select one',
                          modalTitle: 'Models',
                          selectText: 'Select a model',
                          value: _newAdController.selectedModel,
                          choiceItems: _newAdController.models,
                          onChange: (state) => _newAdController.setModel(state.value),
                        ),
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
                        controller: _year,
                        fillColor: Colors.grey[200],
                        hintText: 'Enter the year',
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Engine displacement',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomTextInput(
                        controller: _engineDisplacement,
                        fillColor: Colors.grey[200],
                        hintText: 'Enter the engine displacement',
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Number of doors',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomTextInput(
                        controller: _numberOfDoors,
                        fillColor: Colors.grey[200],
                        hintText: 'Enter the number of doors',
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Fuel type',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      SelectOption(
                        modalTitle: 'Fuel',
                        selectText: 'Select a fuel type',
                        value: selectedFuel,
                        choiceItems: fuelOptions,
                        onChange: (state) => setState(() => selectedFuel = state.value),
                      ),
                      SizedBox(height: 20),
                      GradientButton(
                        text: 'Create order',
                        onPressed: () => _ordersController.createOrder(
                          images: imagesUrl,
                          mpn: _mpn.text,
                          note: _note.text,
                          brand: _newAdController.selectedBrand,
                          model: _newAdController.selectedModel,
                          year: _year.text,
                          engineDisplacement: _engineDisplacement.text,
                          numberOfDoors: _numberOfDoors.text,
                          fuelType: selectedFuel,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget selectImageBox() {
    return GestureDetector(
      onTap: selectImages,
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
                      Text('Select a picture'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget uploadBox() {
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
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: images.length + 1,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  if (index == images.length) {
                    return Obx(
                      () => GestureDetector(
                        onTap: _ordersController.isUploadingImage ? null : selectImages,
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
                                Text('Select a picture'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
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
                              File(images[index].path),
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
                                    images.removeAt(index);
                                    imagesUrl.removeAt(index);
                                  });
                                },
                                child: Icon(Icons.delete, color: Colors.red)),
                          ),
                          Obx(
                            () => Visibility(
                              visible: _ordersController.isUploadingImage && index == images.length - 1,
                              child: Container(
                                width: 250,
                                height: 200,
                                color: Colors.grey.withOpacity(0.8),
                                child: Center(
                                  child: CircularPercentIndicator(
                                    radius: 60.0,
                                    lineWidth: 5.0,
                                    percent: _ordersController.uploadImageProgress.value,
                                    center: Text(
                                      '${(_ordersController.uploadImageProgress.value * 100).round()}%',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    progressColor: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
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
    );
  }
}
