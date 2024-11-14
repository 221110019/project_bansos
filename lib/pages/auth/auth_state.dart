import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_bansos/pages/auth/login_or_register.dart';
import 'package:project_bansos/pages/customer/home_cust.dart';
import 'package:project_bansos/pages/owner/home_owner.dart';
import 'package:project_bansos/services/auth_services.dart';
import 'package:project_bansos/services/shared_preferences.dart';

class AuthState extends StatefulWidget {
  final bool showLoginPage;
  const AuthState({super.key, required this.showLoginPage});

  @override
  State<AuthState> createState() => _AuthStateState();
}

class _AuthStateState extends State<AuthState> {
  AuthServices authServices = AuthServices();
  SharedPreferencesServices sharedPreferencesServices =
      SharedPreferencesServices();
  @override
  void initState() {
    sharedPreferencesServices.save(KEY_FIRSTTIME, false);
    super.initState();
  }

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
