import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:procura_online/widgets/gradient_button.dart';
import 'package:procura_online/widgets/select_option.dart';
import 'package:procura_online/widgets/text_input.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final UserController _userController = Get.find();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordConfirmation = TextEditingController();

  final TextEditingController _address = TextEditingController();
  final TextEditingController _postcode = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int currentStep = 0;

  List<Widget> steps() {
    return [
      stepOne(),
      stepTwo(),
      stepThree(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.blue,
    ));

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(
          'Sign up',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      // backgroundColor: Colors.blue,
      body: SafeArea(
        child: Obx(
          () => ModalProgressHUD(
            inAsyncCall: _userController.isLoading,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 50, left: 80, right: 80, bottom: 40),
                            child: SvgPicture.asset(
                              'assets/images/logo_branco.svg',
                              width: 100,
                              color: Colors.blue,
                            ),
                          ),
                          steps()[currentStep],
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        currentStep < 2
                            ? GradientButton(
                                text: 'Next',
                                onPressed: () {
                                  setState(() {
                                    if (currentStep == 0) {
                                    } else if (currentStep == 1) {}
                                    currentStep = currentStep + 1;
                                  });
                                },
                              )
                            : GradientButton(
                                text: 'Sign up',
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _userController.signUp(
                                      name: _name.text,
                                      email: _email.text,
                                      phone: _phone.text,
                                      address: _address.text,
                                      postcode: _postcode.text,
                                      password: _password.text,
                                    );
                                  }
                                },
                              ),
                        Visibility(
                          visible: currentStep > 0,
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              TextButton(
                                child: Text('Previous'),
                                onPressed: () {
                                  setState(() {
                                    if (currentStep > 0) {
                                      currentStep = currentStep - 1;
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
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

  Widget stepOne() {
    return Column(
      children: [
        CustomTextInput(
          controller: _name,
          fillColor: Colors.grey[200],
          hintText: 'Full name',
          textCapitalization: TextCapitalization.sentences,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        CustomTextInput(
          controller: _email,
          fillColor: Colors.grey[200],
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter your email address';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        CustomTextInput(
          controller: _phone,
          fillColor: Colors.grey[200],
          hintText: 'Phone',
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter your phone number';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        CustomTextInput(
          controller: _password,
          fillColor: Colors.grey[200],
          hintText: 'Password',
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter a password';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        CustomTextInput(
          controller: _passwordConfirmation,
          fillColor: Colors.grey[200],
          hintText: 'Confirm password',
          validator: (value) {
            if (value.isEmpty) {
              return 'Please confirm your password';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget stepTwo() {
    return Column(
      children: [
        SelectOption(
          modalTitle: 'Account type',
          selectText: 'Account type',
          value: _userController.selectedAccountType.value,
          choiceItems: _userController.accountTypeOptions,
          onChange: (state) => _userController.selectedAccountType(state.value),
        ),
        SizedBox(height: 20),
        CustomTextInput(
          fillColor: Colors.grey[200],
          hintText: 'Company',
          textCapitalization: TextCapitalization.sentences,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter your company';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        CustomTextInput(
          fillColor: Colors.grey[200],
          hintText: 'Skills',
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter your skills';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget stepThree() {
    return Column(
      children: [
        SelectOption(
          modalTitle: 'District',
          selectText: 'District',
          value: _userController.selectedAccountType.value,
          choiceItems: _userController.accountTypeOptions,
          onChange: (state) => _userController.selectedAccountType(state.value),
        ),
        SizedBox(height: 20),
        SelectOption(
          modalTitle: 'City',
          selectText: 'City',
          value: _userController.selectedAccountType.value,
          choiceItems: _userController.accountTypeOptions,
          onChange: (state) => _userController.selectedAccountType(state.value),
        ),
        SizedBox(height: 20),
        CustomTextInput(
          fillColor: Colors.grey[200],
          hintText: 'Address',
          textCapitalization: TextCapitalization.sentences,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter your address';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        CustomTextInput(
          fillColor: Colors.grey[200],
          hintText: 'Postcode',
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter your postcode';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class RegisterStepOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextInput(
          fillColor: Colors.grey[200],
          hintText: 'Full name',
          hintStyle: TextStyle(color: Colors.white),
          textCapitalization: TextCapitalization.sentences,
          errorBorderColor: Colors.white54,
          errorTextColor: Colors.white,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        CustomTextInput(
          hintText: 'Email',
          hintStyle: TextStyle(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
          errorBorderColor: Colors.white54,
          errorTextColor: Colors.white,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter your email address';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        CustomTextInput(
          hintText: 'Phone',
          hintStyle: TextStyle(color: Colors.white),
          keyboardType: TextInputType.phone,
          errorBorderColor: Colors.white54,
          errorTextColor: Colors.white,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter your phone number';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        CustomTextInput(
          hintText: 'Password',
          hintStyle: TextStyle(color: Colors.white),
          textCapitalization: TextCapitalization.sentences,
          errorBorderColor: Colors.white54,
          errorTextColor: Colors.white,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter a password';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        CustomTextInput(
          hintText: 'Confirm password',
          hintStyle: TextStyle(color: Colors.white),
          textCapitalization: TextCapitalization.sentences,
          errorBorderColor: Colors.white54,
          errorTextColor: Colors.white,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please confirm your password';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class RegisterStepTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextInput(
          hintText: 'Account type',
          hintStyle: TextStyle(color: Colors.white),
          textCapitalization: TextCapitalization.sentences,
          errorBorderColor: Colors.white54,
          errorTextColor: Colors.white,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        CustomTextInput(
          hintText: 'Company',
          hintStyle: TextStyle(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
          errorBorderColor: Colors.white54,
          errorTextColor: Colors.white,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter your email address';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        CustomTextInput(
          hintText: 'Skills',
          hintStyle: TextStyle(color: Colors.white),
          keyboardType: TextInputType.phone,
          errorBorderColor: Colors.white54,
          errorTextColor: Colors.white,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter your phone number';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class RegisterStepThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextInput(
          hintText: 'District',
          hintStyle: TextStyle(color: Colors.white),
          textCapitalization: TextCapitalization.sentences,
          errorBorderColor: Colors.white54,
          errorTextColor: Colors.white,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        CustomTextInput(
          hintText: 'City',
          hintStyle: TextStyle(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
          errorBorderColor: Colors.white54,
          errorTextColor: Colors.white,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter your email address';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        CustomTextInput(
          hintText: 'Address',
          hintStyle: TextStyle(color: Colors.white),
          keyboardType: TextInputType.phone,
          errorBorderColor: Colors.white54,
          errorTextColor: Colors.white,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter your phone number';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        CustomTextInput(
          hintText: 'Postcode',
          hintStyle: TextStyle(color: Colors.white),
          keyboardType: TextInputType.phone,
          errorBorderColor: Colors.white54,
          errorTextColor: Colors.white,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter your phone number';
            }
            return null;
          },
        ),
      ],
    );
  }
}
