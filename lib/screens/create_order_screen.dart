import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:procura_online/controllers/orders_controller.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:procura_online/models/upload_media_model.dart';
import 'package:procura_online/widgets/gradient_button.dart';
import 'package:procura_online/widgets/select_option.dart';
import 'package:procura_online/widgets/select_option_logo.dart';
import 'package:procura_online/widgets/text_input.dart';

class CreateOrderScreen extends StatefulWidget {
  @override
  _CreateOrderScreenState createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  final OrdersController _ordersController = Get.find();
  final UserController _userController = Get.find();
  final _formKey = GlobalKey<FormState>();
  FocusNode mainNode;

  @override
  initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) => _userController.checkCreateOrderPermission());
    _userController.checkSubscription('orders-create');
    mainNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _ordersController.resetFields();
    super.dispose();
  }

  bool submitted = false;
  List<File> images = List<File>.empty(growable: true);
  List<String> imagesUrl = List<String>.empty(growable: true);

  void selectImages() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.image,
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

  void selectMore() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path)).toList();
      _ordersController.setImages(files);

      for (File photo in files) {
        _ordersController.currentUploadImage.value = photo.path;
        UploadMedia media = await _ordersController.mediaUpload(photo);
        if (media != null) {
          _ordersController.setImagesUrl(media.name);
        } else {
          _ordersController.removeImage(photo);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(mainNode);
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar pedido'),
        elevation: 0,
      ),
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: _ordersController.isPublishingOrder || _userController.isCheckingSubscription,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Marca',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Obx(
                              () => SelectOptionLogo(
                                enableFilter: true,
                                isLoading: _ordersController.isLoadingBrands,
                                modalTitle: 'Marca',
                                selectText: 'Selecionar marca',
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
                                    'Campo de preenchimento obrigatório.',
                                    style: TextStyle(color: Colors.red, fontSize: 12),
                                  ),
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
                            Obx(
                              () => SelectOption(
                                enableFilter: true,
                                isLoading: _ordersController.isLoadingModels,
                                isDisabled: _ordersController.selectedBrand.value == '',
                                modalTitle: 'Modelo',
                                selectText: 'Selecionar modelo',
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
                                    'Campo de preenchimento obrigatório.',
                                    style: TextStyle(color: Colors.red, fontSize: 12),
                                  ),
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
                              controller: _ordersController.year.value,
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
                              'Combustível (opcional)',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            SelectOption(
                              modalTitle: 'Combustível',
                              selectText: 'Selecionar combustível',
                              value: _ordersController.selectedFuel.value,
                              choiceItems: _ordersController.fuelOptions,
                              onChange: (state) => _ordersController.setFuel(state.value),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Potência (opcional)',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            CustomTextInput(
                              controller: _ordersController.engineDisplacement.value,
                              fillColor: Colors.grey[200],
                              hintText: 'Informe a potência',
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Nº de portas (opcional)',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            CustomTextInput(
                              controller: _ordersController.numberOfDoors.value,
                              fillColor: Colors.grey[200],
                              hintText: 'Informe o número de portas',
                              keyboardType: TextInputType.number,
                              maxLength: 2,
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Referência (opcional)',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            CustomTextInput(
                              controller: _ordersController.mpn.value,
                              fillColor: Colors.grey[200],
                              hintText: 'Informe uma referência',
                              textCapitalization: TextCapitalization.sentences,
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Pedido',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            CustomTextInput(
                              controller: _ordersController.note.value,
                              fillColor: Colors.grey[200],
                              hintText: 'Detalhes do seu pedido',
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
                            GradientButton(
                              text: 'Enviar pedido',
                              onPressed: !_userController.listOrdersPermission
                                  ? null
                                  : () {
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
      ),
    );
  }

  Widget gallery() {
    return Obx(
      () => _ordersController.images.length > 0
          ? ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: _ordersController.images.length,
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
                            File(_ordersController.images[index].path),
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
                              onTap: () => _ordersController.removeImageByIndex(index),
                              child: Icon(Icons.delete, color: Colors.red)),
                        ),
                        Obx(
                          () => Visibility(
                            visible: _ordersController.isUploadingImage &&
                                _ordersController.currentUploadImage.value == _ordersController.images[index].path,
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
                        'ADICIONAR FOTOS',
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
