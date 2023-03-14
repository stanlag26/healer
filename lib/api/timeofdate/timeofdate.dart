
import 'package:flutter/material.dart';

String listToString(List<String> mylist) {
  return mylist.join(' ');
}

Future<String?> formatTime(BuildContext context) async {
  final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial);
  if (timeOfDay != null) {
    final String hour = (timeOfDay.hour <= 9) ? '0${timeOfDay.hour}' : timeOfDay.hour.toString();
    final String minutes = (timeOfDay.minute <= 9) ? '0${timeOfDay.minute}' : timeOfDay.minute.toString();
    return '$hour:$minutes';
  }
  return null;
}

