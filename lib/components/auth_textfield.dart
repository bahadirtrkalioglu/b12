import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool isObscureText;
  final String? Function(String?)? validator;
  final double? width;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.isObscureText,
    this.validator,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,

      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: isObscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[400]),
          
        ),
      ),
    );
  }
}
