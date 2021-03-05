import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:procura_online/widgets/gradient_button.dart';
import 'package:procura_online/widgets/text_input.dart';

class EditBillingScreen extends StatelessWidget {
  final UserController _userController = Get.find();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetX<UserController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text('Faturação'),
          elevation: 0,
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
                        'NIF',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomTextInput(
                        controller: _.vatNumber.value..text = _.userData?.vatNumber,
                        fillColor: Colors.grey[200],
                        hintText: 'Informe o NIF',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Campo de preenchimento obrigatório.';
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Nome',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomTextInput(
                        controller: _.billingName.value..text = _.userData?.billingName,
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
                        'País',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => CustomTextInput(
                          controller: _.billingCountry.value..text = _.userData?.billingCountry,
                          fillColor: Colors.grey[200],
                          hintText: 'Informe o país',
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
                        'Cidade',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => CustomTextInput(
                          controller: _.billingCity.value..text = _.userData?.billingCity,
                          fillColor: Colors.grey[200],
                          hintText: 'Informe a cidade',
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
                        'Endereço',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => CustomTextInput(
                          controller: _.billingAddress.value..text = _.userData?.billingAddress,
                          fillColor: Colors.grey[200],
                          hintText: 'Informe o endereço',
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
                          controller: _.billingPostcode.value..text = _.userData?.billingPostcode,
                          fillColor: Colors.grey[200],
                          hintText: 'Informe o código postal',
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
                          if (_formKey.currentState.validate()) {
                            FocusScope.of(context).unfocus();
                            _userController.updateBilling();
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
