import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  final DropDownCallBack dropDownCallBack;
  final List<String> optionNames;

  const DropDownWidget(
    this.dropDownCallBack,
    this.optionNames, {
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DropDownState();
  }
}

class _DropDownState extends State<DropDownWidget> {
  String _selectedOption = "";

  @override
  void initState() {
    _selectedOption = widget.optionNames[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          color: Colors.grey[200],
          child: DropdownButton<String>(
            isExpanded: true,
            hint: Text("Choose"),
            icon: Icon(Icons.arrow_drop_down),
            value: _selectedOption,
            iconSize: 24,
            style: TextStyle(color: Colors.black),
            onChanged: (newValue) {
              setState(() {
                _selectedOption = newValue;
                widget.dropDownCallBack(newValue);
              });
            },
            items: widget.optionNames.map((itemName) {
              return DropdownMenuItem(
                value: itemName,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(itemName),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

//Typedef to get accident type value
typedef DropDownCallBack(String accidentType);
