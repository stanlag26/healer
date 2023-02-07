
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:healer/my_widgets/my_toast.dart';

import '../main_navigation/main_navigation.dart';


class MyAuth{

  static Future<void> mailRegister(BuildContext context, String mail, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: mail, password: password);
      await mailSingIn(context, mail, password);
    } on FirebaseAuthException catch (e) {
      myToast("${AppLocalizations.of(context)!.error_auth}: ${e.message}");
    }
  }

  static Future<void> mailSingIn(BuildContext context, String mail, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: password);
      Navigator.popAndPushNamed(context, MainNavigationRouteNames.main);
    } on FirebaseAuthException catch (e) {
      myToast("${AppLocalizations.of(context)!.error_auth}: ${e.message}");
    }
  }

  static Future<void> signOut(BuildContext context,) async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      myToast("${AppLocalizations.of(context)!.error_auth}: ${e.message}");
    }
  }

  static Future<void> resetPassword(BuildContext context, String mail) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: mail);
    } on FirebaseAuthException catch (e) {
      myToast("${AppLocalizations.of(context)!.error_auth}: ${e.message}");
    }
  }

}