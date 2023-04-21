import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  initialize() async {
    AndroidInitializationSettings androidInit =
        const AndroidInitializationSettings('@mipmap/pie');

    InitializationSettings initSettings = InitializationSettings(
      android: androidInit,
    );

    await _plugin.initialize(initSettings);
  }

  dailyNotification(int hour, int minute) async {
    final String currentTime = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTime));

    tz.TZDateTime utcTime = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduleDate = tz.TZDateTime(
        tz.local, utcTime.year, utcTime.month, utcTime.day, hour, minute);

    if (scheduleDate.isBefore(utcTime)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }

    var bigImage = const BigPictureStyleInformation(
      DrawableResourceAndroidBitmap('@mipmap/big'),
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/pie'),
      contentTitle: 'Es hora de registrar tus gastos',
      summaryText: 'No olvides registrar los gastos del día',
      htmlFormatContent: true,
      htmlFormatTitle: true,
    );

    var androidDetails =
        AndroidNotificationDetails('1', 'name', styleInformation: bigImage);

    var platform = NotificationDetails(android: androidDetails);

    await _plugin.zonedSchedule(
      1,
      'Llegó el momento',
      'No olvides registrar tus gastos',
      scheduleDate,
      platform,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  cancelNotification() async {
    await _plugin.cancelAll();
  }
}
