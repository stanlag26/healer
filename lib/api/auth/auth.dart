import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:healer/my_widgets/my_toast.dart';
import '../main_navigation/main_navigation.dart';

class MyAuth {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future<void> registerWithEmail(
      BuildContext context, String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (context.mounted) {
        await signInWithEmail(context, email, password);
      }
    } on FirebaseAuthException catch (e) {
      _showAuthErrorToast(context, e.message);
    }
  }

  static Future<void> signInWithEmail(
      BuildContext context, String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (context.mounted) {
        Navigator.popAndPushNamed(
            context, MainNavigationRouteNames.main);
      }
    } on FirebaseAuthException catch (e) {
      _showAuthErrorToast(context, e.message);
    }
  }

  static Future<void> signOut(BuildContext context) async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      _showAuthErrorToast(context, e.message);
    }
  }

  static Future<void> resetPassword(BuildContext context, String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      _showAuthErrorToast(context, e.message);
    }
  }

  static void _showAuthErrorToast(
      BuildContext context, String? errorMessage) {
    myToast(
        "${AppLocalizations.of(context)!.error_auth}: $errorMessage");
  }
}

