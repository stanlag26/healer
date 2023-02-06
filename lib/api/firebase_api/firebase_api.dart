import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../const/const.dart';
import '../../entity/course.dart';
import '../../my_widgets/my_toast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class FireBaseApi {


  Future<void> createCourse(BuildContext context, Course course) async {
    try {
      final docCourse =
      FirebaseFirestore.instance.collection('Course').doc();
      await docCourse.set(course.toJson());
    } on FirebaseException catch (e) {
      myToast("${AppLocalizations.of(context)!.error_auth}: ${e.message}");
    }
  }

    Future<String> loadImageOnStorage(XFile? pickedFile) async {
      final storageRef = FirebaseStorage.instance.ref();
      final referenceDirImage = storageRef.child('images');
      if (pickedFile != null) {
        final referenceImageToUpload = referenceDirImage.child(pickedFile.name);
        await referenceImageToUpload.putFile(File(pickedFile.path));
        File(pickedFile.path).delete();
        String photoPill = await referenceImageToUpload.getDownloadURL();
        return photoPill;
      } else {
        String photoPill = defaultImage;
        return photoPill;
      }
    }

    Future<void> delCourse(BuildContext context, Course course) async {
      try {
        await FirebaseFirestore.instance
            .collection('Course')
            .doc(course.idDoc)
            .delete();
        // Create a reference to the file to delete
        final storageRef = FirebaseStorage.instance.ref();
        final desertRef =
            storageRef.child('images/${course.namePhotoPillInStorage}');
        if (desertRef.name != 'pills.jpg'){
        await desertRef.delete();}
      } on FirebaseException catch (e) {
        // Caught an exception from Firebase.
        myToast("${AppLocalizations.of(context)!.error_auth}: ${e.message}");
      }
    }

    Future<void> editCourse(BuildContext context, Course course) async {
      try {
        final docCourse =
            FirebaseFirestore.instance.collection('Course').doc(course.idDoc);
        await docCourse.set(course.toJson());
      } on FirebaseException catch (e) {
        myToast("${AppLocalizations.of(context)!.error_auth}: ${e.message}");
      }
    }

    Future<String> reLoadImageOnStorage(
        XFile pickedFile, String namePhotoPillInStorage) async {
      // Создаем ссылку на хранилище из нашего приложения
      final storageRef = FirebaseStorage.instance.ref();
      // Удаляем файл со старым именем
      if (namePhotoPillInStorage != 'pills.jpg'){
      await storageRef.child('images/$namePhotoPillInStorage').delete();}
      final referenceDirImage = storageRef.child('images');
      final referenceImageToUpload = referenceDirImage.child(pickedFile.name);

      await referenceImageToUpload.putFile(File(pickedFile.path));
      File(pickedFile.path).delete();
      String photoPill = await referenceImageToUpload.getDownloadURL();
      return photoPill;
    }

    Future downloadFile(String namePhotoPillInStorage) async {
      final storageRef = FirebaseStorage.instance.ref();
      final ref = storageRef.child('images/$namePhotoPillInStorage');
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/${ref.name}');
      print('${dir.path}/${ref.name}');
      await ref.writeToFile(file);
      return '${dir.path}/${ref.name}';

    }
  }

