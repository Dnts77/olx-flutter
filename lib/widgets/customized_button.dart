import 'package:flutter/material.dart';

class CustomizedButton extends StatelessWidget {
  const CustomizedButton({super.key, required this.text, this.textColor=Colors.white, this.onPressed});

  final String text;
  final Color textColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          )
        ),
        foregroundColor: WidgetStatePropertyAll(textColor),
        backgroundColor: WidgetStatePropertyAll(Color(0xff9c27b0)),
        padding: WidgetStatePropertyAll(EdgeInsets.fromLTRB(32, 16, 32, 16)),
      ),
      onPressed: () {
        onPressed?.call();
      },
      child: Text(text, style: TextStyle(fontSize: 20)),
    );
  }
}