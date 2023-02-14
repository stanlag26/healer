import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healer/ui/navigation/my_navigation.dart';
import 'package:hive_flutter/adapters.dart';
import 'entity/course_hive.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CourseHiveAdapter());
  await Hive.openBox('user_box');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        defaultColor: Colors.teal,
        importance: NotificationImportance.Max,
        channelShowBadge: true, channelDescription: 'basic_channel',
        locked: true,
        enableLights: true,
        enableVibration: true,
        onlyAlertOnce: false,
        criticalAlerts: true,
        soundSource: 'resource://raw/res_custom_notification',
      ),
    ],
  );

  runApp(const MyNavigation());
  // runApp(
  //   DevicePreview(
  //     enabled: true,
  //     builder: (context) => const MyNavigation(),
  //   ),
  // );
}

