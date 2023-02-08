
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                      style: const TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        AwesomeNotifications()
                            .requestPermissionToSendNotifications()
                            .then((_) => Navigator.pop(context)),
                    child: Text(
                      AppLocalizations.of(context)!.allow,
                      style: const TextStyle(
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







