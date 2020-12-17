import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const LargeButton({
    Key key,
    @required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: Colors.white,
        disabledColor: Colors.white.withOpacity(0.5),
        disabledTextColor: Colors.grey[600],
        textColor: Colors.blue,
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
