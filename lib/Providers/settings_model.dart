import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum UserState { signedIn, signedOut, signUp, loading }

class SettingsModel extends ChangeNotifier {
  UserState userState = UserState.loading;
  User? userMeta;
  String userName = '';
  String chUserName = '';
  String chEmail = '';
  String statusMessages = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  SettingsModel() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userState = UserState.signedIn;
      userMeta = user;
      notifyListeners();
    } else {
      userState = UserState.signedOut;
      notifyListeners();
    }
  }

  void updateUserState(UserState x) {
    userState = x;
    notifyListeners();
  }

  Future<void> triggerSignup(String name, String email, String password) async {
    if (name.isEmpty) {
      statusMessages = "Enter your name";
      notifyListeners();
    } else {
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
  }

  Future<void> triggerSignin(String password, String email) async {
    try {
      final creds = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      userMeta = creds.user;
      userName = creds.user?.displayName ?? "";
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
    userName = "";
    userState = UserState.signedOut;
    notifyListeners();
  }

  void changeUsername() async {
    if (chUserName.isNotEmpty) {
      await userMeta?.updateDisplayName(chUserName).then(((value) {
        userName = chUserName;
        chUserName = "";
      }));
      notifyListeners();
    } else {
      statusMessages = "Username empty, Username update failed.";
      notifyListeners();
    }
  }

  void forgotPass() async {
    if (chEmail.isNotEmpty) {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: chEmail);
    } else {
      statusMessages = "Email address is empty/invalid";
      notifyListeners();
    }
  }
}
