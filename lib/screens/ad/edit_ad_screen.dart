import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:octo_image/octo_image.dart';
import 'package:procura_online/controllers/edit_ad_controller.dart';
import 'package:procura_online/widgets/gradient_button.dart';
import 'package:procura_online/widgets/select_option.dart';
import 'package:procura_online/widgets/text_input.dart';

class EditAdScreen extends StatefulWidget {
  @override
  _EditAdScreenState createState() => _EditAdScreenState();
}

class _EditAdScreenState extends State<EditAdScreen> {
  final EditAdController _editAdController = Get.put(EditAdController());
  final _formKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
  }

  bool submitted = false;

  List<File> images = List<File>();
  List<String> imagesToRemove = List<String>();

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
        setState(() => images.addAll(limitedSelect));
      } else {
        setState(() => images.addAll(files));
      }
      if (images.length >= 5) {
        setState(() => images = images.sublist(0, 5));
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 1),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
    );
    if (picked != null) {
      var date = DateTime.parse(picked.toString());
      _editAdController.registeredDate.value = date.toString();
      _editAdController.formattedRegisteredDate.value = '${date.day}/${date.month}/${date.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ad'),
        elevation: 0,
      ),
      body: GetX<EditAdController>(
          init: _editAdController,
          builder: (_) {
            if (_.isLoading) {
              return LinearProgressIndicator();
            }
            return ModalProgressHUD(
              inAsyncCall: _editAdController.isSaving,
              child: SingleChildScrollView(
                child: _editAdController.isAdEdited
                    ? Padding(
                        padding: EdgeInsets.only(top: Get.size.height / 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SvgPicture.asset('assets/images/check.svg', width: 150),
                            SizedBox(height: 10),
                            Text('Your ad has been edited successfully.', textAlign: TextAlign.center),
                          ],
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          loadImages(),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Form(
                              key: _formKey,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                    controller: _.title.value,
                                    fillColor: Colors.grey[200],
                                    hintText: 'Enter the title of your ad',
                                    textCapitalization: TextCapitalization.sentences,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter a title';
                                      }
                                    },
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
                                    controller: _.description.value,
                                    fillColor: Colors.grey[200],
                                    hintText: 'Enter the description of the item',
                                    textCapitalization: TextCapitalization.sentences,
                                    maxLines: 5,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter a description';
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
                                      isLoading: _.isLoadingBrands,
                                      placeholder: 'Select one',
                                      modalTitle: 'Brands',
                                      selectText: 'Select a brand',
                                      value: _.selectedBrand.value,
                                      choiceItems: _.brands,
                                      onChange: (state) => _.setBrand(state.value),
                                      hasError: _.selectedBrand.value.isEmpty && submitted,
                                    ),
                                  ),
                                  Obx(
                                    () => Visibility(
                                      visible: _.selectedBrand.value.isEmpty && submitted,
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
                                      isLoading: _.isLoadingModels,
                                      isDisabled: _.selectedBrand.value == '',
                                      placeholder: 'Select one',
                                      modalTitle: 'Models',
                                      selectText: 'Select a model',
                                      value: _.selectedModel.value,
                                      choiceItems: _.models,
                                      onChange: (state) => _.setModel(state.value),
                                      hasError: _.selectedModel.value.isEmpty && submitted,
                                    ),
                                  ),
                                  Obx(
                                    () => Visibility(
                                      visible: _.selectedModel.value.isEmpty && submitted,
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
                                    controller: _.year.value,
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
                                    'Color',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  SelectOption(
                                    modalTitle: 'Color',
                                    selectText: 'Select a color',
                                    value: _.selectedColor.value,
                                    choiceItems: _.colorOptions,
                                    onChange: (state) => _.setColor(state.value),
                                    hasError: _.selectedColor.value.isEmpty && submitted,
                                  ),
                                  Visibility(
                                    visible: _.selectedColor.value.isEmpty && submitted,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 12, top: 5),
                                      child: Text(
                                        'Please select a color',
                                        style: TextStyle(color: Colors.red, fontSize: 12),
                                      ),
                                    ),
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
                                    controller: _.engineDisplacement.value,
                                    fillColor: Colors.grey[200],
                                    hintText: 'Enter the engine displacement',
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter the engine displacement';
                                      }
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'Engine power',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  CustomTextInput(
                                    controller: _.enginePower.value,
                                    fillColor: Colors.grey[200],
                                    hintText: 'Enter the engine power',
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter the engine power';
                                      }
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'Transmission',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  SelectOption(
                                    modalTitle: 'Transmission Type',
                                    selectText: 'Select a transmission type',
                                    value: _.selectedTransmission.value,
                                    choiceItems: _.transmissionOptions,
                                    onChange: (state) => _.setTransmission(state.value),
                                    hasError: _.selectedTransmission.value.isEmpty && submitted,
                                  ),
                                  Visibility(
                                    visible: _.selectedTransmission.value.isEmpty && submitted,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 12, top: 5),
                                      child: Text(
                                        'Please select a transmission type',
                                        style: TextStyle(color: Colors.red, fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'Milage',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  CustomTextInput(
                                    controller: _.miliage.value,
                                    fillColor: Colors.grey[200],
                                    hintText: 'Enter the miliage',
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter the miliage';
                                      }
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'Number of seats',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  CustomTextInput(
                                    controller: _.numberOfSeats.value,
                                    fillColor: Colors.grey[200],
                                    hintText: 'Enter the number of seats',
                                    keyboardType: TextInputType.number,
                                    maxLength: 4,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter the number of seats';
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
                                    controller: _.numberOfDoors.value,
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
                                    value: _.selectedFuel.value,
                                    choiceItems: _.fuelOptions,
                                    onChange: (state) => _.setFuel(state.value),
                                    hasError: _.selectedFuel.value.isEmpty && submitted,
                                  ),
                                  Visibility(
                                    visible: _.selectedFuel.value.isEmpty && submitted,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 12, top: 5),
                                      child: Text(
                                        'Please select a fuel type',
                                        style: TextStyle(color: Colors.red, fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'Condition',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  SelectOption(
                                    modalTitle: 'Condition',
                                    selectText: 'Select a condition',
                                    value: _.selectedCondition.value,
                                    choiceItems: _.conditionOptions,
                                    onChange: (state) => _.setCondition(state.value),
                                    hasError: _.selectedCondition.value.isEmpty && submitted,
                                  ),
                                  Visibility(
                                    visible: _.selectedCondition.value.isEmpty && submitted,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 12, top: 5),
                                      child: Text(
                                        'Please select a condition',
                                        style: TextStyle(color: Colors.red, fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'Price',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  CustomTextInput(
                                    controller: _.price.value,
                                    fillColor: Colors.grey[200],
                                    hintText: 'Enter the price',
                                    keyboardType: TextInputType.number,
                                    maxLength: 8,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter a price';
                                      }
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'Negotiable',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  SelectOption(
                                    modalTitle: 'Negotiable',
                                    selectText: 'Is negotiable?',
                                    value: _.selectedNegotiable.value,
                                    choiceItems: _.negotiableOptions,
                                    onChange: (state) => _.setNegotiable(state.value),
                                    hasError: _.selectedNegotiable.value.isEmpty && submitted,
                                  ),
                                  Visibility(
                                    visible: _.selectedNegotiable.value.isEmpty && submitted,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 12, top: 5),
                                      child: Text(
                                        'Please select if is negotiable',
                                        style: TextStyle(color: Colors.red, fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'Registered date',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: () => _selectDate(context),
                                    child: CustomTextInput(
                                      enabled: false,
                                      fillColor: Colors.grey[200],
                                      hintText: _.formattedRegisteredDate.value.toString(),
                                      keyboardType: TextInputType.number,
                                      suffixIcon: Icon(Icons.date_range),
                                      maxLength: 8,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  GradientButton(
                                    text: 'Save modifications',
                                    onPressed: () {
                                      setState(() => submitted = true);
                                      if (_formKey.currentState.validate() &&
                                          _.selectedBrand.value.isNotEmpty &&
                                          _.selectedModel.value.isNotEmpty &&
                                          _.selectedColor.value.isNotEmpty &&
                                          _.selectedFuel.value.isNotEmpty) {
                                        FocusScope.of(context).unfocus();
                                        _editAdController.edit(photos: images, photosToRemove: imagesToRemove);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            );
          }),
    );
  }

  Widget loadImages() {
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
                  ListView.builder(
                    itemCount: _editAdController.product?.photos?.original?.entries?.length ?? 0,
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> entry = _editAdController.product.photos.original;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(
                            children: [
                              SizedBox(
                                width: 250,
                                height: 200,
                                child: OctoImage(
                                  image: CachedNetworkImageProvider(entry.values.elementAt(index)),
                                  placeholderBuilder: OctoPlaceholder.circularProgressIndicator(),
                                  errorBuilder: OctoError.icon(color: Colors.grey[400]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      imagesToRemove.add(entry.keys.elementAt(index));
                                      entry.removeWhere((key, value) => value == entry.values.elementAt(index));
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
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length + 1,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      Map<String, dynamic> entry = _editAdController.product?.photos?.original ?? {"": ""};
                      if (index == images.length) {
                        return images.length + entry.length < 5
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
                                        Text('Select a picture'),
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
