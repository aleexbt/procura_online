import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:procura_online/controllers/user_controller.dart';
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

  @override
  void initState() {
    getUserLocation();
    super.initState();
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
          title: Text('Edit profile'),
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.check, color: Colors.black),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  FocusScope.of(context).unfocus();
                  _userController.updateProfile(district: district, city: city);
                }
              },
            ),
          ],
        ),
        body: ModalProgressHUD(
          inAsyncCall: _userController.isSaving,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomTextInput(
                        controller: _.name.value..text = _.userData?.name,
                        fillColor: Colors.grey[200],
                        hintText: 'Enter a name',
                        textCapitalization: TextCapitalization.sentences,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your name';
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
                        hintText: 'Enter an email address',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your email address';
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Phone',
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
                          hintText: 'Enter a phone number',
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Company',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => CustomTextInput(
                          controller: _.company.value..text = _.userData?.company,
                          fillColor: Colors.grey[200],
                          hintText: 'Enter a company name',
                          textCapitalization: TextCapitalization.sentences,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your company name';
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Account type',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      SelectOption(
                        modalTitle: 'Account type',
                        selectText: 'Select an option',
                        value: _.selectedAccountType.value,
                        choiceItems: _.accountTypeOptions,
                        onChange: (state) => _.selectedAccountType(state.value),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'District',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => SelectOption(
                          isLoading: _.isLoadingDistricts,
                          modalTitle: 'District',
                          selectText: 'Select an option',
                          value: district,
                          choiceItems: _.districts,
                          onChange: (state) => [setState(() => district = state.value), _.getCities(state.value)],
                          hasError: district == null,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'City',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => SelectOption(
                          isLoading: _.isLoadingCities,
                          modalTitle: 'Cities',
                          selectText: 'Select an option',
                          value: city,
                          choiceItems: _.cities,
                          onChange: (state) => setState(() => city = state.value),
                          hasError: _.userData.cityId == null,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Address',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => CustomTextInput(
                          controller: _.address.value..text = _.userData?.address,
                          fillColor: Colors.grey[200],
                          hintText: 'Enter an address',
                          textCapitalization: TextCapitalization.sentences,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your address';
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Postcode',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => CustomTextInput(
                          controller: _.postcode.value..text = _.userData?.postcode,
                          fillColor: Colors.grey[200],
                          hintText: 'Enter a postcode',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your postcode';
                            }
                          },
                        ),
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
