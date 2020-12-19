import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextInput extends StatelessWidget {
  final bool enabled;
  final bool isRequired;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final TextCapitalization textCapitalization;
  final int maxLength;
  final String hintText;
  final TextStyle hintStyle;
  final Color fillColor;
  final String validatorText;
  final Function onSubmitted;
  final FocusNode focusNode;
  final bool obscureText;
  final Widget suffixIcon;
  final TextInputAction textInputAction;
  final int maxLines;

  const CustomTextInput({
    Key key,
    this.enabled = true,
    this.isRequired = true,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.maxLength,
    this.hintText,
    this.hintStyle,
    this.fillColor,
    this.validatorText,
    this.onSubmitted,
    this.focusNode,
    this.obscureText = false,
    this.suffixIcon,
    this.textInputAction,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters ?? null,
      textCapitalization: textCapitalization,
      maxLength: maxLength,
      textInputAction: textInputAction,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        filled: true,
        fillColor: fillColor ?? Colors.white.withOpacity(0.4),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 22, horizontal: 12),
        errorStyle: TextStyle(height: 0),
        counterText: '',
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 0.0),
        ),
      ),
      style: TextStyle(
        fontSize: 14.0,
      ),
      validator: isRequired
          ? (text) {
              if (text.isEmpty) {
                return '';
              } else {
                return null;
              }
            }
          : null,
      onFieldSubmitted: onSubmitted,
      focusNode: focusNode ?? null,
      obscureText: obscureText,
    );
  }
}
