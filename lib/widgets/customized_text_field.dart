import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomizedTextField extends StatelessWidget {
  const CustomizedTextField({super.key, required this.controller, required this.hint, this.obscure = false, this.autofocus = false, this.type = TextInputType.text, this.inputFormatters, this.maxLines, this.validator});


  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final bool autofocus;
  final TextInputType type;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autofocus,
      obscureText: obscure,
      keyboardType: type,
      inputFormatters: inputFormatters,
      validator: validator,
      style: TextStyle(fontSize: 20),
      maxLines: maxLines,
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