import 'package:flutter/material.dart';
import 'package:project_bansos/components/theme_switch.dart';
import 'package:project_bansos/helper/shortcut_helper.dart';
import 'package:project_bansos/services/auth_services.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  AuthServices authServices = AuthServices();
  void logout() {
    authServices.logoutUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        actions: [
          Icon(Icons.notifications),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person),
                  ),
                  title: Text(authServices.auth.currentUser!.email as String),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Display',
                  style: TextStyle(fontSize: 15),
                ),
                ListTile(
                  leading: Icon(Icons.light_mode),
                  title: Text('Light Mode'),
                  trailing: ThemeSwitch(),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ShortcutHelper.warnaPrimary(context)),
                  onPressed: logout,
                  child: Text(
                    'Log out',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
