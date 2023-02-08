import 'package:awesome_notifications/awesome_notifications.dart';

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
      bigPicture: 'file://$photo',
      notificationLayout: NotificationLayout.BigPicture,
      wakeUpScreen: true,
      autoDismissible:false,
      criticalAlert: true,
      locked: true

    );
    final actionButtons = [
      NotificationActionButton(
        key: 'DONE',
        label: 'Ok',
      ),
    ];

    await AwesomeNotifications().createNotification(
      content: content,
      actionButtons: actionButtons,
      schedule: schedule,
    );
  }

  static Future<void> cancelScheduledNotifications() async {
    await AwesomeNotifications().cancelAllSchedules();
  }
}
