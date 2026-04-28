import 'package:flutter/material.dart';

class CustomizedTextField extends StatelessWidget {
  const CustomizedTextField({super.key, required this.controller, required this.hint, this.obscure = false, this.autofocus = false, this.type = TextInputType.text});


  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final bool autofocus;
  final TextInputType type;


  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: autofocus,
      obscureText: obscure,
      keyboardType: type,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
      ),
    );
  }
}