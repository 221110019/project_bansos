import 'package:firebase_auth/firebase_auth.dart';

import 'package:project_bansos/provider/login_provider.dart';
import 'package:project_bansos/provider/register_provider.dart';
import 'package:provider/provider.dart';

class AuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  void registerUser(email, password, confirmPassword, context) async {
    try {
      var credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'weak-password') {
        Provider.of<RegisterProvider>(context, listen: false)
            .changePasswordError('Password lemah');
      } else if (e.code == 'email-already-in-use') {
        Provider.of<RegisterProvider>(context, listen: false)
            .changeEmailError('Email sudah terpakai');
      } else if (e.code == 'invalid-email') {
        Provider.of<RegisterProvider>(context, listen: false)
            .changeEmailError('Email salah');
      }
    } catch (e) {
      print('error : $e');
    }
  }

  void loginUser(email, password, context) async {
    try {
      var credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      print(credential);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        Provider.of<LoginProvider>(context, listen: false)
            .changeEmailError('User tidak ditemukan');
      } else if (e.code == 'wrong-password') {
        Provider.of<LoginProvider>(context, listen: false)
            .changePasswordError('password salah');
      } else if (e.code == 'invalid-email') {
        Provider.of<LoginProvider>(context, listen: false)
            .changeEmailError('Email salah');
      }
    } catch (e) {
      print('error : $e');
    }
  }

  void logoutUser() async {
    await auth.signOut();
  }

  void registerErrorValidate(
      String email, String password, String confirmPassword, context) {
    if (password.trim() != confirmPassword.trim()) {
      Provider.of<RegisterProvider>(context, listen: false)
          .changePasswordError('password dan confirm password tidak sama');
      Provider.of<RegisterProvider>(context, listen: false)
          .changeConfirmPassword('password dan confirm password tidak sama');
    } else {
      registerUser(email, password, confirmPassword, context);
    }
  }
}
