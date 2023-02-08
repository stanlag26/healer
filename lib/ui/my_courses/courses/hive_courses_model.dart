import 'package:healer/entity/course_hive.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'dart:io';
import '../../../api/awesome_notifications_push/notifications.dart';



class CoursesModel extends ChangeNotifier {
  List<CourseHive> _courses = [];
  late Box<CourseHive> _box;

  List<CourseHive> get courses => List.unmodifiable(_courses);

  CoursesModel() {
    _setup();
  }

  Future<void> _setup() async {
    _box = await Hive.openBox<CourseHive>('courses_box');
    _courses = _box.values.toList();
    _box.listenable().addListener(() => _readCoursesFromHive());
    notifyListeners();
    _saveCoursesToPush();
  }

  Future<void> _readCoursesFromHive() async {
    _courses = _box.values.toList();
    notifyListeners();
  }

  Future <void> deleteCourse(int index) async {
    final course = _box.getAt(index) as CourseHive;
    final file = File(course.photoPill);
    file.delete();
    await _box.deleteAt(index);
  }

  Future<void> _saveCoursesToPush() async {
    await NotificationService.cancelScheduledNotifications();
    int count = 0;
    List<String> timeSplit;
    for (var course in _courses) {
      for (var time in course.timeOfReceipt) {
        timeSplit = time.split(':');
        await NotificationService.createNotification(
            notificationId: count++,
            name: course.namePill,
            description: course.descriptionPill,
            photo: course.photoPill,
            hour: int.parse(timeSplit[0]),
            minute: int.parse(timeSplit[1])
        );
      }
    }
  }
}
