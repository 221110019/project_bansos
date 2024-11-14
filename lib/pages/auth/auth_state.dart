import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_bansos/pages/auth/intro_screen.dart';
import 'package:project_bansos/pages/auth/login_or_register.dart';
import 'package:project_bansos/pages/auth/register_screen.dart';
import 'package:project_bansos/pages/customer/home_cust.dart';
import 'package:project_bansos/pages/owner/home_owner.dart';
import 'package:project_bansos/services/auth_services.dart';

class AuthState extends StatefulWidget {
  final bool showLoginPage;
  const AuthState({super.key, required this.showLoginPage});

  @override
  State<AuthState> createState() => _AuthStateState();
}

class _AuthStateState extends State<AuthState> {
  AuthServices authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: authServices.auth.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (authServices.auth.currentUser!.email == 'asan@gmail.com') {
                return HomeOwner();
              } else {
                return HomeCust();
              }
            } else {
              return LoginOrRegister(showLoginPage: widget.showLoginPage);
            }
          }),
    );
  }
}
