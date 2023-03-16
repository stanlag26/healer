import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  static Future<void> createNotification({
    required int notificationId,
    required String name,
    required String description,
    required String photo,
    required int hour,
    required int minute,
    required Map<String, String?> payload,

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
      notificationLayout: NotificationLayout.BigPicture,
      wakeUpScreen: true,
      autoDismissible:false,
      criticalAlert: true,
      locked: true,
      payload: payload

    );
    final actionButtons = [
      NotificationActionButton(
        key: 'DONE',
        label: 'Ok',
      ),
      NotificationActionButton(
        key: 'NO',
        label: 'No',
      ),
    ];

    await AwesomeNotifications().createNotification(
      content: content,
      actionButtons: actionButtons,
      schedule: schedule,
    );
  }

  static Future <void> onActionReceived(ReceivedAction receivedAction) async {
    String? payload =receivedAction.bigPicture;
    if (receivedAction.buttonKeyPressed == 'DONE') {
      // Обработка нажатия на первую кнопку уведомления с передачей полезной нагрузки
      print('Нажата кнопка 1 с переданной полезной нагрузкой: $payload');
    } else if (receivedAction.buttonKeyPressed == 'NO') {
      // Обработка нажатия на вторую кнопку уведомления с передачей полезной нагрузки
      print('Нажата кнопка 2 с переданной полезной нагрузкой: $payload');
    } else {
      // Обработка нажатия на уведомление без нажатия на кнопки с передачей полезной нагрузки
      print('Уведомление нажато без нажатия на кнопки с переданной полезной нагрузкой: $payload');
    }
  }

  static Future<void> cancelScheduledNotifications() async {
    await AwesomeNotifications().cancelAllSchedules();
  }


}
