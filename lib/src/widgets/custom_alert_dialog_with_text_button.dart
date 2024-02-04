import 'package:flutter/material.dart';

class CustomAlertDialogWithTextButton extends StatelessWidget {
  final String title;
  final String content;
  final String buttonTitle;
  final void Function()? onPressed;
  const CustomAlertDialogWithTextButton({
    super.key,
    required this.title,
    required this.content,
    required this.buttonTitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text(buttonTitle),
        ),
      ],
    );
  }
}
