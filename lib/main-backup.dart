// import 'dart:math';
// import 'dart:ui';

// import 'package:daily_amal_tracker/splash.dart';
// import 'package:flutter/material.dart';

// import 'package:expandable_text/expandable_text.dart';
// import 'package:get/get.dart';

// import 'package:intl/intl.dart';

// import 'Data/prayerData.dart';
// import 'Intro.dart';
// import 'Notifications/Notifications.dart';
// import 'Overview.dart';
// import 'confetti.dart';
// import 'dashboard.dart';
// import 'getGender.dart';
// import 'global.dart';
// import 'history.dart';

// //notification related
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:timezone/data/latest.dart' as tz;
// // import 'package:timezone/timezone.dart' as tz;

// import 'widgets/DuaScreen.dart';
// import 'package:cron/cron.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

// void scheduleTasks() {
//   AndroidAlarmManager.periodic(
//     const Duration(days: 1), // Execute daily
//     1, // Unique ID for each alarm
//     taskCallback,
//     wakeup: true,
//     exact: true,
//     startAt: DateTime.now()
//         .add(const Duration(seconds: 10)), // Start after 10 seconds
//   );
// }

// void taskCallback() {
//   print('Task executed!');
//   final now = DateTime.now();
//   if (now.hour == 3 && now.minute == 0) {
//     // Task for 3:00 AM
//     // Perform your task here
//   } else if (now.hour == 5 && now.minute == 23) {
//     // Task for 5:23 AM
//     // Perform your task here
//   } else if (now.hour == 20 && now.minute == 30) {
//     // Task for 8:30 PM
//     // Perform your task here
//   } else if (now.hour == 23 && now.minute == 3) {
//     // Task for 11:03 PM
//     // Perform your task here
//   } else if (now.hour == 22 && now.minute == 37) {
//     // Task for 9:55 PM
//     // Perform your task here
//     print("Time for Isha");
//     showNotification(
//         'Time for Isha', 'Time for Isha tesgahgyggyjsgyjsgyyjsgyjhsg ');
//   }
// }

// void initializeNotifications() {
//   AwesomeNotifications().initialize(
//     null,
//     [
//       NotificationChannel(
//         channelKey: 'basic_channel',
//         channelName: 'Basic Channel',
//         channelDescription: 'Basic notifications channel',
//         defaultColor: Color(0xFF9D50DD),
//         ledColor: Colors.white,
//       ),
//     ],
//   );
// }

// void showNotification(String title, String body) {
//   // String body = ;
//   AwesomeNotifications().createNotification(
//     content: NotificationContent(
//       id: 1,
//       channelKey: 'basic_channel',
//       title: title,
//       body: body,
//       backgroundColor: AppGlobal.PrimaryColor,
//       color: Colors.white,
//       fullScreenIntent: true,
//       showWhen: true,

//       //action button related

//       // category: NotificationCategory.,
//       // progress: 2,
//       // bigPicture:
//       //     'https://cdn.pixabay.com/photo/2020/04/22/00/11/muslim-5075080_1280.jpg',
//       notificationLayout: NotificationLayout.BigPicture,
//       displayOnForeground: true,
//       badge: 34,
//       summary: 'Summary of the notification',
//       roundedBigPicture: true,
//       actionType: ActionType.DismissAction,
//       // autoCancel: false,
//       wakeUpScreen: true,
//       autoDismissible: true,
//     ),
//   );
// }

// void checkNotificationPermission() async {
//   bool isGranted = await AwesomeNotifications().isNotificationAllowed();
//   if (!isGranted) {
//     await AwesomeNotifications().requestPermissionToSendNotifications();
//   }
// }

// // NotificationsServices notificationsServices = NotificationsServices();
// // void showNotification() {
// //   notificationsServices.sendNotification("Hello Arafat",
// //       "Tomar Deeni Boon der Valo hoiya Jete Bolo.... Tara etoh farmer keno?");
// // }

// // void showNotification5Sec() {
// //   notificationsServices.sendNotification("Hello Arafat [5 Min]",
// //       "Tomar Deeni Boon der Valo hoiya Jete Bolo.\n... Tara etoh farmer keno?");
// // }
// void printHello() {
//   print('Hello Rahat');
// }

// var x = 14;
// var y = 20;
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   initializeNotifications();
//   checkNotificationPermission();
//   await AndroidAlarmManager.initialize();
//   final now = DateTime.now();
//   final nextAlarmTime = DateTime(now.year, now.month, now.day, 23, 11);
//   if (nextAlarmTime.isBefore(now)) {
//     nextAlarmTime.add(const Duration(days: 1));
//   }

//   await AndroidAlarmManager.periodic(
//     const Duration(seconds: 10), // Interval between alarms (10 seconds)
//     0, // ID of the alarm (can be any unique value)
//     printHello, // Callback function to be executed
//     startAt: nextAlarmTime, // Start the alarm immediately
//     exact: true, // Trigger the alarm at exact intervals
//     wakeup: true, // Wake up the device when the alarm triggers
//   );
//   scheduleTasks();
//   // initializeNotifications();
//   final currentTime = DateTime.now();
//   final hour = currentTime.hour;
//   final minute = currentTime.minute;
//   final day = currentTime.day;
//   final monthFormat = DateFormat('MMMM');
//   final monthText = monthFormat.format(currentTime);
//   List<String> shahriTime =
//       getPrayerTiming(monthText, day.toString(), 'Shahri');
//   int shahriHour = int.parse(shahriTime[0]);
//   int shahriMinute = int.parse(shahriTime[1]);
//   List<String> fajrTime = getPrayerTiming(monthText, day.toString(), 'Fajr');
//   int fajrHour = int.parse(fajrTime[0]);
//   int fajrMinute = int.parse(fajrTime[1]);
//   List<String> sunriseTime =
//       getPrayerTiming(monthText, day.toString(), 'Sunrise');
//   int sunriseHour = int.parse(sunriseTime[0]);
//   int sunriseMinute = int.parse(sunriseTime[1]);
//   List<String> dhuhrTime = getPrayerTiming(monthText, day.toString(), 'Dhuhr');
//   int dhuhrHour = int.parse(dhuhrTime[0]);
//   int dhuhrMinute = int.parse(dhuhrTime[1]);
//   List<String> asrTime = getPrayerTiming(monthText, day.toString(), 'Asr');
//   int asrHour = int.parse(asrTime[0]);
//   int asrMinute = int.parse(asrTime[1]);
//   List<String> maghribTime =
//       getPrayerTiming(monthText, day.toString(), 'Maghrib');
//   int maghribHour = int.parse(maghribTime[0]);
//   int maghribMinute = int.parse(maghribTime[1]);
//   List<String> ishaTime = getPrayerTiming(monthText, day.toString(), 'Isha');
//   int ishaHour = int.parse(ishaTime[0]);
//   int ishaMinute = int.parse(ishaTime[1]);
//   // final cron = Cron();
//   // checkNotificationPermission();

//   // fajrMinute = 05;
//   // fajrHour = 18;
//   // sunriseMinute = 08;
//   // sunriseHour = 18;
// //   cron.schedule(Schedule.parse('${fajrMinute} ${fajrHour} * * *'), () {
// //     showNotification('Fajr Namaj[${fajrHour}:${fajrMinute}]',
// //         'Fajr er owakto shuru hoiche. Namaz Pore nin');
// //   });
// //   var fajr = addMinutesToTime(fajrTime[0] + ':' + fajrTime[1], 47);
// //   //split fajr time
// //   var fajrHour2 = fajr.split(':')[0];
// //   var fajrMinute2 = fajr.split(':')[1];
// //   cron.schedule(Schedule.parse('${fajrMinute2} ${fajrHour2} * * *'), () {
// //     showNotification('Fajr Namaj[${fajrHour2}:${fajrMinute2}]',
// //         'Fajr er namaj porun vai. Shomoy sesh hoye jacche');
// //   });
// //   print(currentTime.weekday);
// //   cron.schedule(Schedule.parse('${sunriseMinute} ${sunriseHour} * * *'), () {
// //     showNotification(
// //         'Sunrise[${sunriseHour}:${sunriseMinute}]', 'Surjo uthchee vai');
// //   });
// //   if (currentTime.weekday == DateTime.friday) {
// //     cron.schedule(Schedule.parse('30 12 * * *'), () {
// //       showNotification(
// //           'Jumuar Namaj', "Ajke Pobitro Jumua! Jumuar Namaj porte jaan");
// //     });
// //   } else {
// //     cron.schedule(Schedule.parse('${dhuhrMinute} ${dhuhrHour} * * *'), () {
// //       showNotification(
// //           'Dhuhr Namaj', "Dhuhur er owaktu shuru hoiya gese. Namaj porun");
// //     });
// //   }

// //   cron.schedule(Schedule.parse('${asrMinute} ${asrHour} * * *'), () {
// //     showNotification('Asr Namaj', 'Asr Er Owakto Shuru hoice. Namaj Porun');
// //   });
// //   var asr = addMinutesToTime(asrTime[0] + ':' + asrTime[1], 40);
// //   //split fajr time
// //   var asrHour2 = asr.split(':')[0];
// //   var asrMinute2 = asr.split(':')[1];

// //   cron.schedule(Schedule.parse('${asrMinute2} ${asrHour2} * * *'), () {
// //     showNotification('Asr Namaj', 'Asr Er Namaj Porun Please');
// //   });
// //   cron.schedule(Schedule.parse('${maghribMinute} ${maghribHour} * * *'), () {
// //     showNotification('Maghrib Namaj', 'Maghrib er Namaj Shuru Hoiche');
// //   });
// //   cron.schedule(Schedule.parse('${ishaMinute} ${ishaHour} * * *'), () {
// //     showNotification('Isha Namaj', 'Isha er Namaj Shuru Hoiche');
// //   });
// //   var isha = addMinutesToTime(ishaTime[0] + ':' + ishaTime[1], 40);
// //   //split fajr time
// //   var ishaHour2 = asr.split(':')[0];
// //   var ishaMinute2 = asr.split(':')[1];
// //   cron.schedule(Schedule.parse('${ishaMinute2} ${ishaHour2} * * *'), () {
// //     showNotification('Isha Namaj', 'Isha er Namaj Jamamt e chole jaan quickly');
// //   });
// //   cron.schedule(Schedule.parse('${shahriMinute} ${shahriHour} * * *'), () {
// //     showNotification('Shahri', 'Shahrir Shomoy Sesh Vai');
// //   });

// // //Monday Fasting Starts
// //   cron.schedule(Schedule.parse('0 15 * * 0'), () {
// //     showNotification('Monday Fasting', 'Agamikale Sombar Roja Rakha Sunnah');
// //   });

// //   cron.schedule(Schedule.parse('0 22 * * 0'), () {
// //     showNotification('Monday Fasting', 'Agamikale Sombar Roja Rakha Sunnah');
// //   });
// //   cron.schedule(Schedule.parse('20 23 * * 0'), () {
// //     showNotification('Monday Fasting', 'Agamikale Sombar Roja Rakha Sunnah');
// //   });

// // //Monday Fasting Ends
// // //Thusday Fasting Starts
// //   cron.schedule(Schedule.parse('0 15 * * 3'), () {
// //     showNotification(
// //         'Thusday Fasting', 'Agamikale Brihospotibar Roja Rakha Sunnah');
// //   });

// //   cron.schedule(Schedule.parse('0 22 * * 3'), () {
// //     showNotification(
// //         'Thusday Fasting', 'Agamikale Brihospotibar Roja Rakha Sunnah');
// //   });
// //   cron.schedule(Schedule.parse('18 23 * * 3'), () {
// //     showNotification(
// //         'Thusday Fasting', 'Agamikale Brihospotibar Roja Rakha Sunnah');
// //   });

// // //Thusday Fasting Ends

// // // Friday Reminder Starts
// //   cron.schedule(Schedule.parse('18 9 * * 5'), () {
// //     showNotification('Friday Dorood', "Jumma er din dorood porun");
// //   });
// //   cron.schedule(Schedule.parse('10 10 * * 5'), () {
// //     showNotification('Friday Khahf', "Jumma er din Surah Kahf Porun");
// //   });
// //   cron.schedule(Schedule.parse('28 11 * * 5'), () {
// //     showNotification('Friday Khahf & Dorud', "Jumma er din dorood porun");
// //   });
// //   cron.schedule(Schedule.parse('08 12 * * 5'), () {
// //     showNotification('Jumuar Namaj', "Jumua er swalat e jaan vai");
// //   });
// //   cron.schedule(Schedule.parse('18 14 * * 5'), () {
// //     showNotification('Friday Khahf', "Jumma er din dorood porun");
// //   });
// //   cron.schedule(Schedule.parse('02 15 * * 5'), () {
// //     showNotification('Friday Khahf', "Jumma er din dorood and kahf porun");
// //   });
// //   cron.schedule(Schedule.parse('20 17 * * 5'), () {
// //     showNotification('Friday Dua', "Jumma er din Asr er por dua kobul hoy");
// //   });
// //   cron.schedule(Schedule.parse('52 17 * * 5'), () {
// //     showNotification('Friday Dua', "Jumma er din Asr er por dua kobul hoy");
// //   });
// //   cron.schedule(Schedule.parse('*/5 * * * *'), () {
// //     showNotification(
// //         'Friday Dorood [1]', "Jumma er din Beshi Beshi Dorood Porun");
// //   });
// //Friday Reminder Ends

//   // cron.schedule(Schedule.parse('*/1 * * * *'), () {
//   //   calculateIshaJamaat('7:10', 30);
//   //   calculateIshaJamaat('8:11', 30);
//   //   calculateIshaJamaat('7:32', 30);
//   //   calculateIshaJamaat('7:20', 30);
//   //   calculateIshaJamaat('8:19', 30);
//   // });

//   // cron.schedule(Schedule.parse('${y} ${x} * * *'),
//   // cron.schedule(Schedule.parse('*/1 * * * *'), () {
//   //   print('hello');
//   // print(getPrayerTiming(monthText, '3', 'Fajr'));
//   // print(getPrayerTiming(monthText, '14', 'Fajr'));
//   // print(getPrayerTiming(monthText, '21', 'Sunrise'));
//   // print(getPrayerTiming(monthText, '14', 'Shahri'));
//   // print(getPrayerTiming(monthText, '21', 'Asr'));
//   // print(getPrayerTiming(monthText, '2', 'Dhuhr'));
//   // print(getPrayerTiming(monthText, '2', 'Dhuhr')[0]);
//   // print(getPrayerTiming(monthText, '2', 'Dhuhr')[1]);

//   // // print all the above
//   // print('hour: $hour');
//   // print('minute: $minute');
//   // print('day: $day');
//   // print('month: $monthText');
//   // print(addMinutesToTime(
//   //     getPrayerTiming('June', '2', 'Dhuhr')[0] +
//   //         ':' +
//   //         getPrayerTiming('June', '2', 'Dhuhr')[1],
//   //     25));
//   //   print('Fajr Time: ${fajrTime[0]}:${fajrTime[1]}');
//   //   print('Sunrise Time: ${sunriseTime[0]}:${sunriseTime[1]}');
//   //   print('Dhuhr Time: ${dhuhrTime[0]}:${dhuhrTime[1]}');
//   //   print('Asr Time: ${asrTime[0]}:${asrTime[1]}');
//   //   print('Maghrib Time: ${maghribTime[0]}:${maghribTime[1]}');

//   //   print('Isha Time: ${ishaTime[0]}:${ishaTime[1]}');
//   //   print('Shahri Time: ${shahriTime[0]}:${shahriTime[1]}');
//   // });

//   // cron.schedule(Schedule.parse('51 10 * * *'), showNotification); // 11:55 PM

//   // final currentTime = DateTime.now();
//   // final dynamicTime = currentTime.add(Duration(minutes: 1));

//   // final cronExpression = '${dynamicTime.minute} ${dynamicTime.hour} * * *';

//   // cron.schedule(Schedule.parse(cronExpression), () {
//   //   showNotification();
//   // });
//   // cron.schedule(Schedule.parse('*/1 * * * *'), () {
//   //   showNotification("E beda", "eda 1 minutes por por");
//   // });

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Dashboard_Old(),
//       initialRoute: '/splash',
//       // initialRoute: '/history',
//       // initialRoute: '/dashboard',
//       // initialRoute: '/intro',
//       // initialRoute: '/confetti',
//       // initialRoute: '/dua',
//       routes: {
//         // '/splash': (context) => SplashScreenPage(),
//         '/splash': (context) => SplashScreen(),
//         // '/initData': (context) => initData(),
//         '/dashboard': (context) => Dashboard(isHistory: false),
//         '/getGender': (context) => GetGender(),
//         '/history': (context) => History(),
//         '/overview': (context) => Overview(),
//         '/confetti': (context) => ConfettiPoints(),
//         '/intro': (context) => Intro(),
//         '/dua': (context) => DuaScreen(),
//       },
//       //  RamadanPlanner(),
//     );
//   }
// }

// class Dashboard_Old extends StatefulWidget {
//   const Dashboard_Old({super.key});

//   @override
//   State<Dashboard_Old> createState() => _Dashboard_OldState();
// }

// class _Dashboard_OldState extends State<Dashboard_Old> {
//   List<int> ramadanList = List.generate(30, (index) => index + 1);
//   final _random = new Random();
//   var todays_ayat;
//   var todays_hadith;
//   var todays_salaf_qoute;

//   //end debug
//   @override
//   void initState() {
//     // todays_ayat = AjkerAyat[_random.nextInt(AjkerAyat.length)];
//     // todays_hadith = AjkerHadith[_random.nextInt(AjkerHadith.length)];
//     // todays_salaf_qoute = SalafQoutes[_random.nextInt(SalafQoutes.length)];
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'রমাদ্বন প্লানার',
//           style: TextStyle(fontSize: 25),
//         ),
//         backgroundColor: AppGlobal.PrimaryColor,
//         centerTitle: true,
//       ),
//       body: Container(),
// //       SingleChildScrollView(
// //         scrollDirection: Axis.vertical,
// //         child: Container(
// //           child: Column(children: [
// // //asset image  full width of the screen
// //             // Container(
// //             //   width: MediaQuery.of(context).size.width * .93,
// //             //   height: 250,
// //             //   child: Image.asset(
// //             //     'images/ramadan.jpg',
// //             //     fit: BoxFit.contain,
// //             //   ),
// //             // ),

// //             Container(
// //               // width: MediaQuery.of(context).size.width * .53,
// //               // height: 250, width: 150,
// //               child: Column(
// //                 children: [
// //                   Container(
// //                     // width: 160,
// //                     child: Card(
// //                       elevation: 5.2,
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(8.0),
// //                       ),
// //                       child: Padding(
// //                         padding: EdgeInsets.symmetric(
// //                             horizontal: 10.0, vertical: 20.0),
// //                         child: Column(
// //                           children: [
// //                             Container(
// //                               padding: EdgeInsets.symmetric(
// //                                   vertical: 10, horizontal: 10),
// //                               margin: EdgeInsets.only(bottom: 5),
// //                               width: MediaQuery.of(context).size.width,
// //                               decoration: BoxDecoration(
// //                                   borderRadius: BorderRadius.only(
// //                                       topLeft: Radius.circular(6),
// //                                       topRight: Radius.circular(6)),
// //                                   color: AppGlobal.PrimaryColor),
// //                               child: Center(
// //                                 child: Text(
// //                                   "নির্বাচিত আয়াত",
// //                                   style: TextStyle(
// //                                       // fontStyle: FontStyle.italic,
// //                                       fontSize: 20,
// //                                       color: Colors.white),
// //                                 ),
// //                               ),
// //                             ),
// //                             // Divider(
// //                             //   color: AppColors.PrimaryColor,
// //                             //   thickness: 1.0,
// //                             // ),
// //                             ExpandableText(
// //                               todays_ayat.toString(),
// //                               expandText: 'show more',
// //                               collapseText: 'show less',
// //                               maxLines: 4,
// //                               linkColor: Colors.blue,
// //                               style: TextStyle(
// //                                   fontStyle: FontStyle.italic, fontSize: 12),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                   Container(
// //                     // width: 180,
// //                     child: Card(
// //                       elevation: 5.2,
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(8.0),
// //                       ),
// //                       child: Padding(
// //                         padding: EdgeInsets.symmetric(
// //                             horizontal: 10.0, vertical: 20.0),
// //                         child: Column(
// //                           children: [
// //                             Container(
// //                               padding: EdgeInsets.symmetric(
// //                                   vertical: 10, horizontal: 10),
// //                               margin: EdgeInsets.only(bottom: 5),
// //                               width: MediaQuery.of(context).size.width,
// //                               decoration: BoxDecoration(
// //                                   borderRadius: BorderRadius.only(
// //                                       topLeft: Radius.circular(6),
// //                                       topRight: Radius.circular(6)),
// //                                   color: AppGlobal.PrimaryColor),
// //                               child: Center(
// //                                 child: Text(
// //                                   "নির্বাচিত হাদিস",
// //                                   style: TextStyle(
// //                                       // fontStyle: FontStyle.italic,
// //                                       fontSize: 20,
// //                                       color: Colors.white),
// //                                 ),
// //                               ),
// //                             ),
// //                             // Divider(
// //                             //   color: AppColors.PrimaryColor,
// //                             //   thickness: 1.0,
// //                             // ),
// //                             ExpandableText(
// //                               todays_hadith.toString(),
// //                               expandText: 'show more',
// //                               collapseText: 'show less',
// //                               maxLines: 4,
// //                               linkColor: Colors.blue,
// //                               style: TextStyle(
// //                                   fontStyle: FontStyle.italic, fontSize: 12),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                   Container(
// //                     // width: 180,
// //                     child: Card(
// //                       elevation: 5.2,
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(8.0),
// //                       ),
// //                       child: Padding(
// //                         padding: EdgeInsets.symmetric(
// //                             horizontal: 10.0, vertical: 20.0),
// //                         child: Column(
// //                           children: [
// //                             Container(
// //                               padding: EdgeInsets.symmetric(
// //                                   vertical: 10, horizontal: 10),
// //                               margin: EdgeInsets.only(bottom: 5),
// //                               width: MediaQuery.of(context).size.width,
// //                               decoration: BoxDecoration(
// //                                   borderRadius: BorderRadius.only(
// //                                       topLeft: Radius.circular(6),
// //                                       topRight: Radius.circular(6)),
// //                                   color: AppGlobal.PrimaryColor),
// //                               child: Center(
// //                                 child: Text(
// //                                   "সালাফদের বক্তব্য",
// //                                   style: TextStyle(
// //                                       // fontStyle: FontStyle.italic,
// //                                       fontSize: 20,
// //                                       color: Colors.white),
// //                                 ),
// //                               ),
// //                             ),
// //                             // Divider(
// //                             //   color: AppColors.PrimaryColor,
// //                             //   thickness: 1.0,
// //                             // ),
// //                             ExpandableText(
// //                               todays_salaf_qoute.toString(),
// //                               expandText: 'show more',
// //                               collapseText: 'show less',
// //                               maxLines: 4,
// //                               linkColor: Colors.blue,
// //                               style: TextStyle(
// //                                   fontStyle: FontStyle.italic, fontSize: 12),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             SizedBox(height: 10.0),

// //             // Text('Dashboard'),
// //             // Listtile with Card elevation 5.2 and border radius 10.0
// //             for (var i = 0; i < ramadanList.length; i++) ...[
// //               Card(
// //                 elevation: 7.2,
// //                 shape: RoundedRectangleBorder(
// //                   side: i + 1 <= calculate2023RamdanDate() &&
// //                           current_month == "Ramadan"
// //                       ? BorderSide(color: AppColors.PrimaryColor, width: 1)
// //                       : BorderSide(color: Colors.white, width: 1),
// //                   borderRadius: BorderRadius.circular(10.0),
// //                 ),
// //                 child: ListTile(
// //                   // border radius with cliprrect  and color with ternary operator
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(8.0),
// //                   ),
// //                   tileColor: i + 1 > 20 ? Colors.grey[250] : Colors.white,
// //                   title: i + 1 == calculate2023RamdanDate() &&
// //                           current_month == "Ramadan"
// //                       ? Text('রমাদ্বন - ${ramadanList[i]} (আজ) ')
// //                       : i + 1 > 20
// //                           ? Text(
// //                               'রমাদ্বন - ${ramadanList[i]} ',
// //                               style: TextStyle(
// //                                   color: AppGlobal.PrimaryColor,
// //                                   fontWeight: FontWeight.bold),
// //                             )
// //                           : Text('রমাদ্বন - ${ramadanList[i]} '),
// //                   subtitle: i + 1 > 20
// //                       ? Text(
// //                           'রমাদ্বন প্লান করুন',
// //                           style: TextStyle(
// //                               color: AppColors.PrimaryColor,
// //                               fontWeight: FontWeight.bold),
// //                         )
// //                       : Text('রমাদ্বন প্লান করুন'),
// //                   trailing: i + 1 > 20
// //                       ? i + 1 == 21 ||
// //                               i + 1 == 23 ||
// //                               i + 1 == 25 ||
// //                               i + 1 == 27 ||
// //                               i + 1 == 29
// //                           ? Icon(
// //                               Icons.diamond_rounded,
// //                               color: AppGlobal.PrimaryColor,
// //                             )
// //                           : Icon(
// //                               Icons.arrow_forward_ios,
// //                               color: AppGlobal.PrimaryColor,
// //                             )
// //                       : Icon(Icons.arrow_forward_ios),
// //                   onTap: () {
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                           builder: (context) =>
// //                               RamadanPlanner(ramadan_day: i + 1)),
// //                     );
// //                   },
// //                 ),
// //               ),
// //             ]
// //           ]),
// //         ),
// //       ),
//     );
//   }
// }
