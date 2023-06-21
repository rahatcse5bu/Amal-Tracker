// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;

// class NotificationsServices {
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   final AndroidInitializationSettings _androidInitializationSettings =
//       AndroidInitializationSettings('logo');
//   void initializeNotifications() async {
//     InitializationSettings _initializationSettings =
//         InitializationSettings(android: _androidInitializationSettings);
//     InitializationSettings(android: _androidInitializationSettings
//         // iOS: IOSInitializationSettings()
//         );
//     await _flutterLocalNotificationsPlugin.initialize(_initializationSettings);
//   }

//   notificationDetails() {
//     return const NotificationDetails(
//         android: AndroidNotificationDetails('channelId', 'channelName',
//             importance: Importance.max),
//         iOS: DarwinNotificationDetails());
//   }

//   Future<int> sendNotification(String title, String body) async {
//     NotificationDetails notificationDetails = NotificationDetails(
//       android: AndroidNotificationDetails(
//         "channelId",
//         "channelName",
//         importance: Importance.max,
//         priority: Priority.high,
//         // playSound: true,
//         // sound: RawResourceAndroidNotificationSound('notification'),
//       ),
//     );
//     await _flutterLocalNotificationsPlugin.show(
//         0, title, body, notificationDetails);
//         return 0;
//   }

//   // void scheduleNotification(String title, String body) async {
//   //   NotificationDetails notificationDetails = NotificationDetails(
//   //     android: AndroidNotificationDetails(
//   //       "channelId",
//   //       "channelName",
//   //       importance: Importance.max,
//   //       priority: Priority.high,
//   //       // playSound: true,
//   //       // sound: RawResourceAndroidNotificationSound('notification'),
//   //     ),
//   //   );
//   //   // await _flutterLocalNotificationsPlugin.show(
//   //   //     0, title, body, notificationDetails);

//   //   final now = DateTime.now();
//   //   final notificationTime = Time(23, 25); // Daily notification at 2:25 PM

//   //   // await _flutterLocalNotificationsPlugin.showDailyAtTime(
//   //   //   0,
//   //   //   title,
//   //   //   body,
//   //   //   notificationTime,
//   //   //   notificationDetails,
//   //   //   payload: 'Daily Notification',
//   //   // );

//   //   await _flutterLocalNotificationsPlugin.zonedSchedule(
//   //     0,
//   //     title,
//   //     body,
//   //     // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 30)),
//   //     tz.TZDateTime.from(
//   //         DateTime(now.year, now.month, now.day, 23, 25), tz.local),
//   //     notificationDetails,
//   //     uiLocalNotificationDateInterpretation:
//   //         UILocalNotificationDateInterpretation.wallClockTime,
//   //     androidAllowWhileIdle: true,
//   //     matchDateTimeComponents: DateTimeComponents.time,
//   //     payload: 'Daily Notification',
//   //   );
//   // }

//   Future scheduleNotification(
//       {int id = 0,
//       String? title,
//       String? body,
//       String? payLoad,
//       required DateTime scheduledNotificationDateTime}) async {
//     return _flutterLocalNotificationsPlugin.zonedSchedule(
//         id,
//         title,
//         body,
//         tz.TZDateTime.from(
//           scheduledNotificationDateTime,
//           tz.local,
//         ),
//         await notificationDetails(),
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime);
//   }
//   // Future<void> scheduleNotification(
//   //     {int id = 0,
//   //     required String title,
//   //     required String body,
//   //     required String payload,
//   //     required TimeOfDay scheduledTime}) async {
//   //   print("Notification Function Called " + scheduledTime.toString());
//   //   final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//   //   final tz.TZDateTime scheduledDateTime = tz.TZDateTime(
//   //     tz.local,
//   //     now.year,
//   //     now.month,
//   //     now.day,
//   //     scheduledTime.hour,
//   //     scheduledTime.minute,
//   //   );

//   //   final androidPlatformChannelSpecifics = AndroidNotificationDetails(
//   //     'channelId',
//   //     'channelName',
//   //     importance: Importance.max,
//   //     priority: Priority.high,
//   //   );
//   //   final platformChannelSpecifics = NotificationDetails(
//   //     android: androidPlatformChannelSpecifics,
//   //   );

//   //   await _flutterLocalNotificationsPlugin.zonedSchedule(
//   //     id,
//   //     title,
//   //     body,
//   //     scheduledDateTime,
//   //     platformChannelSpecifics,
//   //     androidAllowWhileIdle: true,
//   //     uiLocalNotificationDateInterpretation:
//   //         UILocalNotificationDateInterpretation.absoluteTime,
//   //     payload: payload,
//   //     matchDateTimeComponents: DateTimeComponents.time,
//   //   );
//   // }
// }
