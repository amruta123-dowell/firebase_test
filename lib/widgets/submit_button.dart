import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String? text;
  final VoidCallback onClickButton;
  final TextStyle? textStyle;
  const SubmitButton(
      {super.key, this.text, required this.onClickButton, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple,
      ),
      onPressed: onClickButton,
      child: Text(
        text ?? "Submit",
        style: textStyle ?? const TextStyle(color: Colors.white),
      ),
    );
  }
}
