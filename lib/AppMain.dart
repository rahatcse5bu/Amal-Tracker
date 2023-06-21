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
  int getCurrentDate() {
    var now = DateTime.now();
    var formattedDate = now.day;

    return formattedDate;
  }

  LocalStorage localStorage = LocalStorage("amal_tracker");
  static List<Map<String, Map<String, dynamic>>> todaySalah = [];
  static List<Map<String, Map<String, dynamic>>> getTodaySalah() {
    return todaySalah;
  }

  @override
  void initState() {
    todays_ayat = AjkerAyat[_random.nextInt(AjkerAyat.length)];
    todays_hadith = AjkerHadith[_random.nextInt(AjkerHadith.length)];
    todays_salaf_qoute = SalafQoutes[_random.nextInt(SalafQoutes.length)];
    todays_dua = Dua_Items[_random.nextInt(Dua_Items.length)];
    super.initState();
    endName = getCurrentDate() * 3;
    startName = endName - 3;
    initializeTodaySalah();

    // notificationsServices.initializeNotifications();
  }

  void initializeTodaySalah() async {
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
  }

  final dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> levelList = [
    {
      'title': 'Iron',
      'icon': Icons.emoji_objects,
      'points': 10,
    },
    {
      'title': 'Gold',
      'icon': Icons.emoji_events,
      'points': 50,
    },
    {
      'title': 'Silver',
      'icon': Icons.emoji_events,
      'points': 30,
    },
    {
      'title': 'Bronze',
      'icon': Icons.emoji_events,
      'points': 20,
    },
    {
      'title': 'Medal 1',
      'icon': Icons.star,
      'points': 15,
    },
    {
      'title': 'Medal 2',
      'icon': Icons.star,
      'points': 25,
    },
    {
      'title': 'Medal 3',
      'icon': Icons.star,
      'points': 35,
    },
    {
      'title': 'Diamond',
      'icon': Icons.diamond,
      'points': 70,
    },
    {
      'title': 'Ruby',
      'icon': Icons.whatshot,
      'points': 60,
    },
    {
      'title': 'Emerald',
      'icon': Icons.eco,
      'points': 55,
    },
    {
      'title': 'Sapphire',
      'icon': Icons.opacity,
      'points': 45,
    },
    {
      'title': 'Topaz',
      'icon': Icons.category,
      'points': 40,
    },
    {
      'title': 'Amethyst',
      'icon': Icons.healing,
      'points': 75,
    },
    {
      'title': 'Pearl',
      'icon': Icons.brightness_1,
      'points': 65,
    },
    {
      'title': 'Opal',
      'icon': Icons.remove_red_eye,
      'points': 80,
    },
    {
      'title': 'Garnet',
      'icon': Icons.ac_unit,
      'points': 85,
    },
    {
      'title': 'Aquamarine',
      'icon': Icons.waves,
      'points': 90,
    },
    {
      'title': 'Citrine',
      'icon': Icons.local_florist,
      'points': 95,
    },
    {
      'title': 'Peridot',
      'icon': Icons.nature,
      'points': 100,
    },
    {
      'title': 'Tanzanite',
      'icon': Icons.star_border,
      'points': 105,
    },
    {
      'title': 'Tourmaline',
      'icon': Icons.all_inclusive,
      'points': 110,
    },
    // Add 20 more items below
    {
      'title': 'Emeraldite',
      'icon': Icons.eco,
      'points': 115,
    },
    {
      'title': 'Jade',
      'icon': Icons.grass,
      'points': 120,
    },
    {
      'title': 'Moonstone',
      'icon': Icons.nightlight_round,
      'points': 125,
    },
    {
      'title': 'Amber',
      'icon': Icons.brightness_high,
      'points': 130,
    },
    {
      'title': 'Lapis Lazuli',
      'icon': Icons.auto_awesome,
      'points': 135,
    },
    {
      'title': 'Obsidian',
      'icon': Icons.visibility,
      'points': 140,
    },
    {
      'title': 'Coral',
      'icon': Icons.all_out,
      'points': 145,
    },
    {
      'title': 'Malachite',
      'icon': Icons.nature_people,
      'points': 150,
    },
    {
      'title': 'Onyx',
      'icon': Icons.lens,
      'points': 155,
    },
    {
      'title': 'Quartz',
      'icon': Icons.radio_button_checked,
      'points': 160,
    },
    {
      'title': 'Rose Quartz',
      'icon': Icons.favorite,
      'points': 165,
    },
    {
      'title': 'Carnelian',
      'icon': Icons.color_lens,
      'points': 170,
    },
    {
      'title': 'Agate',
      'icon': Icons.filter_vintage,
      'points': 175,
    },
    {
      'title': 'Aventurine',
      'icon': Icons.emoji_nature,
      'points': 180,
    },
    {
      'title': 'Hematite',
      'icon': Icons.grain,
      'points': 185,
    },
    {
      'title': 'Tiger Eye',
      'icon': Icons.remove,
      'points': 190,
    },
    {
      'title': 'Sardonyx',
      'icon': Icons.photo_filter,
      'points': 195,
    },
    {
      'title': 'Zircon',
      'icon': Icons.flash_on,
      'points': 200,
    },
    {
      'title': 'Iolite',
      'icon': Icons.blur_linear,
      'points': 205,
    },
    {
      'title': 'Sunstone',
      'icon': Icons.wb_sunny,
      'points': 210,
    },
  ];
  // String? getTiming(String time) {
  //   String month = DateFormat('MMMM').format(DateTime.now());
  //   String day = DateFormat('d').format(DateTime.now());
  //   String? myTime = prayerTimeBD[month]![day]![time];
  //   return myTime!;
  // }

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
            width: 300,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                        localStorage.getItem('gender') == 'male'
                                            ? Icons.face
                                            : Icons.face_3_sharp,
                                        color: Colors.white),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    FutureBuilder<double>(
                                      future: dbHelper.lifeTimePointCounter(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          double result = snapshot.data ?? 0;
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
                                          connectorTheme: ConnectorThemeData(
                                            space: 30.0,
                                            thickness: 5.0,
                                          ),
                                        ),
                                        mainAxisSize: MainAxisSize.max,
                                        builder: TimelineTileBuilder
                                            .connectedFromStyle(
                                          contentsAlign: ContentsAlign.basic,
                                          oppositeContentsBuilder:
                                              (context, index) => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              levelList[index]["icon"],
                                              color: AppGlobal.PrimaryColor,
                                              size: 38,
                                            ),
                                          ),
                                          contentsBuilder: (context, index) =>
                                              Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color: AppGlobal.PrimaryColor,
                                              border: Border.all(
                                                  color:
                                                      AppGlobal.PrimaryColor),
                                            ),
                                            child: Card(
                                              elevation: 2.2,
                                              color: AppGlobal.PrimaryColor,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                          itemExtentBuilder: (context, index) =>
                                              100,
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
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: ExpansionTileCard(
                      animateTrailing: true,
                      elevation: 5,
                      shadowColor: AppGlobal.PrimaryColor,
                      duration: Duration(milliseconds: 1000),
                      initialElevation: 5,
                      turnsCurve: Curves.easeInExpo,
                      title: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                              todays_ayat.toString(),
                              expandText: 'show more',
                              collapseText: 'show less',
                              maxLines: 4,
                              linkColor: Colors.blue,
                              style:
                                  // ArabicTextStyle(
                                  //     arabicFont: ArabicFont.iBMPlexSansArabic,
                                  //     fontSize: 20),

                                  TextStyle(
                                // fontStyle: FontStyle.italic,
                                fontSize: 12,
                                // fontFamily: 'Noor E Huda',
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
                                  ? ExpandableText(
                                      todays_dua['arabic'].toString(),
                                      expandText: 'show more',
                                      collapseText: 'show less',
                                      maxLines: 8,
                                      linkColor: Colors.blue,
                                      style: TextStyle(
                                          fontFamily: 'Noor E Huda',
                                          // fontStyle: FontStyle.italic,
                                          fontSize:
                                              todays_dua['arabic'].length > 155
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
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                                    child: Text(
                                  Asmaul_Husna[name],
                                  style: TextStyle(
                                      fontSize: 18, fontFamily: 'Noor E Huda'),
                                ))
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
            SizedBox(height: 10.0),
//             ElevatedButton(
//               onPressed: () {
//                 notificationsServices.initializeNotifications();

// // Schedule notifications at the desired times
//                 notificationsServices.scheduleNotification(
//                   id: 1,
//                   title: "Hello Arafat",
//                   body: "Ekkale Paraiya Mairra Halamu. eda 6:06 er jonno.",
//                   payload: "notification_1",
//                   scheduledTime: TimeOfDay(hour: 18, minute: 06),
//                 );

//                 // scheduleDailyNotifications();
//               },
//               child: Text(
//                 "Schedule Notification",
//                 style: TextStyle(fontSize: 20),
//               ),
//               style: ElevatedButton.styleFrom(
//                 primary: AppGlobal.PrimaryColor,
//                 padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10)),
//               ),
//             ),
          ]))),
    );
  }
}
