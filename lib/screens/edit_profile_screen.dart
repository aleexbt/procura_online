import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procura_online/screens/auth/user_controller.dart';
import 'package:procura_online/widgets/select_option.dart';
import 'package:procura_online/widgets/text_input.dart';
import 'package:smart_select/smart_select.dart';

class EditProfileScreen extends StatelessWidget {
  final UserController _userController = Get.find();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _company = TextEditingController();
  final TextEditingController _selectedAccountType = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _postcode = TextEditingController();

  final List<S2Choice<String>> _accountType = [
    S2Choice<String>(value: 'Company', title: 'Company'),
    S2Choice<String>(value: 'Personal', title: 'Personal'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit profile'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: Colors.black),
            onPressed: () {
              FocusScope.of(context).unfocus();
              _userController.updateUserData(
                name: _name.text,
                email: _email.text,
                phone: _phone.text,
                company: _company.text,
                address: _address.text,
                postcode: _postcode.text,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Full name',
                style: TextStyle(color: Colors.blue),
              ),
              SizedBox(height: 5),
              Obx(
                () => CustomTextInput(
                  controller: _name..text = _userController.userData?.name,
                  fillColor: Colors.grey[200],
                  hintText: _userController.userData?.name,
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Email',
                style: TextStyle(color: Colors.blue),
              ),
              SizedBox(height: 5),
              Obx(
                () => CustomTextInput(
                  controller: _email..text = _userController.userData?.email,
                  fillColor: Colors.grey[200],
                  hintText: _userController.userData?.email,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Phone',
                style: TextStyle(color: Colors.blue),
              ),
              SizedBox(height: 5),
              Obx(
                () => CustomTextInput(
                  controller: _phone..text = _userController.userData?.phone,
                  fillColor: Colors.grey[200],
                  hintText: _userController.userData?.phone,
                  keyboardType: TextInputType.phone,
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
                  controller: _company..text = _userController.userData?.company,
                  fillColor: Colors.grey[200],
                  hintText: _userController.userData?.company,
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
                value: _selectedAccountType.text,
                choiceItems: _accountType,
                onChange: (state) => _selectedAccountType.text = state.value,
              ),
              SizedBox(height: 10),
              Text(
                'Address',
                style: TextStyle(color: Colors.blue),
              ),
              SizedBox(height: 5),
              Obx(
                () => CustomTextInput(
                  controller: _address..text = _userController.userData?.address,
                  fillColor: Colors.grey[200],
                  hintText: _userController.userData?.address,
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
                  controller: _postcode..text = _userController.userData?.postcode,
                  fillColor: Colors.grey[200],
                  hintText: _userController.userData?.postcode,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
