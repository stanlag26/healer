import 'package:healer/entity/course.dart';
import 'package:hive/hive.dart';
import '../../entity/course_hive.dart';
import '../firebase_api/firebase_api.dart';

Future<void> saveCoursesToHive(Course course) async {
  final box = await Hive.openBox<CourseHive>('courses_box');
  final photoPill =
      await FireBaseStorageApi().downloadFile(course.namePhotoPillInStorage);
  final courseHive = CourseHive(
      namePill: course.namePill,
      descriptionPill: course.descriptionPill,
      photoPill: photoPill,
      timeOfReceipt: course.timeOfReceipt);
  await box.add(courseHive);
}
