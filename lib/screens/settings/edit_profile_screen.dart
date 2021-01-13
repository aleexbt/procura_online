import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:procura_online/widgets/select_option.dart';
import 'package:procura_online/widgets/text_input.dart';

class EditProfileScreen extends StatelessWidget {
  final UserController _userController = Get.find();
  final _formKey = GlobalKey<FormState>();

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
                if(_formKey.currentState.validate()) {
                  FocusScope.of(context).unfocus();
                  _userController.updateUserData();
                }
              },
            ),
          ],
        ),
        body: ModalProgressHUD(
          inAsyncCall: _userController.isSaving,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Full name',
                      style: TextStyle(color: Colors.blue),
                    ),
                    SizedBox(height: 5),
                    CustomTextInput(
                      controller: _.name.value..text = _.userData?.name,
                      fillColor: Colors.grey[200],
                      hintText: 'Full name',
                      textCapitalization: TextCapitalization.sentences,
                      validator: (value) {
                        if(value.isEmpty) {
                          return 'Please enter your name';
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Email',
                      style: TextStyle(color: Colors.blue),
                    ),
                    SizedBox(height: 5),
                    CustomTextInput(
                      controller: _.email.value..text = _.userData?.email,
                      fillColor: Colors.grey[200],
                      hintText: 'Email address',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if(value.isEmpty) {
                          return 'Please enter your email';
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Phone',
                      style: TextStyle(color: Colors.blue),
                    ),
                    SizedBox(height: 5),
                    Obx(
                      () => CustomTextInput(
                        controller: _.phone.value..text = _.userData?.phone,
                        fillColor: Colors.grey[200],
                        hintText: 'Phone number',
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Company',
                      style: TextStyle(color: Colors.blue),
                    ),
                    SizedBox(height: 5),
                    Obx(
                      () => CustomTextInput(
                        controller: _.company.value..text = _.userData?.company,
                        fillColor: Colors.grey[200],
                        hintText: 'Company name',
                        textCapitalization: TextCapitalization.sentences,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Please enter your company name';
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Account type',
                      style: TextStyle(color: Colors.blue),
                    ),
                    SizedBox(height: 5),
                    SelectOption(
                      modalTitle: 'Account type',
                      selectText: 'Select an option',
                      value: _.selectedAccountType.value,
                      choiceItems: _.accountTypeOptions,
                      onChange: (state) => _.selectedAccountType(state.value),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Address',
                      style: TextStyle(color: Colors.blue),
                    ),
                    SizedBox(height: 5),
                    Obx(
                      () => CustomTextInput(
                        controller: _.address.value..text = _.userData?.address,
                        fillColor: Colors.grey[200],
                        hintText: 'Full address',
                        textCapitalization: TextCapitalization.sentences,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Please enter your address';
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Postcode',
                      style: TextStyle(color: Colors.blue),
                    ),
                    SizedBox(height: 5),
                    Obx(
                      () => CustomTextInput(
                        controller: _.postcode.value..text = _.userData?.postcode,
                        fillColor: Colors.grey[200],
                        hintText: 'Postcode',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if(value.isEmpty) {
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
    );
  }
}
