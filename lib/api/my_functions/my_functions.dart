
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:healer/entity/course.dart';

import '../firebase_api/firebase_api.dart';

Future<void> showMyAlertDialogDelRecipes(BuildContext context, Course course)  {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        content: SingleChildScrollView(
          child: ListBody(
            children: [Text(AppLocalizations.of(context)!.del_recipe)],
          ),
        ),
        actions: <Widget>[
          TextButton(
              child: Text(AppLocalizations.of(context)!.yes,
                  style: TextStyle(color: Colors.black, fontSize: 15)),
              onPressed: () {
                FireBaseApi().delCourse(context,course);
                Navigator.of(context).pop();
              }),
          TextButton(
            child: Text(AppLocalizations.of(context)!.no,
                style: TextStyle(color: Colors.black, fontSize: 15)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}



Future<void> showMyDialogCircular(BuildContext context) async {
  return
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator(),);
        });
}


void accessToNotifications(BuildContext context) {
  AwesomeNotifications().isNotificationAllowed().then(
        (isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: Text(AppLocalizations.of(context)!.allow_notifications),
                content: Text(
                    AppLocalizations.of(context)!.app_to_send_notifications),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.disable,
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        AwesomeNotifications()
                            .requestPermissionToSendNotifications()
                            .then((_) => Navigator.pop(context)),
                    child: Text(
                      AppLocalizations.of(context)!.allow,
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
        );
      }
    },
  );
}







