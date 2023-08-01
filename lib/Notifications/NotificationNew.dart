import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> scheduleWeeklyDailyNotifications() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('logo');
  // final IOSInitializationSettings initializationSettingsIOS =
  //     IOSInitializationSettings();
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    // iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    // 'your_channel_description',
    importance: Importance.max,
    priority: Priority.high,
    category: AndroidNotificationCategory.alarm,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  final DateTime now = DateTime.now();
  final List<int> days = [DateTime.saturday, DateTime.wednesday];

  final Map<int, List<Map<String, String>>> notificationsData = {
    DateTime.saturday: [
      {
        'time': '20:15',
        'title': 'Saturday [20:15]',
        'body': 'St Notification Body Here',
      },
      {
        'time': '15:08',
        'title': 'Saturday [3:08]',
        'body': 'St Notification Body',
      },
      {
        'time': '15:00',
        'title': 'Saturday [3:00]',
        'body': 'Notification Body',
      },
      {
        'time': '14:58',
        'title': 'Saturday [2:58]',
        'body': 'Great Notification Body',
      },
      {
        'time': '15:15',
        'title': 'Saturday [3:15]',
        'body': 'Saturday Testing Body',
      },
      {
        'time': '15:25',
        'title': 'Saturday [3:25] ',
        'body': 'Saturday  Body',
      },
      {
        'time': '15:20',
        'title': 'Saturday [3:20]',
        'body': 'Saturday Notification  Body',
      },
      {
        'time': '15:30',
        'title': 'Saturday [3:30]',
        'body': 'Saturday Notification Body',
      },
      {
        'time': '15:35',
        'title': 'Saturday  [3:35]',
        'body': 'Saturday Notification Body',
      },
      {
        'time': '14:55',
        'title': 'Saturday  [2:55]',
        'body': 'Chill Notification Body',
      },
      {
        'time': '15:40',
        'title': 'Saturday  [3:40]',
        'body': 'Saturday Notification  Body',
      },
      {
        'time': '15:55',
        'title': 'Saturday [3:55]',
        'body': 'Chill Notification Body',
      },
      {
        'time': '16:40',
        'title': 'Saturday  [4:40]',
        'body': 'Saturday Notification Body',
      },
      {
        'time': '16:55',
        'title': 'Saturday [4:55]',
        'body': 'Chill Notification Body',
      },
      {
        'time': '17:00',
        'title': 'Saturday [5:00]',
        'body': 'Saturday Notification  Body',
      },
      {
        'time': '17:55',
        'title': 'Saturday  [5:55]',
        'body': 'Chill Notification Body',
      },
      {
        'time': '18:55',
        'title': 'Saturday  [6:55]',
        'body': 'Chill Notification 6 Body',
      },
      {
        'time': '19:00',
        'title': 'Saturday  [7:00]',
        'body': 'Agamikalke Robibar , Porsu Roja Raikhen',
      },
      {
        'time': '19:55',
        'title': 'Saturday [7:55]',
        'body': 'Chill Notification  Body',
      },
      {
        'time': '20:05',
        'title': 'Saturday [8:05]',
        'body': 'Chill Notification Body',
      },
      {
        'time': '22:05',
        'title': 'Saturday [10:05]',
        'body': 'Have a Relax Notification Body',
      },
    ],
    DateTime.wednesday: [
      {
        'time': '20:28',
        'title': 'Wednesday  [8:28]',
        'body': 'Wednesday Notification  Body',
      },
      {
        'time': '06:00',
        'title': 'Wednesday [6:00] ',
        'body': 'Wednesday Notification Body',
      },
      {
        'time': '09:00',
        'title': 'Wednesday [9:00]',
        'body': 'Wednesday Notification Body',
      },
      {
        'time': '12:00',
        'title': 'Wednesday [12:00]',
        'body': 'Wednesday Notification  Body',
      },
      {
        'time': '20:00',
        'title': 'Wednesday [8:00]',
        'body': 'Wednesday Notification  Body',
      },
      {
        'time': '23:23',
        'title': 'Wednesday [11:23]',
        'body': 'Wednesday Notification Body',
      },
    ],
  };

  for (final day in days) {
    final notifications = notificationsData[day];

    final DateTime nextDay = getNextWeekday(now, day);
    print('nextDay: $nextDay');
    for (final notification in notifications!) {
      final time = notification['time']!;
      final title = notification['title']!;
      final body = notification['body']!;

      final List<int> timeParts = time.split(':').map(int.parse).toList();

      final DateTime scheduledTime = DateTime(
        nextDay.year,
        nextDay.month,
        nextDay.day,
        timeParts[0],
        timeParts[1],
      );

      if (scheduledTime.isBefore(now)) {
        scheduledTime.add(const Duration(days: 7));
      }

      await flutterLocalNotificationsPlugin.zonedSchedule(
        scheduledTime.hashCode, // Notification ID
        title,
        body,
        tz.TZDateTime.from(scheduledTime, tz.local),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }
}

DateTime getNextWeekday(DateTime now, int desiredWeekday) {
  final int currentWeekday = now.weekday;
  int difference = desiredWeekday - currentWeekday;
  if (difference <= 0) {
    difference += 7;
  }
  return now.add(Duration(days: difference));
}

Future<void> scheduleDailyNotifications() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('logo');
  final DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings();
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    // 'your_channel_description',
    importance: Importance.max,
    priority: Priority.high,
    category: AndroidNotificationCategory.alarm,
    enableVibration: true,
    playSound: true,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  final DateTime now = DateTime.now();
  final Map<TimeOfDay, NotificationData> notificationsData = {
    TimeOfDay(hour: 20, minute: 40): NotificationData(
      title: 'Night Prayer',
      body: "It's 8:40 PM, Time to go for prayer",
    ),
    TimeOfDay(hour: 20, minute: 45): NotificationData(
      title: 'Night Prayer',
      body: "8 ta 45 bajjje, Jama'at Shuru",
    ),
    TimeOfDay(hour: 20, minute: 15): NotificationData(
      title: 'Night',
      body: '8:15 Bajjee',
    ),
    TimeOfDay(hour: 20, minute: 20): NotificationData(
      title: 'Night',
      body: '8 ta 20 bajjje',
    ),
    TimeOfDay(hour: 20, minute: 23): NotificationData(
      title: 'Night',
      body: 'Vai 8:23 Bajjee',
    ),
    TimeOfDay(hour: 20, minute: 25): NotificationData(
      title: 'Night',
      body: '8 ta 25 bajjje',
    ),
    TimeOfDay(hour: 20, minute: 30): NotificationData(
      title: 'Isha Namaj',
      body: 'Isha Namaj er jonno ready hon. Jamaat 8:45 e',
    ),
    TimeOfDay(hour: 21, minute: 35): NotificationData(
      title: 'Isha Prayer',
      body: 'akhon 9:35 bajjeee . Quickly Ready hon',
    ),
    TimeOfDay(hour: 21, minute: 43): NotificationData(
      title: 'Night ',
      body: "Hello there, it's 9:43 PM",
    ),
    TimeOfDay(hour: 22, minute: 44): NotificationData(
      title: 'Night',
      body: '10:44 bajje sir',
    ),
    TimeOfDay(hour: 20, minute: 33): NotificationData(
      title: 'Isha Namaj',
      body: 'Isha er jamaat e jaan. 8:45 e jaaamt shuru hobe',
    ),
    TimeOfDay(hour: 22, minute: 43): NotificationData(
      title: 'Night',
      body: 'ekhon 10:43 bajje',
    ),
    TimeOfDay(hour: 22, minute: 53): NotificationData(
      title: 'Raat',
      body: '10:53 bajjeee akhon',
    ),
    TimeOfDay(hour: 4, minute: 35): NotificationData(
      title: 'Fajr Namaj',
      body: 'Fajr er jammat e jaan, Jamaat 4:45 e shuru hobe',
    ),
    TimeOfDay(hour: 5, minute: 20): NotificationData(
      title: 'Fajr ',
      body: '5:20 bajjje sir',
    ),
    TimeOfDay(hour: 5, minute: 30): NotificationData(
      title: 'Fajr ',
      body: '5:30 bajje',
    ),
    TimeOfDay(hour: 9, minute: 20): NotificationData(
      title: 'Sokal ',
      body: 'Sokal 9:20 bajjje sir',
    ),
    TimeOfDay(hour: 10, minute: 30): NotificationData(
      title: 'Sokal ',
      body: '10:30 bajje vai',
    ),
    TimeOfDay(hour: 11, minute: 20): NotificationData(
      title: 'Dhuhr ',
      body: '11:20 bajjje sir',
    ),
    TimeOfDay(hour: 11, minute: 57): NotificationData(
      title: 'Dupur ',
      body: '11:57 bajje',
    ),
    TimeOfDay(hour: 12, minute: 57): NotificationData(
      title: 'Dupur ',
      body: '12:57 bajje',
    ),
  };

  for (final entry in notificationsData.entries) {
    final time = entry.key;
    final notificationData = entry.value;

    final DateTime scheduledTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    if (scheduledTime.isBefore(now)) {
      scheduledTime.add(const Duration(days: 1));
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      time.hashCode, // Notification ID
      notificationData.title,
      notificationData.body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      // androidScheduleMode: AndroidScheduleMode.,

      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}

Future<void> initializeNotifications() async {
  tz.initializeTimeZones();
}

class NotificationData {
  final String title;
  final String body;

  NotificationData({required this.title, required this.body});
}
