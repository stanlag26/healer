import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyTimeInterval extends StatelessWidget {
  final int count;
  final String titleText;
  final VoidCallback onPress;
  const MyTimeInterval(
      {Key? key,
      required this.count,
      required this.titleText,
      required this.onPress})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)),
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
                leading: const Icon(FontAwesomeIcons.clock),
                title: Text(titleText),
                trailing: IconButton(
                  onPressed: onPress,
                  icon: const Icon(
                    FontAwesomeIcons.trash,
                    color: Colors.blue,
                  ),
                )),
          ],
        ));
  }
}
