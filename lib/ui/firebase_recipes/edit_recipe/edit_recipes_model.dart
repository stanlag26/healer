

import 'dart:io';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:healer/entity/course_hive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../api/firebase_api/firebase_api.dart';
import '../../../entity/course.dart';

class EditRecipesModel extends ChangeNotifier{

  final userId = FirebaseAuth.instance.currentUser?.uid;
  late String idDoc;
  late String namePhotoPillInStorage;
  late String namePill;
  late String descriptionPill;
  List<String> timeOfReceipt = [];
  var tumbler = false;
  XFile? pickedFile;
  late String photoPill;



  Future<void> editCourseAndToFirebase(BuildContext context) async {
      photoPill = tumbler == true ? await FireBaseApi().reLoadImageOnStorage( pickedFile!, namePhotoPillInStorage):
      photoPill;
      Course course = Course(
          idDoc: idDoc,
          idUser: userId ?? '',
          namePill: namePill,
          descriptionPill: descriptionPill,
          photoPill: photoPill,
          timeOfReceipt: timeOfReceipt,
          namePhotoPillInStorage: tumbler == true ? pickedFile!.name
             :namePhotoPillInStorage);
      await FireBaseApi().editCourse(context,course);

  }

  /////////////////////////////////
  void addTime(BuildContext context) async {
    final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.dial);
    if (timeOfDay != null) {
      timeOfReceipt.add('${timeOfDay.hour}:${timeOfDay.minute}');
      notifyListeners();
    }
  }

  void delTime(int index) {
    timeOfReceipt.removeAt(index);
    notifyListeners();
  }


//меню выбора
  void myShowAdaptiveActionSheet(BuildContext context) {
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
              ;
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
      tumbler = true;
      notifyListeners();
    } else {
      return;
    }
  }
}
