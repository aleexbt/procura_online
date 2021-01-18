import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:procura_online/controllers/orders_controller.dart';
import 'package:procura_online/models/upload_media_model.dart';
import 'package:procura_online/widgets/gradient_button.dart';
import 'package:procura_online/widgets/select_option.dart';
import 'package:procura_online/widgets/text_input.dart';

class CreateOrderScreen extends StatefulWidget {
  @override
  _CreateOrderScreenState createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  final OrdersController _ordersController = Get.find();
  final _formKey = GlobalKey<FormState>();
  FocusNode mainNode;

  @override
  initState() {
    _ordersController.resetFields();
    mainNode = FocusNode();
    super.initState();
  }

  bool submitted = false;
  List<File> images = List<File>.empty(growable: true);
  List<String> imagesUrl = List<String>.empty(growable: true);

  void selectImages() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      // allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
    );

    if (result != null) {
      List<File> file = result.paths.map((path) => File(path)).toList();
      setState(() => images.add(file[0]));

      UploadMedia media = await _ordersController.mediaUpload(file[0]);

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

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(mainNode);
    return Scaffold(
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
                images.length == 0 ? selectImage() : selectedImages(),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Focus(
                    focusNode: mainNode,
                    child: Form(
                      key: _formKey,
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
                            controller: _ordersController.mpn.value,
                            fillColor: Colors.grey[200],
                            hintText: 'Enter the MPN',
                            textCapitalization: TextCapitalization.sentences,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter the MPN';
                              }
                            },
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
                            controller: _ordersController.note.value,
                            fillColor: Colors.grey[200],
                            hintText: 'Enter a note',
                            textCapitalization: TextCapitalization.sentences,
                            maxLines: 5,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a note';
                              }
                            },
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
                              enableFilter: true,
                              isLoading: _ordersController.isLoadingBrands,
                              placeholder: 'Select one',
                              modalTitle: 'Brands',
                              selectText: 'Select a brand',
                              value: _ordersController.selectedBrand.value,
                              choiceItems: _ordersController.brands,
                              onChange: (state) => _ordersController.setBrand(state.value),
                              hasError: _ordersController.selectedBrand.value.isEmpty && submitted,
                            ),
                          ),
                          Obx(
                            () => Visibility(
                              visible: _ordersController.selectedBrand.value.isEmpty && submitted,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12, top: 5),
                                child: Text(
                                  'Please select a brand',
                                  style: TextStyle(color: Colors.red, fontSize: 12),
                                ),
                              ),
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
                              enableFilter: true,
                              isLoading: _ordersController.isLoadingModels,
                              isDisabled: _ordersController.selectedBrand.value == '',
                              placeholder: 'Select one',
                              modalTitle: 'Models',
                              selectText: 'Select a model',
                              value: _ordersController.selectedModel.value,
                              choiceItems: _ordersController.models,
                              onChange: (state) => _ordersController.setModel(state.value),
                              hasError: _ordersController.selectedModel.value.isEmpty && submitted,
                            ),
                          ),
                          Obx(
                            () => Visibility(
                              visible: _ordersController.selectedModel.value.isEmpty && submitted,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12, top: 5),
                                child: Text(
                                  'Please select a model',
                                  style: TextStyle(color: Colors.red, fontSize: 12),
                                ),
                              ),
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
                            controller: _ordersController.year.value,
                            fillColor: Colors.grey[200],
                            hintText: 'Enter the year',
                            keyboardType: TextInputType.number,
                            maxLength: 4,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a year';
                              }
                            },
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
                            controller: _ordersController.engineDisplacement.value,
                            fillColor: Colors.grey[200],
                            hintText: 'Enter the engine displacement',
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter the engine displacement';
                              }
                            },
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
                            controller: _ordersController.numberOfDoors.value,
                            fillColor: Colors.grey[200],
                            hintText: 'Enter the number of doors',
                            keyboardType: TextInputType.number,
                            maxLength: 4,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter the number of doors';
                              }
                            },
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
                            value: _ordersController.selectedFuel.value,
                            choiceItems: _ordersController.fuelOptions,
                            onChange: (state) => _ordersController.setFuel(state.value),
                            hasError: _ordersController.selectedFuel.value.isEmpty && submitted,
                          ),
                          Visibility(
                            visible: _ordersController.selectedFuel.value.isEmpty && submitted,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12, top: 5),
                              child: Text(
                                'Please select a fuel type',
                                style: TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          GradientButton(
                            text: 'Create order',
                            onPressed: () {
                              setState(() => submitted = true);
                              if (_formKey.currentState.validate() &&
                                  _ordersController.selectedBrand.value.isNotEmpty &&
                                  _ordersController.selectedModel.value.isNotEmpty &&
                                  _ordersController.selectedFuel.value.isNotEmpty) {
                                FocusScope.of(context).unfocus();
                                _ordersController.createOrder(images: imagesUrl);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget selectImage() {
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

  Widget selectedImages() {
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
                    return images.length < 5
                        ? Obx(
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
