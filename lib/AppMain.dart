import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_amal_tracker/widgets/Quran.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart ';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:timelines/timelines.dart';

import 'Data/data.dart';
import 'Data/prayerData.dart';
import 'Notifications/Notifications.dart';
import 'dashboard.dart';
import 'db.dart';
import 'global.dart';
import 'package:arabic_font/arabic_font.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

class AppMain extends StatefulWidget {
  const AppMain({super.key});

  @override
  State<AppMain> createState() => _AppMainState();
}

class _AppMainState extends State<AppMain> {
  // NotificationsServices notificationsServices = NotificationsServices();
  final _random = new Random();
  var todays_ayat;
  var todays_hadith;
  var todays_salaf_qoute;
  var todays_dua;
  var endName = 0;
  var startName = 0;
  var text = 'Stop Service';
  int getCurrentDate() {
    var now = DateTime.now();
    var formattedDate = now.day;

    return formattedDate;
  }

  LocalStorage localStorage = LocalStorage("amal_tracker");
  List<Map<String, Map<String, dynamic>>> todaySalah = [];

  @override
  void initState() {
    todays_ayat = AjkerAyat[_random.nextInt(AjkerAyat.length)];
    todays_hadith = AjkerHadith[_random.nextInt(AjkerHadith.length)];
    todays_salaf_qoute = SalafQoutes[_random.nextInt(SalafQoutes.length)];
    todays_dua = Dua_Items[_random.nextInt(Dua_Items.length)];
    super.initState();
    endName = getCurrentDate() * 3;
    startName = endName - 3;
    initializeTodaySalah().then((value) => setState(() {
          todaySalah = value;
        }));

    // notificationsServices.initializeNotifications();
  }

  initializeTodaySalah() async {
    String getTiming(String time) {
      String month = DateFormat('MMMM').format(DateTime.now());
      String day = DateFormat('d').format(DateTime.now());
      String? myTime = prayerTimeBD[month]![day]![time];
      return myTime!;
    }

    todaySalah = [
      {
        'Fajr': {
          'time': await getTiming('Fajr'),
          'isDone': await dbHelper.checkTodaysFardPrayer('Fajr'),
          'lebel': 'ফজর'
        },
      },
      {
        'Dhuhr': {
          'time': await getTiming('Dhuhr'),
          'isDone': await dbHelper.checkTodaysFardPrayer('Dhuhr'),
          'lebel': 'যোহর'
        },
      },
      {
        'Asr': {
          'time': await getTiming('Asr'),
          'isDone': await dbHelper.checkTodaysFardPrayer('Asr'),
          'lebel': 'আসর'
        },
      },
      {
        'Maghrib': {
          'time': await getTiming('Maghrib'),
          'isDone': await dbHelper.checkTodaysFardPrayer('Maghrib'),
          'lebel': 'মাগরিব'
        },
      },
      {
        'Isha': {
          'time': await getTiming('Isha'),
          'isDone': await dbHelper.checkTodaysFardPrayer('Isha'),
          'lebel': 'ইশা'
        },
      },
    ];
    return todaySalah;
  }

  final dbHelper = DatabaseHelper.instance;

// Retrieve the prayer time for Fajr
  void showDialogBoxForTodaySalah() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              "আজকের সালাত",
              style: TextStyle(
                color: AppGlobal.PrimaryColor,
              ),
            ),
          ),
          content: Container(
            height: 350,
            // width: 300,
            width: MediaQuery.of(context).size.width * 0.99,
            child: ListView.builder(
              itemCount: todaySalah.length,
              itemBuilder: (BuildContext context, int index) {
                String salahName = todaySalah[index].keys.first;
                String salahTime = todaySalah[index][salahName]!['time'];
                bool isDone = todaySalah[index][salahName]!['isDone'];
                String lebel = todaySalah[index][salahName]!['lebel'];

                // Define the trailing icon based on the isDone value
                Widget trailingIcon = isDone
                    ? Icon(Icons.check, color: AppGlobal.PrimaryColor)
                    : Icon(Icons.error, color: Colors.red);

                return ListTile(
                  leading:
                      //circle avatar with first character from salah name
                      CircleAvatar(
                    backgroundColor: AppGlobal.PrimaryColor.withOpacity(0.2),
                    child: Text(
                      salahName[0],
                      style: TextStyle(
                        color: AppGlobal.PrimaryColor,
                      ),
                    ),
                  ),
                  // Icon(
                  //   Icons.access_time,
                  //   color: AppGlobal.PrimaryColor,
                  // ),
                  title: Text(
                    lebel,
                    style: TextStyle(
                      color: AppGlobal.PrimaryColor,
                    ),
                  ),
                  subtitle: Text(
                    salahTime,
                    style: TextStyle(
                      color: AppGlobal.PrimaryColor,
                    ),
                  ),
                  trailing: trailingIcon,
                  // tileColor: Colors.grey[200],
                );
              },
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppGlobal.PrimaryColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "বন্ধ করুন",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            todays_ayat = AjkerAyat[_random.nextInt(AjkerAyat.length)];
            todays_hadith = AjkerHadith[_random.nextInt(AjkerHadith.length)];
            todays_salaf_qoute =
                SalafQoutes[_random.nextInt(SalafQoutes.length)];
            todays_dua = Dua_Items[_random.nextInt(Dua_Items.length)];
          });
        },
        child: Icon(Icons.refresh),
        backgroundColor: AppGlobal.PrimaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
              color: Color(0xFFFAFAFA),
              child: Column(children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        // width: 160,
                        child: Card(
                          elevation: 5.2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 20.0),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 15),
                                  margin: EdgeInsets.only(bottom: 5),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(6),
                                          topRight: Radius.circular(6)),
                                      color: AppGlobal.PrimaryColor),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                            localStorage.getItem('gender') ==
                                                    'male'
                                                ? Icons.face
                                                : Icons.face_3_sharp,
                                            color: Colors.white),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        FutureBuilder<double>(
                                          future:
                                              dbHelper.lifeTimePointCounter(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return CircularProgressIndicator();
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            } else {
                                              double result =
                                                  snapshot.data ?? 0;
                                              return Text(
                                                "${localStorage.getItem('name')} [${result.toInt()}]",
                                                style: TextStyle(
                                                    // fontStyle: FontStyle.italic,
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: AppGlobal.PrimaryColor,
                                  thickness: 1.0,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                FutureBuilder<double>(
                                  future: dbHelper.lifeTimePointCounter(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      double result = snapshot.data ?? 0;

                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Container(
                                          height: 110,
                                          child: FixedTimeline.tileBuilder(
                                            theme: TimelineThemeData(
                                              direction: Axis.horizontal,
                                              color: AppGlobal.PrimaryColor,
                                              connectorTheme:
                                                  ConnectorThemeData(
                                                space: 30.0,
                                                thickness: 5.0,
                                              ),
                                            ),
                                            mainAxisSize: MainAxisSize.max,
                                            builder: TimelineTileBuilder
                                                .connectedFromStyle(
                                              contentsAlign:
                                                  ContentsAlign.basic,
                                              oppositeContentsBuilder:
                                                  (context, index) => Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  levelList[index]["icon"],
                                                  color: AppGlobal.PrimaryColor,
                                                  size: 38,
                                                ),
                                              ),
                                              contentsBuilder:
                                                  (context, index) => Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  color: AppGlobal.PrimaryColor,
                                                  border: Border.all(
                                                      color: AppGlobal
                                                          .PrimaryColor),
                                                ),
                                                child: Card(
                                                  elevation: 2.2,
                                                  color: AppGlobal.PrimaryColor,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 3.0,
                                                      horizontal: 6.0,
                                                    ),
                                                    child: Text(
                                                      '${levelList[index]["title"]}',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              connectorStyleBuilder:
                                                  (context, index) =>
                                                      ConnectorStyle.solidLine,
                                              indicatorStyleBuilder: (context,
                                                      index) =>
                                                  (levelList[index]['points'] *
                                                              1000) <=
                                                          result
                                                      ? IndicatorStyle.dot
                                                      : IndicatorStyle.outlined,
                                              itemCount: levelList.length,
                                              firstConnectorStyle:
                                                  ConnectorStyle.solidLine,
                                              connectionDirection:
                                                  ConnectionDirection.before,
                                              itemExtentBuilder:
                                                  (context, index) => 100,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: ExpansionTileCard(
                          animateTrailing: true,
                          elevation: 5,
                          shadowColor: AppGlobal.PrimaryColor,
                          duration: Duration(milliseconds: 1000),
                          initialElevation: 5,
                          turnsCurve: Curves.easeInExpo,
                          title: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            // color: AppGlobal.PrimaryColor,
                            child: Text(
                              "আজকের সালাত",
                              style: TextStyle(
                                fontSize: 20,
                                color: AppGlobal.PrimaryColor,
                              ),
                            ),
                          ),
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: todaySalah.length,
                              itemBuilder: (BuildContext context, int index) {
                                String salahName = todaySalah[index].keys.first;
                                String salahTime =
                                    todaySalah[index][salahName]!['time'];
                                bool isDone =
                                    todaySalah[index][salahName]!['isDone'];
                                String lebel =
                                    todaySalah[index][salahName]!['lebel'];

                                // Define the trailing icon based on the isDone value
                                Widget trailingIcon = isDone
                                    ? Icon(Icons.check,
                                        color: AppGlobal.PrimaryColor)
                                    : Icon(Icons.error, color: Colors.red);

                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor:
                                        AppGlobal.PrimaryColor.withOpacity(0.2),
                                    child: Text(
                                      salahName[0],
                                      style: TextStyle(
                                        color: AppGlobal.PrimaryColor,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    lebel,
                                    style: TextStyle(
                                      color: AppGlobal.PrimaryColor,
                                    ),
                                  ),
                                  subtitle: Text(
                                    salahTime,
                                    style: TextStyle(
                                      color: AppGlobal.PrimaryColor,
                                    ),
                                  ),
                                  trailing: trailingIcon,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        margin: EdgeInsets.only(bottom: 5, top: 5),
                        width: MediaQuery.of(context).size.width * 0.95,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6),
                              topRight: Radius.circular(6),
                              bottomLeft: Radius.circular(6),
                              bottomRight: Radius.circular(6),
                            ),
                            color: AppGlobal.PrimaryColor),
                        child: GestureDetector(
                          onTap: () {
                            showDialogBoxForTodaySalah();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "আজকের সালাত",
                                style: TextStyle(
                                    // fontStyle: FontStyle.italic,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                width: 10,
                              ),

                              //open in dialog icon button here
                              IconButton(
                                icon: Icon(
                                  Icons.open_in_new,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  showDialogBoxForTodaySalah();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        // width: 160,
                        child: Card(
                          elevation: 5.2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 20.0),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  margin: EdgeInsets.only(bottom: 5),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(6),
                                          topRight: Radius.circular(6)),
                                      color: AppGlobal.PrimaryColor),
                                  child: Center(
                                    child: Text(
                                      "নির্বাচিত আয়াত",
                                      style: TextStyle(
                                          // fontStyle: FontStyle.italic,
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                // Divider(
                                //   color: AppColors.PrimaryColor,
                                //   thickness: 1.0,
                                // ),
                                ExpandableText(
                                  //bengali
                                  todays_ayat[1].toString(),
                                  expandText: 'show more',
                                  collapseText: 'show less',
                                  maxLines: 4,
                                  linkColor: Colors.blue,
                                  style: TextStyle(
                                    // fontStyle: FontStyle.italic,
                                    fontSize: 12,
                                  ),
                                ),
                                todays_ayat[0].length > 0
                                    ? Text(
                                        //Arabic
                                        todays_ayat[0].toString(),

                                        style: TextStyle(
                                          // fontStyle: FontStyle.italic,
                                          fontFamily: 'Noor E Huda',
                                          fontSize: 25,
                                        ),
                                      )
                                    : Text(""),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        // width: 180,
                        child: Card(
                          elevation: 5.2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 20.0),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  margin: EdgeInsets.only(bottom: 5),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(6),
                                          topRight: Radius.circular(6)),
                                      color: AppGlobal.PrimaryColor),
                                  child: Center(
                                    child: Text(
                                      "নির্বাচিত হাদিস",
                                      style: TextStyle(
                                          // fontStyle: FontStyle.italic,
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                // Divider(
                                //   color: AppColors.PrimaryColor,
                                //   thickness: 1.0,
                                // ),
                                ExpandableText(
                                  todays_hadith.toString(),
                                  expandText: 'show more',
                                  collapseText: 'show less',
                                  maxLines: 4,
                                  linkColor: Colors.blue,
                                  style: TextStyle(
                                    // fontStyle: FontStyle.italic,
                                    fontSize: 12,
                                    // fontFamily: 'Noor E Huda'
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        // width: 180,
                        child: Card(
                          elevation: 5.2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 20.0),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  margin: EdgeInsets.only(bottom: 5),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(6),
                                          topRight: Radius.circular(6)),
                                      color: AppGlobal.PrimaryColor),
                                  child: Center(
                                    child: Text(
                                      "সালাফদের বক্তব্য",
                                      style: TextStyle(
                                          // fontStyle: FontStyle.italic,
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                // Divider(
                                //   color: AppColors.PrimaryColor,
                                //   thickness: 1.0,
                                // ),
                                ExpandableText(
                                  todays_salaf_qoute.toString(),
                                  expandText: 'show more',
                                  collapseText: 'show less',
                                  maxLines: 4,
                                  linkColor: Colors.blue,
                                  style: TextStyle(
                                      // fontStyle: FontStyle.italic,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Card(
                            elevation: 10,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 10, left: 10, right: 10, bottom: 10),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    margin: EdgeInsets.only(bottom: 5),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(6),
                                            topRight: Radius.circular(6)),
                                        color: AppGlobal.PrimaryColor),
                                    child: Center(
                                      child: Text(
                                        "আজকের দু'আ",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // CarouselSlider(
                                  //     items: items,
                                  //     options: CarouselOptions(
                                  //       // height: 280,
                                  //       pauseAutoPlayOnTouch: true,
                                  //       scrollPhysics: BouncingScrollPhysics(),
                                  //       aspectRatio: 16 / 19,
                                  //       viewportFraction: 1.0,
                                  //       initialPage: 0,
                                  //       enableInfiniteScroll: true,
                                  //       reverse: false,
                                  //       autoPlay: true,
                                  //       autoPlayInterval: Duration(seconds: 12),
                                  //       autoPlayAnimationDuration:
                                  //           Duration(milliseconds: 10000),
                                  //       autoPlayCurve: Curves.linear,
                                  //       enlargeCenterPage: true,
                                  //       // enlargeFactor: 0.3,
                                  //       onPageChanged: (index, reason) {
                                  //         setState(() {
                                  //           index = index;
                                  //         });
                                  //       },
                                  //       scrollDirection: Axis.horizontal,
                                  //     )),

                                  Text(
                                    todays_dua['title'].toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black45),
                                  ),
                                  todays_dua['arabic'].length > 0
                                      ? SizedBox(
                                          height: 10,
                                        )
                                      : SizedBox(
                                          height: 0,
                                        ),

                                  todays_dua['arabic'].length > 0
                                      ? Text(
                                          todays_dua['arabic'].toString(),
                                          style: TextStyle(
                                              fontFamily: 'Noor E Huda',
                                              // fontStyle: FontStyle.italic,
                                              fontSize:
                                                  todays_dua['arabic'].length >
                                                          155
                                                      ? 25
                                                      : 30),
                                        )
                                      : SizedBox(
                                          height: 0,
                                        ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ExpandableText(
                                    todays_dua['bengali'].toString(),
                                    expandText: 'show more',
                                    collapseText: 'show less',
                                    maxLines: 4,
                                    linkColor: Colors.blue,
                                    style: TextStyle(
                                        // fontFamily: 'Alinur Tumatul',
                                        // fontStyle: FontStyle.italic,
                                        fontSize: 12),
                                  ),
                                  // Text(
                                  //     "The Messenger of Allah (ﷺ) said: ‘Whoever prays the night prayer in Ramadan out of sincere faith and hoping to attain Allah’s rewards, then all his previous sins will be forgiven.’"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 8),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(60),
                                    topRight: Radius.circular(60)),
                                color: AppGlobal.PrimaryColor),
                            child: Center(
                                child: Text("আসমাউল হুসনা:",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white))),
                          ),

                          // a table widget with the name of Allah and the meaning of the name
                          Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.only(bottom: 10),
                            child: Table(
                              border: TableBorder.all(
                                  color: AppGlobal.PrimaryColor,
                                  width: 1,
                                  style: BorderStyle
                                      .solid, //tablerow margin 10 from top and bottom
                                  borderRadius: BorderRadius.circular(5)),

                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              //tablerow margin 10 from top and bottom and 5 from left and

                              children: [
                                for (var name = startName;
                                    name < endName;
                                    name++) ...[
                                  TableRow(children: [
                                    Center(
                                        child: RichText(
                                      text: TextSpan(
                                        text: Asmaul_Husna[name]
                                            [1], // Bengali text
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '   ',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text: Asmaul_Husna[name]
                                                [0], // Arabic text
                                            style: TextStyle(
                                              fontFamily: 'Noor E Huda',
                                              fontSize: 28,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                    //     Text(
                                    //   Asmaul_Husna[name][0],
                                    //   style: TextStyle(
                                    //       fontSize: 18, fontFamily: 'Noor E Huda'),
                                    // ),

                                    // )
                                  ]),
                                ],
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                //elevated button onpressed
                // ElevatedButton(
                //   onPressed: () {
                //     notificationsServices.sendNotification(
                //         "Hello World", "How Are You");
                //     // scheduleDailyNotifications();
                //   },
                //   child: Text(
                //     "Notification",
                //     style: TextStyle(fontSize: 20),
                //   ),
                //   style: ElevatedButton.styleFrom(
                //     primary: AppGlobal.PrimaryColor,
                //     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10)),
                //   ),
                // ),
                // Text(calculateIshaJamaat('7:50', 30).toString()),
                // SizedBox(height: 10.0),
                // ElevatedButton(
                //   onPressed: () {
                //     FlutterBackgroundService().invoke('setAsForeground');
                //     // scheduleDailyNotifications();
                //   },
                //   child: Text(
                //     "Foregound Service",
                //     style: TextStyle(fontSize: 20),
                //   ),
                //   style: ElevatedButton.styleFrom(
                //     primary: AppGlobal.PrimaryColor,
                //     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10)),
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // ElevatedButton(
                //   onPressed: () async {
                //     final service = await FlutterBackgroundService();
                //     bool isRunning = await service.isRunning();
                //     if (isRunning) {
                //       service.invoke('stopService');
                //     } else {
                //       service.startService();
                //     }
                //     if (!isRunning) {
                //       text = "Stop Service";
                //     } else {
                //       text = "Start Service";
                //     }
                //     setState(() {});

                //     // scheduleDailyNotifications();
                //   },
                //   child: Text(
                //     "Background Service",
                //     style: TextStyle(fontSize: 20),
                //   ),
                //   style: ElevatedButton.styleFrom(
                //     primary: AppGlobal.PrimaryColor,
                //     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10)),
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     // scheduleDailyNotifications();
                //   },
                //   child: Text(
                //     "Schedule Notification",
                //     style: TextStyle(fontSize: 20),
                //   ),
                //   style: ElevatedButton.styleFrom(
                //     primary: AppGlobal.PrimaryColor,
                //     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10)),
                //   ),
                // ),
              ]))),
    );
  }
}
