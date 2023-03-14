

import 'dart:io';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healer/entity/course_hive.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../api/firebase_api/firebase_api.dart';
import '../../../api/hive_api/hive_api.dart';
import '../../../api/timeofdate/timeofdate.dart';
import '../../../entity/course.dart';

class EditCoursesModel extends ChangeNotifier{
  late String namePill;
  late String descriptionPill;
  String? photoPill;
  String? oldPhotoPill;
  List<String> timeOfReceipt = [];
  var tumbler = false;
  XFile? pickedFile;


  Future<void> saveEditCoursesToHive(int index) async {
    await _saveImageFromCashToAppDocDir(pickedFile);
    saveEditCourse(
        index,
        CourseHive(
            namePill: namePill,
            descriptionPill: descriptionPill,
            photoPill: photoPill,
            timeOfReceipt: timeOfReceipt));
  }

  /////////////////////////////////
  void addTime(BuildContext context) async {
    final time = await formatTime(context);
    if (time != null) {
      timeOfReceipt.add(time);
      notifyListeners();
    }
  }

  void delTime(int index) {
    timeOfReceipt.removeAt(index);
    notifyListeners();
  }


//меню выбора
  void myShowAdaptiveActionSheet(BuildContext context)  {
    showAdaptiveActionSheet(
      context: context,
      title: const Text('Добавить фото'),
      androidBorderRadius: 30,
      actions: <BottomSheetAction>[
        BottomSheetAction(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.photo),
              SizedBox(
                width: 10,
              ),
              Text('Галерея'),
            ],
          ),
          onPressed: (BuildContext context) {
            _getPhoto(ImageSource.gallery);
            Navigator.pop(context);
          },
        ),
        BottomSheetAction(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.camera_alt_outlined,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Камера',
                ),
              ],
            ),
            onPressed: (BuildContext context) {
              _getPhoto(ImageSource.camera);
              Navigator.pop(context);
            }),
      ],
      cancelAction: CancelAction(
          title: const Text('Cancel', style: TextStyle(color: Colors.black))),
    );
  }

  _getPhoto(ImageSource source) async {
    if (tumbler == true) {
      File(pickedFile!.path).delete();
    }
    final ImagePicker picker = ImagePicker();
    pickedFile = (await picker.pickImage(
      source: source,
      maxWidth: 300,
      maxHeight: 300,
      imageQuality: 100,
    ));
    if (pickedFile != null) {
      photoPill = pickedFile!.path;
      print(photoPill);
      tumbler = true;
      notifyListeners();
    } else {
      return;
    }
  }

  Future <void> _saveImageFromCashToAppDocDir(XFile? pickedFile) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();


    String appDocPath = appDocDir.path;
    if (pickedFile != null) {
      String fileName = pickedFile.name;
      String filePath = '$appDocPath/$fileName';
      photoPill = filePath;
      File(pickedFile.path).copySync(filePath);
      if (oldPhotoPill != photoPill){
        File(oldPhotoPill!).delete();
      }
      File(pickedFile.path).delete();
    } else {
      photoPill = null ;
    }
  }
}
