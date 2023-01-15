import 'package:flutter/material.dart';

class DefaultInputFormWidget extends StatelessWidget {
  const DefaultInputFormWidget(
      {Key? key,
      required this.placeholder,
      required this.label,
      required this.controller,
      required this.validationMsg})
      : super(key: key);

  final String placeholder;
  final String label;
  final TextEditingController controller;
  final String validationMsg;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: placeholder, labelText: label),
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validationMsg;
        }
        return null;
      },
    );
  }
}
