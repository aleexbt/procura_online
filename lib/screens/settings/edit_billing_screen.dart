import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:procura_online/widgets/text_input.dart';

class EditBillingScreen extends StatelessWidget {
  final UserController _userController = Get.find();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetX<UserController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text('Edit billing'),
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.check, color: Colors.black),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  FocusScope.of(context).unfocus();
                  _userController.updateBilling();
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
                        'VAT number',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomTextInput(
                        controller: _.vatNumber.value..text = _.userData?.vatNumber,
                        fillColor: Colors.grey[200],
                        hintText: 'Enter a VAT number',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a VAT number';
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Billing name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomTextInput(
                        controller: _.billingName.value..text = _.userData?.billingName,
                        fillColor: Colors.grey[200],
                        hintText: 'Enter a billing name',
                        textCapitalization: TextCapitalization.sentences,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a billing name';
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Billing country',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => CustomTextInput(
                          controller: _.billingCountry.value..text = _.userData?.billingCountry,
                          fillColor: Colors.grey[200],
                          hintText: 'Enter a billing country',
                          textCapitalization: TextCapitalization.sentences,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a billing country';
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Billing city',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => CustomTextInput(
                          controller: _.billingCity.value..text = _.userData?.billingCity,
                          fillColor: Colors.grey[200],
                          hintText: 'Enter a billing city',
                          textCapitalization: TextCapitalization.sentences,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a billing city';
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Billing address',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => CustomTextInput(
                          controller: _.billingAddress.value..text = _.userData?.billingAddress,
                          fillColor: Colors.grey[200],
                          hintText: 'Enter a billing address',
                          textCapitalization: TextCapitalization.sentences,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a billing address';
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Billing postcode',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => CustomTextInput(
                          controller: _.billingPostcode.value..text = _.userData?.billingPostcode,
                          fillColor: Colors.grey[200],
                          hintText: 'Enter a billing postcode',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a billing postcode';
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
