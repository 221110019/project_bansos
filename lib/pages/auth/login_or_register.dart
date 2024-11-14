import 'package:flutter/material.dart';
import 'package:project_bansos/pages/auth/login_screen.dart';
import 'package:project_bansos/pages/auth/register_screen.dart';

class LoginOrRegister extends StatefulWidget {
  bool showLoginPage;
  LoginOrRegister({super.key, required this.showLoginPage});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  void toggleScreens() {
    setState(() {
      print('hai');
      widget.showLoginPage = !widget.showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showLoginPage) {
      return LoginScreen(showRegisterPage: toggleScreens);
    } else {
      return RegisterScreen(showLoginPage: toggleScreens);
    }
  }
}
