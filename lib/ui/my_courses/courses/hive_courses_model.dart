import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:healer/entity/course_hive.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'dart:io';
import '../../../api/awesome_notifications_push/notifications.dart';

class CoursesModel extends ChangeNotifier {
  var _courses = <CourseHive>[];

  List<CourseHive> get courses => _courses.toList();

  CoursesModel() {
    _setup();
    _saveCoursesToPush();

  }

  void _readCoursesFromHive(Box<CourseHive> box) {
    _courses = box.values.toList();
    print(_courses);
    notifyListeners();
  }

  void _setup() async {
    final box = await Hive.openBox<CourseHive>('courses_box');
    _readCoursesFromHive(box);
    // saveCoursesToPush();
    box.listenable().addListener(() => _readCoursesFromHive(box));
  }

  Future <void> deleteCourse(int index) async {
    final box = await Hive.openBox<CourseHive>('courses_box');
    final course = box.getAt(index) as CourseHive;
    final file = File(course.photoPill);
    file.delete();
    await box.deleteAt(index);
  }

  void _saveCoursesToPush() async {
    await NotificationService.cancelScheduledNotifications();

    int count = 0;
    var timeSplit=[];
    for (var course in _courses) {
      for (var time in course.timeOfReceipt) {
        timeSplit = time.split(':');
        await NotificationService.createNotification(
            notificationId: count++,
            name: 'Время приема ${course.namePill}а',
            description: course.descriptionPill,
            photo: course.photoPill,
            hour: int.parse(timeSplit[0]),
            minute: int.parse(timeSplit[1])
        );
      }
    }
    print(count);
  }
}
