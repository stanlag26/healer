import 'package:awesome_notifications/awesome_notifications.dart';

class Noti {

 static Future<void> createNotification({
     required int id,
      required String name,
      required String description,
      required String photo,
      required int hour,
      required int minute,}) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          channelKey: 'basic_channel',
          title: name,
          body: description,
          bigPicture: 'file://$photo',
          notificationLayout: NotificationLayout.BigPicture,
          wakeUpScreen: true,
        ),
        actionButtons: [
          NotificationActionButton(
            key: 'DONE',
            label: 'Хорошо',
          ),
        ],
        schedule: NotificationCalendar(
          hour: hour,
          minute: minute,
          second: 0,
          millisecond: 0,
          repeats: true,
          timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
        ));
  }


  static Future<void> cancelScheduledNotifications() async {
    await AwesomeNotifications().cancelAllSchedules();
  }
}
