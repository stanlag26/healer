

import 'package:flutter/material.dart';

class MyAvatarPhoto extends StatelessWidget {
 final Widget photo;

  const MyAvatarPhoto({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return SafeArea(
    child: Padding(
      padding: EdgeInsets.only(top:10, left: 30, right: 30, bottom: 10),
      child: Container(
        padding: EdgeInsets.all(1), // Border width
        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(30)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: SizedBox.fromSize(
            size: Size.fromRadius(100), // Image radius
            child: photo, //Image.file(File(avatar), fit: BoxFit.cover),
          ),
        ),
      ),
    ),
  );
}
}


