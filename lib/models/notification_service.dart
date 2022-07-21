import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

import '../routes/app_router.dart';

class CustomNotification {
  final int id;
  final String? title;
  final String? body;
  final String? payload;

  CustomNotification(
    this.id,
    this.title,
    this.body,
    this.payload,
  );
}

class NotificationService {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;

  NotificationService() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setUpNotifications();
  }

  _setUpNotifications() async {
    await _setUpTimeZone();

    await _initializeNotifications();
  }

  Future<void> _setUpTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  _initializeNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/launcher_icon');
    await localNotificationsPlugin.initialize(
      const InitializationSettings(
        android: android,
      ),
      onSelectNotification: _onSelectNotification,
    );
  }

  _onSelectNotification(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      Navigator.of(Routes.navigatorKey.currentContext!).pushNamed('/$payload');
    }
  }

  showNotification(CustomNotification notification) {
    androidDetails = AndroidNotificationDetails(
      notification.id.toString(),
      'Habitos',
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
    );

    localNotificationsPlugin.show(
      notification.id,
      notification.title,
      notification.body,
      NotificationDetails(
        android: androidDetails,
      ),
      payload: notification.payload,
    );
  }

  tz.TZDateTime _nextInstanceOfTime(String time) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      int.parse(time.substring(0, 2)),
      int.parse(time.substring(3, 5)),
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> removeNotification(int id) async {
    await localNotificationsPlugin.cancel(id);
  }

  Future<void> scheduleDailyNotification(
    CustomNotification notification,
    String time,
  ) async {
    await localNotificationsPlugin.zonedSchedule(
      notification.id,
      notification.title,
      notification.body,
      _nextInstanceOfTime(time),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily notification channel id',
          'daily notification channel name',
          channelDescription: 'daily notification description',
          importance: Importance.max,
          priority: Priority.max,
          enableVibration: true,
        ),
      ),
      payload: notification.payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> scheduleWeeklyNotification(
    CustomNotification notification,
    String time,
    int day,
  ) async {
    await localNotificationsPlugin.zonedSchedule(
      notification.id,
      notification.title,
      notification.body,
      _scheduleWeekly(time, day),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'dailya notification channel id',
          'dailya notification channel name',
          channelDescription: 'dailya notification description',
          importance: Importance.max,
          priority: Priority.max,
          enableVibration: true,
        ),
      ),
      payload: notification.payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  tz.TZDateTime _scheduleWeekly(String time, int day) {
    tz.TZDateTime scheduledDate = _nextInstanceOfTime(time);
    while (scheduledDate.weekday != day) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  checkForNotification() async {
    final details =
        await localNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      _onSelectNotification(details.payload);
    }
  }

  cancelAllNotifications() async {
    await localNotificationsPlugin.cancelAll();
  }
}
