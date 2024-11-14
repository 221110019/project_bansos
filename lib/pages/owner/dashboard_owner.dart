import 'package:flutter/material.dart';
import 'package:project_bansos/services/auth_services.dart';

class DashboardOwner extends StatefulWidget {
  const DashboardOwner({super.key});

  @override
  State<DashboardOwner> createState() => _DashboardOwnerState();
}

class _DashboardOwnerState extends State<DashboardOwner> {
  AuthServices authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextButton(
            onPressed: () {
              authServices.logoutUser();
            },
            child: Text('logout')));
  }
}
