import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:procura_online/widgets/gradient_button.dart';
import 'package:procura_online/widgets/select_option.dart';
import 'package:procura_online/widgets/select_option_multi.dart';
import 'package:procura_online/widgets/text_input.dart';
import 'package:smart_select/smart_select.dart';

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
  final TextEditingController _company = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _postcode = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool submittedStep1 = false;
  bool submittedStep2 = false;
  bool submittedStep3 = false;
  int currentStep = 0;
  bool isLoadingDistricts = false;
  bool isLoadingCities = false;

  List<Widget> steps() {
    return [
      stepOne(),
      stepTwo(),
      stepThree(),
    ];
  }

  String selectedAccountType = '';
  final List<S2Choice<String>> accountType = [
    S2Choice<String>(value: 'company', title: 'Company'),
    S2Choice<String>(value: 'personal', title: 'Personal'),
  ];

  List<dynamic> selectedSkills = [];
  final List<S2Choice> skills = [
    S2Choice<int>(value: 1, title: 'Workshop'),
    S2Choice<int>(value: 2, title: 'Car stand'),
    S2Choice<int>(value: 3, title: 'Scrap'),
    S2Choice<int>(value: 4, title: 'Other'),
  ];

  int selectedDistrict;
  final List<S2Choice> districts = [
    S2Choice<int>(value: 1, title: 'Dis. 1'),
    S2Choice<int>(value: 2, title: 'Dis. 2'),
    S2Choice<int>(value: 3, title: 'Dis. 3'),
    S2Choice<int>(value: 4, title: 'Dis. 4'),
  ];

  int selectedCity;
  final List<S2Choice> cities = [
    S2Choice<int>(value: 1, title: 'City 1'),
    S2Choice<int>(value: 2, title: 'City 2'),
    S2Choice<int>(value: 3, title: 'City 3'),
    S2Choice<int>(value: 4, title: 'City 4'),
  ];

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
                                      setState(() => submittedStep1 = true);
                                      if (_formKey.currentState.validate()) {
                                        currentStep = currentStep + 1;
                                      }
                                    } else if (currentStep == 1) {
                                      setState(() => submittedStep2 = true);
                                      if (_formKey.currentState.validate() &&
                                          selectedAccountType.isNotEmpty &&
                                          selectedSkills.isNotEmpty) {
                                        currentStep = currentStep + 1;
                                      }
                                    }
                                  });
                                },
                              )
                            : GradientButton(
                                text: 'Sign up',
                                onPressed: () {
                                  setState(() => submittedStep3 = true);
                                  if (_formKey.currentState.validate() &&
                                      selectedDistrict != null &&
                                      selectedCity != null) {
                                    _userController.signUp(
                                      name: _name.text,
                                      email: _email.text,
                                      phone: _phone.text,
                                      password: _password.text,
                                      company: _company.text,
                                      address: _address.text,
                                      postcode: _postcode.text,
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
      crossAxisAlignment: CrossAxisAlignment.start,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectOption(
          modalTitle: 'Account type',
          selectText: 'Account type',
          value: selectedAccountType,
          choiceItems: accountType,
          onChange: (state) => setState(() => selectedAccountType = state.value),
          hasError: selectedAccountType.isEmpty && submittedStep2,
        ),
        Visibility(
          visible: selectedAccountType.isEmpty && submittedStep2,
          child: Padding(
            padding: const EdgeInsets.only(left: 12, top: 5),
            child: Text(
              'Please select an account type',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        ),
        SizedBox(height: 20),
        CustomTextInput(
          controller: _company,
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
        SelectOptionMulti(
          modalTitle: 'Skills',
          selectText: 'Skills',
          value: selectedSkills,
          choiceItems: skills,
          onChange: (state) => setState(() => selectedSkills = state.value),
          hasError: selectedSkills.isEmpty && submittedStep2,
        ),
        Visibility(
          visible: selectedSkills.isEmpty && submittedStep2,
          child: Padding(
            padding: const EdgeInsets.only(left: 12, top: 5),
            child: Text(
              'Please select at least one skill',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget stepThree() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectOption(
          modalTitle: 'District',
          selectText: 'District',
          value: selectedDistrict,
          choiceItems: districts,
          onChange: (state) => setState(() => selectedDistrict = int.parse(state.value)),
          hasError: selectedDistrict == null && submittedStep3,
        ),
        Visibility(
          visible: selectedDistrict == null && submittedStep3,
          child: Padding(
            padding: const EdgeInsets.only(left: 12, top: 5),
            child: Text(
              'Please select a district',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        ),
        SizedBox(height: 20),
        SelectOption(
          modalTitle: 'City',
          selectText: 'City',
          value: selectedCity,
          choiceItems: cities,
          onChange: (state) => setState(() => selectedCity = int.parse(state.value)),
          hasError: selectedCity == null && submittedStep3,
        ),
        Visibility(
          visible: selectedCity == null && submittedStep3,
          child: Padding(
            padding: const EdgeInsets.only(left: 12, top: 5),
            child: Text(
              'Please select a city',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
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
