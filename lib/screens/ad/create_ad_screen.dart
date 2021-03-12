import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:procura_online/controllers/create_ad_controller.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:procura_online/models/upload_media_model.dart';
import 'package:procura_online/widgets/gradient_button.dart';
import 'package:procura_online/widgets/select_option.dart';
import 'package:procura_online/widgets/select_option_logo.dart';
import 'package:procura_online/widgets/text_input.dart';

class CreateAdScreen extends StatefulWidget {
  @override
  _CreateAdScreenState createState() => _CreateAdScreenState();
}

class _CreateAdScreenState extends State<CreateAdScreen> {
  final CreateAdController _createAdController = Get.put(CreateAdController());
  final UserController _userController = Get.find();
  final _formKey = GlobalKey<FormState>();
  FocusNode mainNode;

  @override
  initState() {
    var date = DateTime.parse(DateTime.now().toString());
    _createAdController.registeredDate.value = date.toString();
    _createAdController.formattedRegisteredDate.value = '${date.day}/${date.month}/${date.year}';
    _userController.checkSubscription('listings');
    mainNode = FocusNode();
    super.initState();
  }

  bool submitted = false;

  void selectMainPhoto() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    if (result != null) {
      File file = result.paths.map((path) => File(path)).first;

      _createAdController.setMainImage(file.path);
      _createAdController.currentUploadImage.value = _createAdController.mainPhoto.value;

      UploadMedia mainPhoto = await _createAdController.mediaUpload(file);
      if (mainPhoto != null) {
        _createAdController.setMainImageUrl(mainPhoto.name);
      } else {
        setState(() {
          _createAdController.mainPhoto.value = '';
        });
      }
    }
  }

  void selectMore() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path)).toList();
      _createAdController.setImages(files);

      for (File photo in files) {
        _createAdController.currentUploadImage.value = photo.path;
        UploadMedia media = await _createAdController.mediaUpload(photo);
        if (media != null) {
          _createAdController.setImagesUrl(media.name);
        } else {
          _createAdController.removeImage(photo);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar anúncio'),
        elevation: 0,
      ),
      body: GetX<CreateAdController>(builder: (_) {
        FocusScope.of(context).requestFocus(mainNode);
        return ModalProgressHUD(
          inAsyncCall: _.isSaving || _userController.isCheckingSubscription || _.isCheckingSubscription,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: photos(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Focus(
                      focusNode: mainNode,
                      child: Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Categoria',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            SelectOption(
                              isLoading: _.isLoadingCategories,
                              modalTitle: 'Categoria',
                              selectText: 'Selecionar categoria',
                              value: _.selectedCategory.value,
                              choiceItems: _.categories,
                              onChange: (state) => _.setCategory(state.value),
                              hasError: _.selectedCategory.value.isEmpty && submitted,
                            ),
                            Visibility(
                              visible: _.selectedCategory.value.isEmpty && submitted,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12, top: 5),
                                child: Text(
                                  'Campo de preenchimento obrigatório.',
                                  style: TextStyle(color: Colors.red, fontSize: 12),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Subcategoria',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            SelectOption(
                              isLoading: _.isLoadingSubCategories,
                              isDisabled: _.selectedCategory.value == '',
                              modalTitle: 'Subcategoria',
                              selectText: 'Selecionar subcategoria',
                              value: _.selectedSubCategory.value,
                              choiceItems: _.subcategories,
                              onChange: (state) => _.setSubCategory(state.value),
                              hasError: _.selectedSubCategory.value.isEmpty && submitted,
                            ),
                            Visibility(
                              visible: _.selectedSubCategory.value.isEmpty && submitted,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12, top: 5),
                                child: Text(
                                  'Campo de preenchimento obrigatório.',
                                  style: TextStyle(color: Colors.red, fontSize: 12),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Título',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            CustomTextInput(
                              controller: _.title.value,
                              fillColor: Colors.grey[200],
                              hintText: 'Escolha um título para seu anúncio',
                              textCapitalization: TextCapitalization.sentences,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Campo de preenchimento obrigatório.';
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Descrição',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            CustomTextInput(
                              controller: _.description.value,
                              fillColor: Colors.grey[200],
                              hintText: 'Informe uma descrição para o item',
                              textCapitalization: TextCapitalization.sentences,
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Campo de preenchimento obrigatório.';
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Marca',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            SelectOptionLogo(
                              enableFilter: true,
                              isLoading: _.isLoadingBrands,
                              modalTitle: 'Marca',
                              selectText: 'Selecionar marca',
                              value: _.selectedBrand.value,
                              choiceItems: _.brands,
                              onChange: (state) => _.setBrand(state.value),
                              hasError: _.selectedBrand.value.isEmpty && submitted,
                            ),
                            Visibility(
                              visible: _.selectedBrand.value.isEmpty && submitted,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12, top: 5),
                                child: Text(
                                  'Campo de preenchimento obrigatório.',
                                  style: TextStyle(color: Colors.red, fontSize: 12),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Modelo',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            SelectOption(
                              enableFilter: true,
                              isLoading: _.isLoadingModels,
                              isDisabled: _.selectedBrand.value == '',
                              modalTitle: 'Modelo',
                              selectText: 'Selecionar modelo',
                              value: _.selectedModel.value,
                              choiceItems: _.models,
                              onChange: (state) => _.setModel(state.value),
                              hasError: _.selectedModel.value.isEmpty && submitted,
                            ),
                            Visibility(
                              visible: _.selectedModel.value.isEmpty && submitted,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12, top: 5),
                                child: Text(
                                  'Campo de preenchimento obrigatório.',
                                  style: TextStyle(color: Colors.red, fontSize: 12),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Ano',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            CustomTextInput(
                              controller: _.year.value,
                              fillColor: Colors.grey[200],
                              hintText: 'Informe o ano',
                              keyboardType: TextInputType.number,
                              maxLength: 4,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Campo de preenchimento obrigatório.';
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Cor',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            SelectOption(
                              modalTitle: 'Cor',
                              selectText: 'Selecionar cor',
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
                                  'Campo de preenchimento obrigatório.',
                                  style: TextStyle(color: Colors.red, fontSize: 12),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Cilindrada',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            CustomTextInput(
                              controller: _.engineDisplacement.value,
                              fillColor: Colors.grey[200],
                              hintText: 'Informe a cilindrada',
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Campo de preenchimento obrigatório.';
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Potência',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            CustomTextInput(
                              controller: _.enginePower.value,
                              fillColor: Colors.grey[200],
                              hintText: 'Informe a potência',
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Campo de preenchimento obrigatório.';
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Transmissão',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            SelectOption(
                              modalTitle: 'Transmissão',
                              selectText: 'Selecionar transmissão',
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
                                  'Campo de preenchimento obrigatório.',
                                  style: TextStyle(color: Colors.red, fontSize: 12),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Quilómetros',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            CustomTextInput(
                              controller: _.miliage.value,
                              fillColor: Colors.grey[200],
                              hintText: 'Informe os quilómetros',
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Campo de preenchimento obrigatório.';
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Lotação',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            CustomTextInput(
                              controller: _.numberOfSeats.value,
                              fillColor: Colors.grey[200],
                              hintText: 'Informe a lotação',
                              keyboardType: TextInputType.number,
                              maxLength: 4,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Campo de preenchimento obrigatório.';
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Nº de portas',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            CustomTextInput(
                              controller: _.numberOfDoors.value,
                              fillColor: Colors.grey[200],
                              hintText: 'Informe o número de portas',
                              keyboardType: TextInputType.number,
                              maxLength: 4,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Campo de preenchimento obrigatório.';
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Combustível',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            SelectOption(
                              modalTitle: 'Combustível',
                              selectText: 'Selecionar combustível',
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
                                  'Campo de preenchimento obrigatório.',
                                  style: TextStyle(color: Colors.red, fontSize: 12),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Condição',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            SelectOption(
                              modalTitle: 'Condição',
                              selectText: 'Informe a condição',
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
                                  'Campo de preenchimento obrigatório.',
                                  style: TextStyle(color: Colors.red, fontSize: 12),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Preço',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            CustomTextInput(
                              controller: _.price.value,
                              fillColor: Colors.grey[200],
                              hintText: 'Informe o preço',
                              keyboardType: TextInputType.number,
                              maxLength: 8,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Campo de preenchimento obrigatório.';
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Negociável',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            SelectOption(
                              modalTitle: 'Negociável',
                              selectText: 'É negociável?',
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
                                  'Campo de preenchimento obrigatório.',
                                  style: TextStyle(color: Colors.red, fontSize: 12),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Data de registro',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () => {
                                DatePicker.showDatePicker(
                                  context,
                                  showTitleActions: true,
                                  minTime: DateTime(1900, 1, 1),
                                  maxTime: DateTime.now(),
                                  onConfirm: (date) {
                                    _createAdController.registeredDate.value = date.toString();
                                    _createAdController.formattedRegisteredDate.value =
                                        '${date.day}/${date.month}/${date.year}';
                                  },
                                  currentTime:
                                      DateTime.parse(_createAdController.registeredDate.value) ?? DateTime.now(),
                                ),
                              },
                              child: CustomTextInput(
                                enabled: false,
                                fillColor: Colors.grey[200],
                                hintText: _.formattedRegisteredDate.value.toString(),
                                keyboardType: TextInputType.number,
                                suffixIcon: Icon(Icons.date_range),
                                maxLength: 8,
                              ),
                            ),
                            SizedBox(height: 2),
                            Row(
                              children: [
                                Obx(
                                  () => Checkbox(
                                    visualDensity: VisualDensity.compact,
                                    value: _.isFeatured.value,
                                    onChanged: (value) {
                                      _.setFeatured(value);
                                    },
                                  ),
                                ),
                                Text('Colocar em destaque?'),
                              ],
                            ),
                            SizedBox(height: 20),
                            Obx(
                              () => GradientButton(
                                text: 'Publicar',
                                onPressed: !_userController.createAdPermission
                                    ? null
                                    : () {
                                        setState(() => submitted = true);
                                        if (_formKey.currentState.validate() &&
                                            _.selectedCategory.value.isNotEmpty &&
                                            _.selectedSubCategory.value.isNotEmpty &&
                                            _.selectedBrand.value.isNotEmpty &&
                                            _.selectedModel.value.isNotEmpty &&
                                            _.selectedColor.value.isNotEmpty &&
                                            _.selectedTransmission.value.isNotEmpty &&
                                            _.selectedFuel.value.isNotEmpty &&
                                            _.selectedCondition.value.isNotEmpty &&
                                            _.selectedNegotiable.value.isNotEmpty) {
                                          FocusScope.of(context).unfocus();
                                          _createAdController.create();
                                        }
                                      },
                              ),
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
        );
      }),
    );
  }

  Widget mainPhoto() {
    return Obx(
      () => _createAdController.mainPhoto.value.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  SizedBox(
                    width: 200,
                    height: 180,
                    child: Image.file(
                      File(_createAdController.mainPhoto.value),
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => _createAdController.mainPhoto.value = '',
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: _createAdController.isUploadingImage &&
                          _createAdController.currentUploadImage.value == _createAdController.mainPhoto.value,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          width: 200,
                          height: 180,
                          color: Colors.grey.withOpacity(0.8),
                          child: Center(
                            child: CircularPercentIndicator(
                              radius: 60.0,
                              lineWidth: 5.0,
                              percent: _createAdController.uploadImageProgress.value,
                              center: Text(
                                '${(_createAdController.uploadImageProgress.value * 100).round()}%',
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
                  ),
                ],
              ),
            )
          : GestureDetector(
              onTap: selectMainPhoto,
              behavior: HitTestBehavior.translucent,
              child: Container(
                width: 200,
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
                      Text('Foto principal'),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget gallery() {
    return Obx(
      () => _createAdController.images.length > 0
          ? ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: _createAdController.images.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 200,
                          height: 180,
                          child: Image.file(
                            File(_createAdController.images[index].path),
                            width: 200,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () => _createAdController.removeImageByIndex(index),
                              child: Icon(Icons.delete, color: Colors.red)),
                        ),
                        Obx(
                          () => Visibility(
                            visible: _createAdController.isUploadingImage &&
                                _createAdController.currentUploadImage.value == _createAdController.images[index].path,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                width: 200,
                                height: 180,
                                color: Colors.grey.withOpacity(0.8),
                                child: Center(
                                  child: CircularPercentIndicator(
                                    radius: 60.0,
                                    lineWidth: 5.0,
                                    percent: _createAdController.uploadImageProgress.value,
                                    center: Text(
                                      '${(_createAdController.uploadImageProgress.value * 100).round()}%',
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
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Container(),
    );
  }

  Widget photos() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 140,
        child: CustomScrollView(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return mainPhoto();
                },
                childCount: 1,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: gallery(),
                  );
                },
                childCount: 1,
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: selectMore,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo,
                        color: Colors.grey[400],
                        size: 35,
                      ),
                      Text(
                        'ADICIONAR MAIS',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
