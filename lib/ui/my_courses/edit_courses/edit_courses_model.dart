
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:io';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:healer/entity/course_hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../api/hive_api/hive_api.dart';
import '../../../api/timeofdate/timeofdate.dart';

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
  void myShowAdaptiveActionSheet(BuildContext context) {
    showAdaptiveActionSheet(
      context: context,
      title: Text(AppLocalizations.of(context)!.add_photo),
      androidBorderRadius: 30,
      actions: <BottomSheetAction>[
        BottomSheetAction(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.photo),
              const SizedBox(
                width: 10,
              ),
              Text(AppLocalizations.of(context)!.galery),
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
              children: [
                const Icon(
                  Icons.camera_alt_outlined,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  AppLocalizations.of(context)!.camera,
                ),
              ],
            ),
            onPressed: (BuildContext context) {
              _getPhoto(ImageSource.camera);
              Navigator.pop(context);
            }),
      ],
      cancelAction: CancelAction(
          title: Text(AppLocalizations.of(context)!.cancel, style: const TextStyle(color: Colors.black))),
    );
  }

  _getPhoto(ImageSource source) async {
    if (tumbler == true) {
      File(pickedFile!.path).delete();
    }
    final ImagePicker picker = ImagePicker();
    pickedFile = (await picker.pickImage(
      source: source,
      maxWidth: 400,
      maxHeight: 400,
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
    }
  }
}
