import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:procura_online/widgets/gradient_button.dart';
import 'package:procura_online/widgets/text_input.dart';

class ChangePasswordScreen extends StatelessWidget {
  final UserController _userController = Get.find();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alterar password'),
        elevation: 0,
      ),
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: _userController.isLoading,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password atual',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomTextInput(
                        controller: _currentPassword,
                        fillColor: Colors.grey[200],
                        hintText: 'Informe a password atual',
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Campo de preenchimento obrigatório.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Nova password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomTextInput(
                          controller: _newPassword,
                          fillColor: Colors.grey[200],
                          hintText: 'Informe a nova password',
                          obscureText: true,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Campo de preenchimento obrigatório.';
                            }
                            if (value.length < 8) {
                              return 'Sua password precisa ter ao menos 8 caracteres.';
                            }
                            return null;
                          }),
                      SizedBox(height: 20),
                      Text(
                        'Confirmar nova password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomTextInput(
                        controller: _confirmPassword,
                        fillColor: Colors.grey[200],
                        hintText: 'Confirme sua nova password.',
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Campo de preenchimento obrigatório.';
                          }
                          if (value != _newPassword.text) {
                            return 'As passwords não são iguais.';
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      GradientButton(
                        text: 'Guardar',
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            FocusScope.of(context).unfocus();
                            _userController.changePassword(
                              currentPass: _currentPassword.text,
                              newPass: _newPassword.text,
                              confirmPass: _confirmPassword.text,
                            );
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
