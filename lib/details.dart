import 'package:daily_amal_tracker/Data/data.dart';
import 'package:daily_amal_tracker/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'db.dart';
import 'global.dart';
import 'history.dart';
import 'widgets/Asr.dart';
import 'widgets/Dhuhr.dart';
import 'widgets/Fajr.dart';
import 'widgets/Fazayel.dart';
import 'widgets/General.dart';
import 'widgets/Isha.dart';
import 'widgets/Maghrib.dart';
import 'widgets/Quran.dart';

class Details extends StatefulWidget {
  Details({super.key, required this.amal_date, required this.id});
  String amal_date;
  String id;
  @override
  State<Details> createState() => _DetailsState();
}

class TrackingItem {
  // final dbHelper = DatabaseHelper.instance;
  final String title;
  final IconData icon;
  final String trackingWidget;
  final double progressPercent;

  TrackingItem(
      {required this.title,
      required this.icon,
      required this.trackingWidget,
      required this.progressPercent});
}

class _DetailsState extends State<Details> {
  final List<TrackingItem> trackingItems = [
    TrackingItem(
      title: 'ফজর ট্রাকি',
      icon: Icons.alarm,
      trackingWidget: 'Fajr',
      progressPercent: 0.0,
    ),
    TrackingItem(
      title: 'যোহর ট্রাকিং',
      icon: Icons.access_time,
      trackingWidget: 'Dhuhr',
      progressPercent: 0.0,
    ),
    TrackingItem(
      title: 'দৈনন্দিন কার্যক্রম',
      icon: Icons.track_changes,
      trackingWidget: 'General',
      progressPercent: 0.0,
    ),
    TrackingItem(
      title: 'আসর ট্রাকিং',
      icon: Icons.schedule,
      trackingWidget: 'Asr',
      progressPercent: 0.0,
    ),
    TrackingItem(
      title: 'মাগরিব ট্রাকিং',
      icon: Icons.timer,
      trackingWidget: 'Maghrib',
      progressPercent: 0.0,
    ),
    TrackingItem(
      title: 'ইশা ট্রাকিং',
      icon: Icons.bedtime,
      trackingWidget: 'Isha',
      progressPercent: 0.0,
    ),
    TrackingItem(
      title: "ফাযায়েলে 'আমাল",
      icon: Icons.point_of_sale,
      trackingWidget: 'Fazayel',
      progressPercent: 0.0,
    ),
    TrackingItem(
      title: 'অন্যান্য বিষয়াবলী',
      icon: Icons.import_export_sharp,
      trackingWidget: 'Fajr',
      progressPercent: 0.0,
    ),
    // TrackingItem(
    //   title: 'Maswala Tracking',
    //   icon: Icons.question_answer,
    //   trackingWidget: 'Maswala',
    //   progressPercent: 0.0,
    // ),
    // TrackingItem(
    //   title: 'Dua Tracking',
    //   icon: Icons.chat,
    //   trackingWidget: 'Dua',
    //   progressPercent: 0.0,
    // ),
  ];
  final dbHelper = DatabaseHelper.instance;
  int todaysPoint = 0;

  // String formattedStringDate =
  //     '${DateTime.now().day.toString().padLeft(2, '0')} ${DateFormat.MMM().format(DateTime.now())} ${DateTime.now().year}';
  String formattedStringDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  double progressPercent = 0;
  List<Map<String, dynamic>>? modifiedFajrItems = [];
  List<Map<String, dynamic>>? modifiedDhuhrItems = [];
  List<Map<String, dynamic>>? modifiedGeneralItems = [];
  List<Map<String, dynamic>>? modifiedAsrItems = [];
  List<Map<String, dynamic>>? modifiedMaghribItems = [];
  List<Map<String, dynamic>>? modifiedIshaItems = [];
  List<Map<String, dynamic>>? modifiedFazayelItems = [];

  @override
  void initState() {
    super.initState();
    // getAchievedPointsByTitle('Fajr');
    dbHelper
        .getTodaysPoint('Fajr', widget.amal_date.toString())
        .then((fajrResult) {
      todaysPoint += fajrResult;
      return dbHelper.getTodaysPoint('Dhuhr', widget.amal_date.toString());
    }).then((dhuhrResult) {
      todaysPoint += dhuhrResult;
      return dbHelper.getTodaysPoint('General', widget.amal_date.toString());
    }).then((generalResult) {
      todaysPoint += generalResult;
      return dbHelper.getTodaysPoint('Asr', widget.amal_date.toString());
    }).then((asrResult) {
      todaysPoint += asrResult;
      return dbHelper.getTodaysPoint('Maghrib', widget.amal_date.toString());
    }).then((maghribResult) {
      todaysPoint += maghribResult;
      return dbHelper.getTodaysPoint('Isha', widget.amal_date.toString());
    }).then((ishaResult) {
      todaysPoint += ishaResult;
      print('Total points for today: $todaysPoint');

      setState(() {
        // todaysPoint = ishaResult;
      });
      // todaysPoint = todaysPoint;
    });

    // setState(() {
    //   progressPercent =
    //       dbHelper.calculateTotalAchievedPoints(modifiedFajrItems!) /
    //           dbHelper.calculateAvailablePoints(Fajr_Items);
    //   print('progressPercent: $progressPercent');
    // });
  }

  List<String> myTableNames = [
    'Fajr',
    'Dhuhr',
    'General',
    'Asr',
    'Maghrib',
    'Isha',
    'Fazayel',
    'Fajr'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.amal_date}'),
          centerTitle: true,
          backgroundColor: AppGlobal.PrimaryColor,
          leading: IconButton(
              onPressed: () {
                Get.to(Dashboard(isHistory: true));
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: Container(
          child: Column(children: [
            SizedBox(height: 10),
            Card(
              elevation: 8,
              color: AppGlobal.PrimaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                margin: EdgeInsets.only(bottom: 5, top: 5, left: 5, right: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("আজকের পয়েন্ট: ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),

                    // dbHelper.todaysGrossTotalAchievedPoint(
                    //               myTableNames,
                    //               item[dbHelper.fajr.columnDate]
                    //                  .toString())
                    FutureBuilder<num>(
                        future: dbHelper.todaysGrossTotalAchievedPoint(
                            myTableNames, widget.amal_date.toString()),
                        builder: (BuildContext context,
                            AsyncSnapshot<num> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            num totalPoints = snapshot.data ?? 0;

                            return Text("$totalPoints",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold));
                          }
                        }),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: trackingItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      switch (trackingItems[index].trackingWidget) {
                        case 'Fajr':
                          Get.to(
                            () => Fajr(
                              amal_date: widget.amal_date,
                              id: widget.id,
                            ),
                            transition: Transition.leftToRight,
                            duration: Duration(milliseconds: 1000),
                          );

                          break;
                        case 'Dhuhr':
                          Get.to(
                            () => Dhuhr(
                              amal_date: widget.amal_date,
                              id: widget.id,
                            ),
                            transition: Transition.leftToRight,
                            duration: Duration(milliseconds: 1000),
                          );
                          break;
                        case 'Asr':
                          Get.to(
                            () => Asr(
                              amal_date: widget.amal_date,
                              id: widget.id,
                            ),
                            transition: Transition.leftToRight,
                            duration: Duration(milliseconds: 1000),
                          );
                          break;
                        case 'General':
                          Get.to(
                            () => General(
                              amal_date: widget.amal_date,
                              id: widget.id,
                            ),
                            transition: Transition.leftToRight,
                            duration: Duration(milliseconds: 1000),
                          );
                          break;
                        case 'Maghrib':
                          Get.to(
                            () => Maghrib(
                              amal_date: widget.amal_date.toString(),
                              id: widget.id.toString(),
                            ),
                            transition: Transition.leftToRight,
                            duration: Duration(milliseconds: 1000),
                          );
                          break;
                        case 'Isha':
                          Get.to(
                            () => Isha(
                              amal_date: widget.amal_date.toString(),
                              id: widget.id.toString(),
                            ),
                            transition: Transition.leftToRight,
                            duration: Duration(milliseconds: 1000),
                          );
                          break;
                        case 'Fazayel':
                          Get.to(
                            () => Fazayel(
                              amal_date: widget.amal_date.toString(),
                              id: widget.id.toString(),
                            ),
                            transition: Transition.leftToRight,
                            duration: Duration(milliseconds: 1000),
                          );
                          break;
                        default:
                      }
                    },
                    child: Card(
                      elevation: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.75),
                              spreadRadius: 3.0,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: AppGlobal.PrimaryColor,
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              trackingItems[index].icon,
                              color: Colors.white,
                              size: 30.0,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              trackingItems[index].title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 18.0),
                            FutureBuilder<double>(
                                future: dbHelper.getTodaysProgress(
                                    trackingItems[index]
                                        .trackingWidget
                                        .toString(),
                                    widget.amal_date.toString()),
                                builder: (BuildContext context,
                                    AsyncSnapshot<double> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    double progress = snapshot.data ?? 0;

                                    return
                                        //linear progress bar
                                        LinearPercentIndicator(
                                      alignment: MainAxisAlignment.center,
                                      barRadius: Radius.circular(6),
                                      width: 150.0,
                                      lineHeight: 18.0,
                                      percent: progress.toPrecision(2),
                                      // dbHelper.calculateTotalAchievedPoints(
                                      //         'Fajr', widget.amal_date.toString()) /
                                      //     dbHelper.calculateAvailablePoints(Dhuhr_Items)
                                      // dbHelper.calculateAvailablePoints(Dhuhr_Items)) * 100).toStringAsFixed(2)}

                                      center: Text(
                                        "${(progress * 100).toStringAsFixed(2)} %",
                                        style: new TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white),
                                      ),
                                      // trailing: Center(
                                      //     child: Icon(Icons.mood, color: Colors.white)),
                                      linearStrokeCap: LinearStrokeCap.roundAll,
                                      backgroundColor: Colors.grey,
                                      progressColor: Colors.orangeAccent,
                                    );
                                  }
                                }),
                            SizedBox(height: 12.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FutureBuilder<num>(
                                  future: dbHelper.calculateTotalAchievedPoints(
                                      trackingItems[index]
                                          .trackingWidget
                                          .toString(),
                                      widget.amal_date.toString()),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<num> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(); // Show a loading indicator while waiting for the result
                                    } else if (snapshot.hasError) {
                                      return Text(
                                          'Error: ${snapshot.error}'); // Show an error message if an error occurred
                                    } else {
                                      num totalPoints = snapshot.data ??
                                          0; // Retrieve the result from the snapshot
                                      return Text("$totalPoints",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16));
                                    }
                                  },
                                ),
                                Text(" / ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                Text(
                                    "${dbHelper.calculateAvailablePoints(trackingItems[index].trackingWidget.toString())}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ]),
        ));
  }
}
