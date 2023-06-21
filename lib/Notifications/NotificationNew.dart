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
        'time': '15:05',
        'title': 'Saturday Notification 1 Title',
        'body': 'St Notification 1 Body',
      },
      {
        'time': '15:08',
        'title': 'Saturday Notification 2 Title',
        'body': 'St Notification 2 Body',
      },
      {
        'time': '15:00',
        'title': 'Saturday Notification 3 Title',
        'body': 'Rahat Notification 3 Body',
      },
      {
        'time': '14:58',
        'title': 'Saturday Notification 4 Title',
        'body': 'Great Notification 4 Body',
      },
      {
        'time': '15:15',
        'title': 'Saturday Notification 5 Title',
        'body': 'Saturday Notification 5 Body',
      },
      {
        'time': '15:25',
        'title': 'Saturday Notification 5 Title',
        'body': 'Saturday Notification 5 Body',
      },
      {
        'time': '15:20',
        'title': 'Saturday Notification 5 Title',
        'body': 'Saturday Notification 5 Body',
      },
      {
        'time': '15:30',
        'title': 'Saturday Notification 5 Title',
        'body': 'Saturday Notification 5 Body',
      },
      {
        'time': '15:35',
        'title': 'Saturday Notification 5 Title',
        'body': 'Saturday Notification 5 Body',
      },
      {
        'time': '14:55',
        'title': 'Saturday Notification 6 Title',
        'body': 'Chill Notification 6 Body',
      },
      {
        'time': '15:40',
        'title': 'Saturday Notification 7 Title',
        'body': 'Saturday Notification 5 Body',
      },
      {
        'time': '15:55',
        'title': 'Saturday Notification 6 Title',
        'body': 'Chill Notification 6 Body',
      },
      {
        'time': '16:40',
        'title': 'Saturday Notification 7 Title',
        'body': 'Saturday Notification 5 Body',
      },
      {
        'time': '16:55',
        'title': 'Saturday Notification 6 Title',
        'body': 'Chill Notification 6 Body',
      },
      {
        'time': '17:00',
        'title': 'Saturday Notification 7 Title',
        'body': 'Saturday Notification 5 Body',
      },
      {
        'time': '17:55',
        'title': 'Saturday Notification 6 Title',
        'body': 'Chill Notification 6 Body',
      },
      {
        'time': '18:55',
        'title': 'Saturday Notification 6 Title',
        'body': 'Chill Notification 6 Body',
      },
      {
        'time': '19:00',
        'title': 'Saturday Notification 7 Title',
        'body': 'Saturday Notification 5 Body',
      },
      {
        'time': '19:55',
        'title': 'Saturday Notification 6 Title',
        'body': 'Chill Notification 6 Body',
      },
      {
        'time': '20:05',
        'title': 'Saturday Notification 6 Title',
        'body': 'Chill Notification 6 Body',
      },
      {
        'time': '22:05',
        'title': 'Saturday Notification 6 Title',
        'body': 'Chill Notification 6 Body',
      },
    ],
    DateTime.wednesday: [
      {
        'time': '03:00',
        'title': 'Wednesday Notification 1 Title',
        'body': 'Wednesday Notification 1 Body',
      },
      {
        'time': '06:00',
        'title': 'Wednesday Notification 2 Title',
        'body': 'Wednesday Notification 2 Body',
      },
      {
        'time': '09:00',
        'title': 'Wednesday Notification 3 Title',
        'body': 'Wednesday Notification 3 Body',
      },
      {
        'time': '12:00',
        'title': 'Wednesday Notification 4 Title',
        'body': 'Wednesday Notification 4 Body',
      },
      {
        'time': '20:00',
        'title': 'Wednesday Notification 5 Title',
        'body': 'Wednesday Notification 5 Body',
      },
      {
        'time': '23:23',
        'title': 'Wednesday Notification 6 Title',
        'body': 'Wednesday Notification 6 Body',
      },
    ],
  };

  for (final day in days) {
    final notifications = notificationsData[day];

    final DateTime nextDay = getNextWeekday(now, day);

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
    TimeOfDay(hour: 00, minute: 40): NotificationData(
      title: 'Notification 1 Title',
      body:
          "E beda 12:40 Bajjee.University of Barishal is a public university located in Barishal, a divisional city in southern Bangladesh. It is the country's 33rd public university. The university was established in 2011 and began academic activities at undergraduate level in six departments under four faculties on 24 January 201",
    ),
    TimeOfDay(hour: 00, minute: 45): NotificationData(
      title: 'Notification 2 Title',
      body: '12 ta 45 bajjje',
    ),
    TimeOfDay(hour: 00, minute: 50): NotificationData(
      title: 'Notification 1 Title',
      body: 'E beda 12:50 Bajjee',
    ),
    TimeOfDay(hour: 19, minute: 52): NotificationData(
      title: 'Notification 2 Title',
      body: '3 ta 16 bajjje',
    ),
    TimeOfDay(hour: 15, minute: 33): NotificationData(
      title: 'Notification 1 Title',
      body: 'E beda 3:33 Bajjee',
    ),
    TimeOfDay(hour: 15, minute: 59): NotificationData(
      title: 'Notification 2 Title',
      body: '3 ta 59 bajjje',
    ),
    TimeOfDay(hour: 16, minute: 58): NotificationData(
      title: 'Asr Namaj',
      body: 'Asr Namaj er jonno ready hon. Jamaat 5:15 te',
    ),
    TimeOfDay(hour: 17, minute: 35): NotificationData(
      title: 'Notification 4 Title',
      body: 'ahon 5:35 bajjeee monuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu',
    ),
    TimeOfDay(hour: 18, minute: 43): NotificationData(
      title: 'Maghrib Namaj',
      body: 'Maghrib er jamat e jan quickly. Jamat shuru hoiya jabee',
    ),
    TimeOfDay(hour: 19, minute: 44): NotificationData(
      title: 'Notification 6 Title',
      body: '7:44 bajje sir',
    ),
    TimeOfDay(hour: 20, minute: 33): NotificationData(
      title: 'Isha Namaj',
      body: 'Isha er jamaat e jao monu. 8:45 e jaaamt shuru hobe',
    ),
    TimeOfDay(hour: 22, minute: 33): NotificationData(
      title: 'Night',
      body: 'ekhon 10:33 bajje',
    ),
    TimeOfDay(hour: 22, minute: 53): NotificationData(
      title: 'Raat',
      body: '10:53 bajjeee sir',
    ),
    TimeOfDay(hour: 4, minute: 35): NotificationData(
      title: 'Fajr Namaj',
      body: 'Fajr er jammat e jao, Jamaat 4:45 e shuru hobe',
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
      body: '9:20 bajjje sir',
    ),
    TimeOfDay(hour: 10, minute: 30): NotificationData(
      title: 'Sokal ',
      body: '10:30 bajje monuuuuuuuuuuuuuuu',
    ),
    TimeOfDay(hour: 11, minute: 20): NotificationData(
      title: 'Dhur ',
      body: '11:20 bajjje sir',
    ),
    TimeOfDay(hour: 11, minute: 57): NotificationData(
      title: 'Dupur ',
      body: '11:57 bajje',
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
