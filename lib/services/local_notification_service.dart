import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationServices {
  LocalNotificationServices() {
    initialize();
    tz.initializeTimeZones();
  }

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future initialize() async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/icon');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleSleepNotification(String sleepTime) async {
    // Parse sleepTime string to get hour and minute
    List<String> timeParts = sleepTime.split(':');
    int hour = int.parse(timeParts[0].trim());
    int minute = int.parse(timeParts[1].split(' ')[0].trim());
    String period = timeParts[1].split(' ')[1].trim().toLowerCase();

    // Convert to 24-hour format
    if (period == 'pm' && hour != 12) {
      hour += 12;
    } else if (period == 'am' && hour == 12) {
      hour = 0;
    }
    final sleepDuration = hour * 60 + minute;

    final currentTime = DateTime.now();
    int currentHour = currentTime.hour;
    int currentMinute = currentTime.minute;

    final currentTimeDuration = currentHour * 60 + currentMinute;

    int sleepNotificationTime = 0;
    if (sleepDuration > currentTimeDuration) {
      sleepNotificationTime = sleepDuration - currentTimeDuration;
    } else {
      sleepNotificationTime = 1440 - (currentTimeDuration - sleepDuration);
    }

    print(sleepNotificationTime);

    // Schedule the notification
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      '1',
      'SleepChannel',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Time to Sleep!',
      'It\'s $sleepTime Time to go to sleep!',
      tz.TZDateTime.now(tz.local).add(Duration(minutes: sleepNotificationTime)),
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> scheduleExerciseNotification(String exerciseTime) async {
    // Parse sleepTime string to get hour and minute
    List<String> timeParts = exerciseTime.split(':');
    int hour = int.parse(timeParts[0].trim());
    int minute = int.parse(timeParts[1].split(' ')[0].trim());
    String period = timeParts[1].split(' ')[1].trim().toLowerCase();

    // Convert to 24-hour format
    if (period == 'pm' && hour != 12) {
      hour += 12;
    } else if (period == 'am' && hour == 12) {
      hour = 0;
    }
    final exerciseDuration = hour * 60 + minute;
    print(exerciseDuration);

    final currentTime = DateTime.now();
    int currentHour = currentTime.hour;
    int currentMinute = currentTime.minute;

    final currentTimeDuration = currentHour * 60 + currentMinute;
    print(currentTimeDuration);

    int exerciseNotificationTime = 0;

    if (exerciseDuration > currentTimeDuration) {
      exerciseNotificationTime = exerciseDuration - currentTimeDuration;
    } else {
      exerciseNotificationTime =
          1440 - (currentTimeDuration - exerciseDuration);
    }

    print(exerciseNotificationTime);

    // Schedule the notification
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      '2',
      'ExerciseChannel',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Time to Exercise!',
      'It\'s $exerciseTime Time to lose some calories!',
      tz.TZDateTime.now(tz.local)
          .add(Duration(minutes: exerciseNotificationTime)),
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
