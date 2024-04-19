import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

import 'snakbar_service.dart';

enum AuthStatus {
  notAuthenticated,
  authenticating,
  authenticated,
  error,
  forgotPwdMailSent
}

class AuthProvider extends ChangeNotifier {
  User? user;
  AuthStatus? status = AuthStatus.notAuthenticated;
  late FirebaseAuth _auth;

  static AuthProvider instance = AuthProvider();

  AuthProvider() {
    _auth = FirebaseAuth.instance;
    _checkCurrentUserIsAuthenticated();
  }

  void _checkCurrentUserIsAuthenticated() async {
    user = _auth.currentUser;
    if (user != null) {
      if (user!.emailVerified) {
      } else {
        logoutUser();
      }
    }
  }

  Future<void> logoutUser() async {
    try {
      await _auth.signOut();
      user = null;

      status = AuthStatus.notAuthenticated;
    } catch (e) {
      SnackBarService.instance.showSnackBarError("Error Logging Out");
    }
    notifyListeners();
  }

  Future<void> loginAnonymously() async {
    status = AuthStatus.authenticating;
    notifyListeners();
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    user = userCredential.user;
    status = AuthStatus.authenticated;

    if (user != null) {
      print('Anonymous user logged in: ${user?.uid}');
    } else {
      print('Failed to log in anonymously.');
    }
    status = AuthStatus.authenticated;
    notifyListeners();
  }

  Future<bool> loginUserWithEmailAndPassword(
      String email, String password) async {
    if (!isEmail(email)) {
      SnackBarService.instance.showSnackBarError('Enter valid email');
      return false;
    }
    if (password.isEmpty) {
      SnackBarService.instance.showSnackBarError('Enter password');
      return false;
    }
    status = AuthStatus.authenticating;
    notifyListeners();
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = result.user;

      if (!user!.emailVerified) {
        SnackBarService.instance
            .showSnackBarError('Your email is not verified');
        status = AuthStatus.error;
        logoutUser();
        notifyListeners();
        return false;
      } else {
        status = AuthStatus.authenticated;
        notifyListeners();
        return true;
      }
    } on FirebaseAuthException catch (e) {
      SnackBarService.instance.showSnackBarError(e.message!);
      status = AuthStatus.error;
      user = null;
      notifyListeners();
    }
    return false;
  }

  Future<bool> forgotPassword(String email) async {
    if (!isEmail(email)) {
      SnackBarService.instance.showSnackBarError('Enter valid email');
      return false;
    }
    status = AuthStatus.authenticating;
    notifyListeners();
    try {
      await _auth.sendPasswordResetEmail(email: email);
      status = AuthStatus.forgotPwdMailSent;
      notifyListeners();
      SnackBarService.instance
          .showSnackBarSuccess("Please check your mail for reset link");
      return true;
    } on FirebaseAuthException catch (e) {
      SnackBarService.instance.showSnackBarError(e.message!);
      status = AuthStatus.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updatePassword(String newPassword) async {
    if (!isAlphanumeric(newPassword)) {
      SnackBarService.instance
          .showSnackBarError('Enter alpha numeric password');
      return false;
    }
    status = AuthStatus.authenticating;
    notifyListeners();
    try {
      bool res = false;
      await user?.updatePassword(newPassword).then((value) {
        user?.reload();
        status = AuthStatus.authenticated;
        log('user : password updated}');
        res = true;
        notifyListeners();
      }).catchError((onError) {
        res = false;
        status = AuthStatus.error;
        notifyListeners();
      });
      return res;
    } on FirebaseAuthException catch (e) {
      SnackBarService.instance.showSnackBarError(e.message!);
      status = AuthStatus.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateName(String name) async {
    if (name.isEmpty) {
      SnackBarService.instance.showSnackBarError('Name cannot be empty');
      return false;
    }
    status = AuthStatus.authenticating;
    notifyListeners();
    try {
      bool res = false;
      await _auth.currentUser?.updateDisplayName(name).then((value) {
        user = _auth.currentUser;
        status = AuthStatus.authenticated;
        log('user : ${user?.displayName}');
        res = true;
      }).catchError((onError) {
        res = false;
      });
      status = AuthStatus.authenticated;
      notifyListeners();
      return res;
    } on FirebaseAuthException catch (e) {
      SnackBarService.instance.showSnackBarError(e.message!);
      status = AuthStatus.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateEmail(String email) async {
    if (!isEmail(email)) {
      SnackBarService.instance.showSnackBarError('Name cannot be empty');
      return false;
    }
    status = AuthStatus.authenticating;
    notifyListeners();
    try {
      bool res = false;
      await user?.verifyBeforeUpdateEmail(email).then((value) {
        user?.reload();
        status = AuthStatus.authenticated;
        log('user : ${user?.email}');
        status = AuthStatus.authenticated;
        notifyListeners();
        res = true;
      }).catchError((onError) {
        res = false;
      });
      return res;
    } on FirebaseAuthException catch (e) {
      SnackBarService.instance.showSnackBarError(e.message!);
      status = AuthStatus.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> registerUserWithEmailAndPassword(
      String name, String email, String password) async {
    if (name.isEmpty) {
      SnackBarService.instance.showSnackBarError('Enter Full name');
      return false;
    }
    if (!isEmail(email)) {
      SnackBarService.instance.showSnackBarError('Enter valid email');
      return false;
    }
    if (password.trim().isEmpty || password.trim().length < 8) {
      SnackBarService.instance
          .showSnackBarError('Password must be 8 character long');
      return false;
    }
    status = AuthStatus.authenticating;
    notifyListeners();
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      user = result.user;
      status = AuthStatus.authenticated;
      user!.updateDisplayName(name);
      user!.sendEmailVerification();
      SnackBarService.instance.showSnackBarSuccess(
          'We have sent a verification link to your email.');

      status = AuthStatus.authenticated;

      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      SnackBarService.instance.showSnackBarError(e.message!);
      status = AuthStatus.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> resetPasswordLink(String email) async {
    if (!isEmail(email)) {
      SnackBarService.instance.showSnackBarError('Enter valid email');
      return false;
    }

    status = AuthStatus.authenticating;
    notifyListeners();
    try {
      _auth.sendPasswordResetEmail(email: email);
      SnackBarService.instance.showSnackBarSuccess(
          'We have sent a verification link to your email.');

      status = AuthStatus.authenticated;

      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      SnackBarService.instance.showSnackBarError(e.message!);
      status = AuthStatus.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteAccount() async {
    status = AuthStatus.authenticating;
    notifyListeners();
    try {
      await user?.delete();
      logoutUser();
      status = AuthStatus.authenticated;

      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      SnackBarService.instance.showSnackBarError(e.message!);
      status = AuthStatus.error;
      notifyListeners();
      return false;
    }
  }
}
