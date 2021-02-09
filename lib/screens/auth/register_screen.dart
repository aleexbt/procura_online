import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:procura_online/controllers/user_controller.dart';
import 'package:procura_online/models/plan_model.dart';
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
  FocusNode mainNode;
  bool submittedStep1 = false;
  bool submittedStep2 = false;
  bool submittedStep3 = false;
  bool submittedStep4 = false;
  int currentStep = 0;

  int selectedDistrict;
  int selectedCity;
  int selectedPlan = 1;

  @override
  void initState() {
    _userController.getSkills();
    _userController.getDistricts();
    _userController.getPlans();
    mainNode = FocusNode();
    super.initState();
  }

  List<Widget> steps() {
    return [
      stepOne(),
      stepTwo(),
      stepThree(),
      stepFour(),
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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.blue,
    ));
    FocusScope.of(context).requestFocus(mainNode);

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
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Focus(
                      focusNode: mainNode,
                      child: Form(
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
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        currentStep < 3
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
                                    } else if (currentStep == 2) {
                                      setState(() => submittedStep3 = true);
                                      if (selectedAccountType.isNotEmpty) {
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
                                      type: selectedAccountType,
                                      company: _company.text,
                                      skills: selectedSkills,
                                      district: selectedDistrict,
                                      city: selectedCity,
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

  List<String> titles = ["Flutter Swiper is awosome", "Really nice", "Yeap"];

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
            if (!GetUtils.isEmail(value)) {
              return 'Please enter a valid email address';
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
          obscureText: true,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter a password';
            }
            if (value.length < 8) {
              return 'Your password must have at least 8 characters';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        CustomTextInput(
          controller: _passwordConfirmation,
          fillColor: Colors.grey[200],
          hintText: 'Confirm password',
          obscureText: true,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please confirm your password';
            }
            if (value != _password.text) {
              return 'Your passwords didn\'t match, please verify';
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
          modalType: S2ModalType.bottomSheet,
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
        Obx(
          () => SelectOptionMulti(
            isLoading: _userController.isLoadingSkills,
            modalTitle: 'Skills',
            selectText: 'Skills',
            modalType: S2ModalType.bottomSheet,
            value: selectedSkills,
            choiceItems: _userController.skills,
            onChange: (state) => setState(() => selectedSkills = state.value),
            hasError: selectedSkills.isEmpty && submittedStep2,
          ),
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
        Obx(
          () => SelectOption(
            isLoading: _userController.isLoadingDistricts,
            modalTitle: 'District',
            selectText: 'District',
            modalType: S2ModalType.bottomSheet,
            value: selectedDistrict,
            choiceItems: _userController.districts,
            onChange: (state) =>
                [setState(() => selectedDistrict = state.value), _userController.getCities(state.value)],
            hasError: selectedDistrict == null && submittedStep3,
          ),
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
        Obx(
          () => SelectOption(
            isLoading: _userController.isLoadingCities,
            isDisabled: selectedDistrict == null,
            modalTitle: 'City',
            selectText: 'City',
            value: selectedCity,
            modalType: S2ModalType.bottomSheet,
            choiceItems: _userController.cities,
            onChange: (state) => setState(() => selectedCity = state.value),
            hasError: selectedCity == null && submittedStep3,
          ),
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
          controller: _address,
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
          controller: _postcode,
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

  Widget stepFour() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Obx(
        //   () => SelectOption(
        //     isLoading: _userController.isLoadingPlans,
        //     modalTitle: 'Plan',
        //     selectText: 'Plan',
        //     modalType: S2ModalType.bottomSheet,
        //     value: selectedPlan,
        //     choiceItems: _userController.plans,
        //     onChange: (state) => setState(() => selectedPlan = state.value),
        //     hasError: selectedPlan == null && submittedStep4,
        //   ),
        // ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            height: 250,
            child: Obx(
              () => Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return plan(_userController.plans[index]);
                },
                itemCount: _userController.plans.length,
                control: SwiperControl(color: Colors.blue),
              ),
            ),
          ),
        ),
        Visibility(
          visible: selectedPlan == null && submittedStep4,
          child: Padding(
            padding: const EdgeInsets.only(left: 12, top: 5),
            child: Text(
              'Please select a plan',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget plan(Plan plan) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: selectedPlan == plan.id ? Colors.blue : Colors.grey[200], width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              plan.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              '${plan.currency} ${plan.price}',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),
            Divider(),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: plan.features
                    .map((e) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check,
                              color: Colors.blue,
                            ),
                            Text(e.slug),
                          ],
                        ))
                    .toList(),
              ),
            ),
            SizedBox(height: 10),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: selectedPlan == plan.id ? Colors.blue.withOpacity(0.2) : null,
              ),
              child: Text(selectedPlan == plan.id ? 'Selected plan' : 'Select this plan'),
              onPressed: () {
                setState(() {
                  selectedPlan = plan.id;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
