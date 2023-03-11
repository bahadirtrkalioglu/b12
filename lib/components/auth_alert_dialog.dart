import 'package:flutter/material.dart';

class AuthAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String buttonText;
  final void Function()? onPressed;

  const AuthAlertDialog({
    super.key,
    required this.buttonText,
    required this.content,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [TextButton(onPressed: onPressed, child: Text(buttonText))],
    );
  }
}
