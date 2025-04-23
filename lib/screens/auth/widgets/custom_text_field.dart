import 'package:flutter/material.dart';

typedef myValidate = String? Function(String?)?;
typedef Change = void Function(String)?;

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    required this.labelText,
    this.suffixIcon,
    this.showText = false,
    this.validate,
    this.onChange,
    this.maxLines = 1,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String labelText;
  final Widget? suffixIcon;
  final bool showText;
  final myValidate validate;
  final Change onChange;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      validator: validate,
      obscureText: showText,
      controller: controller,
      cursorColor: Color(0xff3598DB),
      maxLines: maxLines,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
        label: Text(labelText),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Color(0xff3598DB),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Color(0xff3598DB),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.red, // Red border for errors
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.red, // Red border when focused with error
          ),
        ),
        errorStyle: const TextStyle(
          color: Colors.red, // Error message text color
          fontSize: 14, // Adjust font size if needed
        ),
      ),
    );
  }
}
