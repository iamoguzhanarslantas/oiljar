import 'package:flutter/material.dart';

class CustomAlertDialogWithTextButton extends StatelessWidget {
  final String title;
  final Widget content;
  final Widget child;
  final void Function() onPressed;
  const CustomAlertDialogWithTextButton({
    super.key,
    required this.title,
    required this.content,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
      content: content,
      actions: [
        TextButton(
          onPressed: onPressed,
          child: child,
        ),
      ],
    );
  }
}
