import 'package:flutter/material.dart';

class SignUpOption extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final String buttonText;
  const SignUpOption({
    super.key,
    required this.text,
    this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
