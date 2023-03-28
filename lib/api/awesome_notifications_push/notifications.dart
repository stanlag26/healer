import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import '../main_navigation/main_navigation.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class NotificationService {
  static Future<void> createNotification({
    required int notificationId,
    required String name,
    required String description,
    required String photo,
    required int hour,
    required int minute,

  }) async {
    final timeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
    final schedule = NotificationCalendar(
      hour: hour,
      minute: minute,
      second: 0,
      millisecond: 0,
      repeats: true,
      timeZone: timeZone,
    );
    final content = NotificationContent(
      id: notificationId,
      channelKey: 'basic_channel',
      title: name,
      body: description,
      bigPicture: photo,
      notificationLayout: NotificationLayout.Default,
      wakeUpScreen: true,
      autoDismissible:false,
      criticalAlert: true,
      locked: true,

    );
    final actionButtons = [
      NotificationActionButton(
        key: 'DONE',
        label: 'Хорошо',
      ),
      NotificationActionButton(
        key: 'NO',
        label: 'Выпью позже',
      ),
    ];

    await AwesomeNotifications().createNotification(
      content: content,
      actionButtons: actionButtons,
      schedule: schedule,
    );
  }

  static Future <void> onActionReceived(ReceivedAction receivedAction) async {
    String? title =receivedAction.title;
    String? body =receivedAction.body;
    String? bigPicture =receivedAction.bigPicture;
    if (receivedAction.buttonKeyPressed == 'DONE') {
      // Обработка нажатия на первую кнопку уведомления с передачей полезной нагрузки
      navigatorKey.currentState!.pushNamed(MainNavigationRouteNames.coursesView, arguments: [title, body, bigPicture]);
      print(receivedAction.bigPicture);

    } else if (receivedAction.buttonKeyPressed == 'NO') {
      // Обработка нажатия на вторую кнопку уведомления с передачей полезной нагрузки
      AwesomeNotifications().dismiss(receivedAction.id!);
    } else {
      // Обработка нажатия на уведомление без нажатия на кнопки с передачей полезной нагрузки
      navigatorKey.currentState!.pushNamed(MainNavigationRouteNames.coursesView, arguments: [title, body, bigPicture]);
    }
  }

  static Future<void> cancelScheduledNotifications() async {
    await AwesomeNotifications().cancelAllSchedules();
  }


}
