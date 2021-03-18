import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:list_tile_more_customizable/list_tile_more_customizable.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:octo_image/octo_image.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:procura_online/controllers/edit_ad_controller.dart';
import 'package:procura_online/models/product_model.dart';
import 'package:procura_online/models/upload_media_model.dart';
import 'package:procura_online/widgets/gradient_button.dart';
import 'package:procura_online/widgets/select_option.dart';
import 'package:procura_online/widgets/select_option_logo.dart';
import 'package:procura_online/widgets/text_input.dart';

class EditAdScreen extends StatefulWidget {
  @override
  _EditAdScreenState createState() => _EditAdScreenState();
}

class _EditAdScreenState extends State<EditAdScreen> {
  final Product product = Get.arguments;
  final EditAdController _editAdController = Get.put(EditAdController());
  final _formKey = GlobalKey<FormState>();
  FocusNode mainNode;

  @override
  initState() {
    if (_editAdController.product?.gallery?.original != null && _editAdController.product.gallery.original.length > 0) {
      gallery = Map.from(_editAdController.product?.gallery?.original);
    }
    // if (_editAdController.product?.mainPhoto?.bigThumb != null) {
    //   mainImage = _editAdController.product.mainPhoto.bigThumb;
    // }
    mainNode = FocusNode();
    super.initState();
  }

  bool submitted = false;

  List<File> images = List<File>.empty(growable: true);
  Map<String, dynamic> gallery;
  List<String> imagesToRemove = List<String>.empty(growable: true);

  void selectMainPhoto() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    if (result != null) {
      File file = result.paths.map((path) => File(path)).first;

      _editAdController.setMainImage(file.path);
      _editAdController.currentUploadImage.value = _editAdController.mainPhoto.value;

      UploadMedia mainPhoto = await _editAdController.mediaUpload(file);
      if (mainPhoto != null) {
        _editAdController.setMainImageUrl(mainPhoto.name);
      } else {
        setState(() {
          _editAdController.mainPhoto.value = '';
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
      _editAdController.setImages(files);

      for (File photo in files) {
        _editAdController.currentUploadImage.value = photo.path;
        UploadMedia media = await _editAdController.mediaUpload(photo);
        if (media != null) {
          _editAdController.setImagesUrl(media.name);
        } else {
          _editAdController.removeImage(photo);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar anúncio'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => Get.bottomSheet(
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTileMoreCustomizable(
                          leading: Icon(
                            CupertinoIcons.trash,
                            color: Colors.black,
                          ),
                          title: Text(
                            'Excluir anúncio',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          horizontalTitleGap: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onTap: (_) => _editAdController.delete(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              ),
            ),
          ),
        ],
      ),
      body: GetX<EditAdController>(builder: (_) {
        if (_.isLoading) {
          return LinearProgressIndicator();
        }
        FocusScope.of(context).requestFocus(mainNode);
        return ModalProgressHUD(
          inAsyncCall: _editAdController.isSaving,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                              hasError: _.selectedBrand.value.isBlank && submitted,
                            ),
                            Visibility(
                              visible: _.selectedBrand.value.isBlank && submitted,
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
                              hasError: _.selectedModel.value.isBlank && submitted,
                            ),
                            Visibility(
                              visible: _.selectedModel.value.isBlank && submitted,
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
                              hasError: _.selectedColor.value.isBlank && submitted,
                            ),
                            Visibility(
                              visible: _.selectedColor.value.isBlank && submitted,
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
                              hasError: _.selectedTransmission.value.isBlank && submitted,
                            ),
                            Visibility(
                              visible: _.selectedTransmission.value.isBlank && submitted,
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
                              'Número de portas',
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
                              hasError: _.selectedFuel.value.isBlank && submitted,
                            ),
                            Visibility(
                              visible: _.selectedFuel.value.isBlank && submitted,
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
                              hasError: _.selectedCondition.value.isBlank && submitted,
                            ),
                            Visibility(
                              visible: _.selectedCondition.value.isBlank && submitted,
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
                              hasError: _.selectedNegotiable.value.isBlank && submitted,
                            ),
                            Visibility(
                              visible: _.selectedNegotiable.value.isBlank && submitted,
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
                                  locale: LocaleType.pt,
                                  onConfirm: (date) {
                                    _editAdController.registeredDate.value = date.toString();
                                    _editAdController.formattedRegisteredDate.value =
                                        '${date.day}/${date.month}/${date.year}';
                                  },
                                  currentTime: _editAdController.registeredDate.value != null
                                      ? DateTime.tryParse(_editAdController.registeredDate.value)
                                      : DateTime.now(),
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
                            SizedBox(height: 20),
                            GradientButton(
                              text: 'Guardar',
                              onPressed: () {
                                print(_.selectedColor.value);
                                print(_.selectedFuel.value);
                                print(_.selectedCondition.value);
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
                                  _editAdController.edit(photos: images, photosToRemove: imagesToRemove);
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
        );
      }),
    );
  }

  Widget mainPhotoNetwork() {
    return Obx(
      () => !_editAdController.mainPhotoChanged.value && _editAdController.product.mainPhoto.bigThumb.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  SizedBox(
                    width: 200,
                    height: 180,
                    child: OctoImage(
                      image: CachedNetworkImageProvider(_editAdController.product.mainPhoto.bigThumb),
                      placeholderBuilder: OctoPlaceholder.circularProgressIndicator(),
                      errorBuilder: OctoError.icon(color: Colors.grey[400]),
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => _editAdController.mainPhotoChanged.value = true,
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }

  Widget photos() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        // height: 140,
        child: CustomScrollView(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Obx(
                    () => !_editAdController.mainPhotoChanged.value ? mainPhotoNetwork() : mainPhotoChanged(),
                  );
                },
                childCount: 1,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return networkGallery();
                },
                childCount: 1,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return localGallery();
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
                        'ADD MAIS',
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

  Widget mainPhotoChanged() {
    return Obx(
      () => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: _editAdController.mainPhoto.value.isNotEmpty
            ? Stack(
                children: [
                  SizedBox(
                    width: 200,
                    height: 180,
                    child: Image.file(
                      File(_editAdController.mainPhoto.value),
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        _editAdController.mainPhoto.value = '';
                        _editAdController.mainPhotoUrl.value = '';
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: _editAdController.isUploadingImage &&
                          _editAdController.currentUploadImage.value == _editAdController.mainPhoto.value,
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
                              percent: _editAdController.uploadImageProgress.value,
                              center: Text(
                                '${(_editAdController.uploadImageProgress.value * 100).round()}%',
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
      ),
    );
  }

  Widget networkGallery() {
    return gallery != null
        ? ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: gallery.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 180,
                        child: OctoImage(
                          image: CachedNetworkImageProvider(gallery.values.elementAt(index)),
                          placeholderBuilder: OctoPlaceholder.circularProgressIndicator(),
                          errorBuilder: OctoError.icon(color: Colors.grey[400]),
                          width: 200,
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              imagesToRemove.add(gallery.keys.elementAt(index));
                              gallery.removeWhere((key, value) => value == gallery.values.elementAt(index));
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
          )
        : Container();
  }

  Widget localGallery() {
    return Obx(
      () => _editAdController.images.length > 0
          ? ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: _editAdController.images.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 200,
                          height: 180,
                          child: Image.file(
                            File(_editAdController.images[index].path),
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
                              onTap: () => _editAdController.removeImageByIndex(index),
                              child: Icon(Icons.delete, color: Colors.red)),
                        ),
                        Obx(
                          () => Visibility(
                            visible: _editAdController.isUploadingImage &&
                                _editAdController.currentUploadImage.value == _editAdController.images[index].path,
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
                                    percent: _editAdController.uploadImageProgress.value,
                                    center: Text(
                                      '${(_editAdController.uploadImageProgress.value * 100).round()}%',
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
}
