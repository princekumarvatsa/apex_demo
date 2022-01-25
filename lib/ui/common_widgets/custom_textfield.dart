import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String? errorText;
  final Function(String) onChanged;
  final bool isPasswordField;
  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.errorText,
    required this.onChanged,
    required this.isPasswordField,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPasswordField,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      ),
      onChanged: onChanged,
    );
  }
}
