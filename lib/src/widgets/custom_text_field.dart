import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labeltext;
  final Widget prefix;
  final bool isPasswordType;
  final TextEditingController controller;
  const CustomTextField({
    Key? key,
    required this.labeltext,
    required this.prefix,
    required this.isPasswordType,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      cursorColor: Colors.blue,
      style: const TextStyle(
        color: Colors.blue,
      ),
      decoration: InputDecoration(
        labelText: labeltext,
        prefix: prefix,
        labelStyle: const TextStyle(
          color: Colors.blue,
        ),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
      ),
      keyboardType: isPasswordType
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
    );
  }
}
