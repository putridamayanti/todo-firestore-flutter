import 'package:flutter/material.dart';

class InputComponent extends StatelessWidget {

  TextEditingController controller;
  String hint;
  bool obscureText;

  InputComponent({
    this.controller,
    this.hint,
    this.obscureText
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText != null ? obscureText : false,
        decoration: InputDecoration(
          hintText: hint
        ),
      ),
    );
  }
}
