import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../entity/course.dart';
import '../../my_widgets/my_toast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FireBaseFirestoreApi {

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> createCourse(BuildContext context, Course course) async {
    try {
      await _db.collection('Course').add(course.toJson());
    } on FirebaseException catch (e) {
      _showAuthErrorToast(context, e.message);
    }
  }

  Future<void> editCourse(BuildContext context, Course course) async {
    try {
      final docCourse = _db.collection('Course').doc(course.idDoc);
      await docCourse.set(course.toJson());
    } on FirebaseException catch (e) {
      _showAuthErrorToast(context, e.message);
    }
  }

  Future<void> delCourse(BuildContext context, Course course) async {
    try {
      await _db.collection('Course').doc(course.idDoc).delete();
      if (course.photoPill != null) {
        final desertRef = _storage.ref().child(
            'images/${course.namePhotoPillInStorage}');
        await desertRef.delete();
      }
    } on FirebaseException catch (e) {
      _showAuthErrorToast(context, e.message);
    }
  }

  static void _showAuthErrorToast(BuildContext context, String? errorMessage) {
    myToast(
        "${AppLocalizations.of(context)!.error_auth}: $errorMessage");
  }
}






class FireBaseStorageApi {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> loadImageOnStorage(XFile? pickedFile) async {
    final referenceDirImage = _storage.ref().child('images');
    if (pickedFile != null) {
      final referenceImageToUpload = referenceDirImage.child(pickedFile.name);
      await referenceImageToUpload.putFile(File(pickedFile.path));
      String photoPill = await referenceImageToUpload.getDownloadURL();
      return photoPill;
    } else {
      return null;
    }
  }

    Future<String> reLoadImageOnStorage(
        XFile pickedFile, String namePhotoPillInStorage) async {
      if (namePhotoPillInStorage != 'pills.jpg'){
      await _storage.ref().child('images/$namePhotoPillInStorage').delete();}
      final referenceDirImage = _storage.ref().child('images');
      final referenceImageToUpload = referenceDirImage.child(pickedFile.name);
      await referenceImageToUpload.putFile(File(pickedFile.path));
      File(pickedFile.path).delete();
      String photoPill = await referenceImageToUpload.getDownloadURL();
      return photoPill;
    }

    Future downloadFile(String? namePhotoPillInStorage) async {
    if(namePhotoPillInStorage !=null) {
      final ref = _storage.ref().child('images/$namePhotoPillInStorage');
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/${ref.name}');
      await ref.writeToFile(file);
      return '${dir.path}/${ref.name}';
    }
    return null;
    }
  }

