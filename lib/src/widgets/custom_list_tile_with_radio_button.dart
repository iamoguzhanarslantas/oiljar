import 'package:flutter/material.dart';

class CustomListTileWithRadioButton extends StatelessWidget {
  final String title;
  final void Function(Object?) onChanged;
  final Object groupValue;
  final Object value;
  const CustomListTileWithRadioButton({
    super.key,
    required this.title,
    required this.onChanged,
    required this.groupValue,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Radio(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}
