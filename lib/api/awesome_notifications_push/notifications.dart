import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      icon: 'resource://drawable/notification_icon',
      bigPicture: photo,
      notificationLayout: NotificationLayout.Default,
      wakeUpScreen: true,
      autoDismissible:false,
      criticalAlert: true,
      locked: true,
      fullScreenIntent: true,

    );

    final actionButtons = [
      NotificationActionButton(
        key: 'DONE',
        label: 'Хорошо',
      ),
      NotificationActionButton(
        key: 'REMIND_LATER',
        label: 'Напомнить через 15 минут',
      ),
    ];

    await AwesomeNotifications().createNotification(
      content: content,
      actionButtons: actionButtons,
      schedule: schedule,
    );
  }

  static Future <void> onActionReceived(ReceivedAction receivedAction) async {
    int id =receivedAction.id!;
    String? title =receivedAction.title;
    String? body =receivedAction.body;
    String? bigPicture =receivedAction.bigPicture;
    if (receivedAction.buttonKeyPressed == 'DONE') {
      // Обработка нажатия на первую кнопку уведомления с передачей полезной нагрузки
      navigatorKey.currentState!.pushNamed(MainNavigationRouteNames.coursesView, arguments: [title, body, bigPicture]);
    } else if (receivedAction.buttonKeyPressed == 'REMIND_LATER') {
      print('object');
      await NotificationService.createNotification(
        notificationId:id,
        name: title ?? '',
        description: body ?? '',
        photo: bigPicture!,
        hour: DateTime.now().hour,
        minute: DateTime.now().minute + 15,
      );
      SystemNavigator.pop();
      // Обработка нажатия на вторую кнопку уведомления с передачей полезной нагрузки
    }else {
      // Обработка нажатия на уведомление без нажатия на кнопки с передачей полезной нагрузки
      navigatorKey.currentState!.pushNamed(MainNavigationRouteNames.coursesView, arguments: [title, body, bigPicture]);
    }
  }

  static Future<void> cancelScheduledNotifications() async {
    await AwesomeNotifications().cancelAllSchedules();
    // await AwesomeNotificationsPlatform.instance.resetGlobalBadge();
  }


}
