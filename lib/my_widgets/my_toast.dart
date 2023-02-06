import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void myToast (String text){
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 14.0);
}