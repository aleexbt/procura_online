import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:octo_image/octo_image.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:procura_online/widgets/gradient_button.dart';
import 'package:procura_online/widgets/select_option.dart';
import 'package:procura_online/widgets/text_input.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final UserController _userController = Get.find();
  final _formKey = GlobalKey<FormState>();

  int district;
  int city;

  var coverImage;
  var logoImage;

  bool submitted = false;

  @override
  void initState() {
    getUserLocation();
    super.initState();
  }

  void selectCover() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    if (result != null) {
      File file = result.paths.map((path) => File(path)).first;
      _userController.uploadCover(file);
    }
  }

  void selectLogo() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    if (result != null) {
      File file = result.paths.map((path) => File(path)).first;
      _userController.uploadLogo(file);
    }
  }

  void getUserLocation() async {
    _userController.getDistricts();
    if (_userController.userData?.districtId != null) {
      setState(() {
        district = _userController.userData.districtId;
      });
      _userController.getCities(_userController.userData.districtId);
    }

    if (_userController.userData?.cityId != null) {
      setState(() {
        city = _userController.userData.cityId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetX<UserController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text('Informações da conta'),
          elevation: 0,
        ),
        body: ModalProgressHUD(
          inAsyncCall: _userController.isSaving,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 220,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: GestureDetector(
                                  onTap: () => selectCover(),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: OctoImage(
                                      image: CachedNetworkImageProvider(_userController.userData.cover.url),
                                      placeholderBuilder: OctoPlaceholder.blurHash('LAI#u-9XM[D\$GdIU4oIA-sWFxwRl'),
                                      errorBuilder: OctoError.icon(color: Colors.grey[400]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 40),
                            ],
                          ),
                          Positioned(
                            bottom: 50,
                            right: 10,
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                          Positioned(
                            top: 100,
                            child: SizedBox(
                              width: 160,
                              height: 160,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(color: Colors.white, width: 4),
                                ),
                                child: GestureDetector(
                                  onTap: () => selectLogo(),
                                  child: ClipOval(
                                    child: Stack(
                                      children: [
                                        OctoImage(
                                          width: 160,
                                          height: 160,
                                          image: CachedNetworkImageProvider(_userController.userData.logo.thumbnail),
                                          placeholderBuilder: OctoPlaceholder.blurHash('LAI#u-9XM[D\$GdIU4oIA-sWFxwRl'),
                                          errorBuilder: OctoError.icon(color: Colors.grey[400]),
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          bottom: 8,
                                          left: 0,
                                          right: 0,
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Nome',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomTextInput(
                        controller: _.name.value..text = _.userData?.name,
                        fillColor: Colors.grey[200],
                        hintText: 'Informe um nome',
                        textCapitalization: TextCapitalization.sentences,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Campo de preenchimento obrigatório.';
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Email',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomTextInput(
                        enabled: false,
                        controller: _.email.value..text = _.userData?.email,
                        fillColor: Colors.grey[200],
                        hintText: 'Informe um email',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Campo de preenchimento obrigatório.';
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Telefone',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => CustomTextInput(
                          enabled: false,
                          controller: _.phone.value..text = _.userData?.phone,
                          fillColor: Colors.grey[200],
                          hintText: 'Informe um telefone',
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Campo de preenchimento obrigatório.';
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Nome da empresa',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => CustomTextInput(
                          controller: _.company.value..text = _.userData?.company,
                          fillColor: Colors.grey[200],
                          hintText: 'Informe o nome da empresa',
                          textCapitalization: TextCapitalization.sentences,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Campo de preenchimento obrigatório.';
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Tipo de conta',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      SelectOption(
                        modalTitle: 'Tipo de conta',
                        selectText: 'Selecionar opção',
                        value: _.selectedAccountType.value,
                        choiceItems: _.accountTypeOptions,
                        onChange: (state) => _.selectedAccountType(state.value),
                      ),
                      Visibility(
                        visible: _.selectedAccountType.value.isEmpty && submitted,
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
                        'Distrito',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => SelectOption(
                          isLoading: _.isLoadingDistricts,
                          modalTitle: 'Distrito',
                          selectText: 'Selecionar opção',
                          value: district,
                          choiceItems: _.districts,
                          onChange: (state) => [setState(() => district = state.value), _.getCities(state.value)],
                          hasError: district == null,
                        ),
                      ),
                      Visibility(
                        visible: district == null && submitted,
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
                        'Localidade',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => SelectOption(
                          isLoading: _.isLoadingCities,
                          modalTitle: 'Localidade',
                          selectText: 'Selecionar opção',
                          value: city,
                          choiceItems: _.cities,
                          onChange: (state) => setState(() => city = state.value),
                          hasError: _.userData.cityId == null,
                        ),
                      ),
                      Visibility(
                        visible: city == null && submitted,
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
                        'Endereço',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => CustomTextInput(
                          controller: _.address.value..text = _.userData?.address,
                          fillColor: Colors.grey[200],
                          hintText: 'Informe um endereço',
                          textCapitalization: TextCapitalization.sentences,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Campo de preenchimento obrigatório.';
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Código postal',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => CustomTextInput(
                          controller: _.postcode.value..text = _.userData?.postcode,
                          fillColor: Colors.grey[200],
                          hintText: 'Informe um código postal',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Campo de preenchimento obrigatório.';
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      GradientButton(
                        text: 'Guardar',
                        onPressed: () {
                          setState(() => submitted = true);

                          if (_formKey.currentState.validate() &&
                              _.selectedAccountType.value.isNotEmpty &&
                              district != null &&
                              city != null) {
                            FocusScope.of(context).unfocus();
                            _userController.updateProfile(district: district, city: city);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
