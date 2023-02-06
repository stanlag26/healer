
import 'package:flutter/material.dart';


class RegisterSingInModel extends ChangeNotifier{
  bool regOn = false;

  void tumbler(){
    regOn = !regOn;
    notifyListeners();
  }













}