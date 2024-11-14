import 'package:flutter/material.dart';

class AuthTextfield extends StatelessWidget {
  final String helperText;
  final Icon prefixIcon;
  final String labelText;
  final bool obsecureText;
  final TextEditingController? controller;
  final String? errorText;

  const AuthTextfield(
      {super.key,
      required this.prefixIcon,
      required this.labelText,
      required this.helperText,
      this.obsecureText = false,
      this.controller,
      this.errorText});

  @override
  Padding build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          errorText: errorText,
          prefixIcon: prefixIcon,
          labelText: labelText,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          helperText: helperText,
          helperStyle: const TextStyle(fontStyle: FontStyle.italic),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(width: 2),
          ),
        ),
        obscureText: obsecureText,
      ),
    );
  }
}
