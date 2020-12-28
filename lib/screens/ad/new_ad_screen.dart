import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:procura_online/controllers/new_ad_controller.dart';
import 'package:procura_online/widgets/gradient_button.dart';
import 'package:procura_online/widgets/select_option.dart';
import 'package:procura_online/widgets/text_input.dart';
import 'package:smart_select/smart_select.dart';

class NewAdScreen extends StatefulWidget {
  @override
  _NewAdScreenState createState() => _NewAdScreenState();
}

class _NewAdScreenState extends State<NewAdScreen> {
  final NewAdController _newAdController = Get.put(NewAdController());

  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _year = TextEditingController();
  final TextEditingController _engineDisplacement = TextEditingController();
  final TextEditingController _enginePower = TextEditingController();
  final TextEditingController _miliage = TextEditingController();
  final TextEditingController _numberOfSeats = TextEditingController();
  final TextEditingController _numberOfDoors = TextEditingController();
  final TextEditingController _price = TextEditingController();

  @override
  initState() {
    var date = DateTime.parse(selectedDate.toString());
    formattedDate = '${date.year}-${date.month}-${date.day}';
    super.initState();
  }

  List<File> images = List<File>();

  String condition = 'new';
  int conditionId = 1;

  String transmission = 'manual';
  int transmissionId = 1;

  String negotiable = '1';
  int negotiableId = 1;

  void selectImages() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path)).toList();

      if (files.length > 5) {
        List<File> limitedSelect = files.sublist(0, 5);
        setState(() => images = limitedSelect);
      } else {
        setState(() => images = files);
      }
    } else {
      // User canceled the picker
    }
  }

  String selectedColor = '';
  String selectedFuel = '';

  List<S2Choice<String>> colorOptions = [
    S2Choice<String>(value: 'Black', title: 'Black'),
    S2Choice<String>(value: 'Blue', title: 'Blue'),
    S2Choice<String>(value: 'Green', title: 'Green'),
    S2Choice<String>(value: 'White', title: 'White'),
    S2Choice<String>(value: 'Grey', title: 'Grey'),
  ];

  List<S2Choice<String>> fuelOptions = [
    S2Choice<String>(value: 'gas', title: 'Gasoline'),
    S2Choice<String>(value: 'diesel', title: 'Diesel'),
    S2Choice<String>(value: 'hybrid', title: 'Hybrid'),
    S2Choice<String>(value: 'electric', title: 'Electric'),
  ];

  DateTime selectedDate = DateTime.now();
  String formattedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context, initialDate: selectedDate, firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      var date = DateTime.parse(picked.toString());
      setState(() {
        selectedDate = picked;
        formattedDate = '${date.year}-${date.month}-${date.day}';
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
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: _newAdController.isCreatingAd,
          child: SingleChildScrollView(
            child: _newAdController.isAdCreated
                ? Padding(
                    padding: EdgeInsets.only(top: Get.size.height / 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SvgPicture.asset('assets/images/check.svg', width: 150),
                        SizedBox(height: 10),
                        Text('Your ad has been published successfully.', textAlign: TextAlign.center),
                      ],
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Visibility(
                        visible: images.length == 0 ? true : false,
                        child: GestureDetector(
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
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
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
                              controller: _title,
                              fillColor: Colors.grey[200],
                              hintText: 'Enter the title of your ad',
                              textCapitalization: TextCapitalization.sentences,
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
                              controller: _description,
                              fillColor: Colors.grey[200],
                              hintText: 'Enter the description of the item',
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
                              'Color',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            SelectOption(
                              modalTitle: 'Color',
                              selectText: 'Select a color',
                              value: selectedColor,
                              choiceItems: colorOptions,
                              onChange: (state) => setState(() => selectedColor = state.value),
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
                              'Engine power',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            CustomTextInput(
                              controller: _enginePower,
                              fillColor: Colors.grey[200],
                              hintText: 'Enter the engine power',
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Transmission',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Radio(
                                  visualDensity: VisualDensity.compact,
                                  value: 1,
                                  groupValue: transmissionId,
                                  onChanged: (val) {
                                    setState(() {
                                      transmission = 'manual';
                                      transmissionId = 1;
                                    });
                                  },
                                ),
                                Text('Manual'),
                                Radio(
                                  value: 2,
                                  groupValue: transmissionId,
                                  onChanged: (val) {
                                    setState(() {
                                      transmission = 'auto';
                                      transmissionId = 2;
                                    });
                                  },
                                ),
                                Text('Automatic'),
                              ],
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
                              controller: _miliage,
                              fillColor: Colors.grey[200],
                              hintText: 'Enter the miliage',
                              keyboardType: TextInputType.number,
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
                              controller: _numberOfSeats,
                              fillColor: Colors.grey[200],
                              hintText: 'Enter the number of seats',
                              keyboardType: TextInputType.number,
                              maxLength: 4,
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
                            Text(
                              'Condition',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Radio(
                                  visualDensity: VisualDensity.compact,
                                  value: 1,
                                  groupValue: conditionId,
                                  onChanged: (val) {
                                    setState(() {
                                      condition = 'new';
                                      conditionId = 1;
                                    });
                                  },
                                ),
                                Text('New'),
                                Radio(
                                  value: 2,
                                  groupValue: conditionId,
                                  onChanged: (val) {
                                    setState(() {
                                      condition = 'used';
                                      conditionId = 2;
                                    });
                                  },
                                ),
                                Text('Used'),
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Price',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            CustomTextInput(
                              controller: _price,
                              fillColor: Colors.grey[200],
                              hintText: 'Enter the price',
                              keyboardType: TextInputType.number,
                              maxLength: 8,
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Negotiable',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Radio(
                                  visualDensity: VisualDensity.compact,
                                  value: 1,
                                  groupValue: negotiableId,
                                  onChanged: (val) {
                                    setState(() {
                                      negotiable = '1';
                                      negotiableId = 1;
                                    });
                                  },
                                ),
                                Text('Yes'),
                                Radio(
                                  value: 0,
                                  groupValue: negotiableId,
                                  onChanged: (val) {
                                    setState(() {
                                      negotiable = '0';
                                      negotiableId = 0;
                                    });
                                  },
                                ),
                                Text('No'),
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Registered date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                SizedBox(
                                  width: 200,
                                  height: 40,
                                  child: OutlineButton(
                                    child: Text('Select a date'),
                                    onPressed: () => _selectDate(context),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(formattedDate),
                              ],
                            ),
                            SizedBox(height: 20),
                            GradientButton(
                              text: 'Publish ads',
                              onPressed: () => _newAdController.create(
                                photos: images,
                                title: _title.text,
                                description: _description.text,
                                brand: _newAdController.selectedBrand,
                                model: _newAdController.selectedModel,
                                year: _year.text,
                                color: selectedColor,
                                engineDisplacement: _engineDisplacement.text,
                                enginePower: _enginePower.text,
                                transmission: transmission,
                                miliage: _miliage.text,
                                numberOfSeats: _numberOfSeats.text,
                                numberOfDoors: _numberOfDoors.text,
                                fuelType: selectedFuel,
                                condition: condition,
                                price: _price.text,
                                negotiable: negotiable,
                                registered: formattedDate,
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
}
