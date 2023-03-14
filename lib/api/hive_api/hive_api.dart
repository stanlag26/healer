import 'package:healer/entity/course.dart';
import 'package:hive/hive.dart';
import '../../entity/course_hive.dart';
import '../../ui/my_courses/courses/hive_courses.dart';
import '../firebase_api/firebase_api.dart';

Future<void> saveCoursesToHiveFromFirebase(Course course) async {
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

Future<void> saveCoursesToHive(CourseHive course) async {
  final box = await Hive.openBox<CourseHive>('courses_box');
  final courseHive = CourseHive(
      namePill: course.namePill,
      descriptionPill: course.descriptionPill,
      photoPill: course.photoPill,
      timeOfReceipt: course.timeOfReceipt);
  await box.add(courseHive);
}

void saveEditCourse( int listIndex,CourseHive courseHive ) async {
  final box = await Hive.openBox<CourseHive>('Courses_box');
  int courseKey = box.keyAt(listIndex);
    box.put(courseKey, courseHive);
  }


void firstEntryInApp(String name)  {
  var userBox = Hive.box('user_box');
  userBox.put('user', name);
  userBox.put('first_entry', true);
}

String nameUser()  {
  var userBox = Hive.box('user_box');
  return userBox.get('user')?? '';
}


