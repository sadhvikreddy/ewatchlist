import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum UserState { signedIn, signedOut, signUp, loading }

class SettingsModel extends ChangeNotifier {
  UserState userState = UserState.loading;
  User? userMeta;
  String userName = 'Person';
  String statusMessages = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  SettingsModel() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        userState = UserState.signedIn;
        userMeta = user;
        notifyListeners();
      } else {
        userState = UserState.signedOut;
        notifyListeners();
      }
    });
  }

  void updateUserState(UserState x) {
    userState = x;
    notifyListeners();
  }

  Future<void> triggerSignup(String name, String email, String password) async {
    try {
      final creds = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      creds.user?.updateDisplayName(name);
      userName = name;
      userState = UserState.signedIn;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        statusMessages = "Weak Password!";
        notifyListeners();
      } else if (e.code == 'email-already-in-use') {
        statusMessages = "Email exists, sign in instead";
        notifyListeners();
      }
    } catch (e) {
      statusMessages = e.toString();
      notifyListeners();
    }
  }

  Future<void> triggerSignin(String password, String email) async {
    try {
      final creds = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      userMeta = creds.user;
      userName = creds.user?.displayName ?? "Person";
      userState = UserState.signedIn;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        statusMessages = "No user found, signUp instead?";
        notifyListeners();
      } else if (e.code == 'wrong-password') {
        statusMessages = "Wrong password!";
        notifyListeners();
      }
    }
  }

  Future<void> triggerSignout() async {
    await FirebaseAuth.instance.signOut();
    userMeta = null;
    userName = "Person";
    userState = UserState.signedOut;
    notifyListeners();
  }
}
