

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class MyShowMyAlertDialog extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MyShowMyAlertDialog({Key? key, required this.text, required this.onPressed,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SingleChildScrollView(
        child: Text(text),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: onPressed,
            child: Text(AppLocalizations.of(context)!.yes,
                style: const TextStyle(color: Colors.black, fontSize: 15))),
        TextButton(
          child: Text(AppLocalizations.of(context)!.no,
              style: const TextStyle(color: Colors.black, fontSize: 15)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
