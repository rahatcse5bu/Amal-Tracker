import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:daily_amal_tracker/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:percent_indicator/percent_indicator.dart';

// import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
// import 'package:animated_bottom_navigation_bar/destination.dart';

import 'AppMain.dart';
import 'Overview.dart';
import 'Settings.dart';
import 'functions/GlobalFunc.dart';
import 'history.dart';
import 'widgets/Quran.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required this.isHistory});
  final bool isHistory;
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  LocalStorage localStorage = LocalStorage("amal_tracker");

  int current_index = 0;
  final int _currentIndex = 0;
  // final List<Widget> pages = [Dashboard(isHistory: widget.isHistory), History(), Settings()];
  Widget body = AppMain();
  void OnTapped(int index) {
    setState(() {
      current_index = index;
      switch (current_index) {
        case 0:
          if (widget.isHistory) {
            body = History();
          } else {
            body = AppMain();
          }

          break;
        case 1:
          body = History();

          break;
        case 2:
          body = Overview();

          break;
        case 3:
          body = Quran(
            amal_date: '',
          );

          break;
        case 4:
          body = Settings();

          break;
        default:
          if (widget.isHistory) {
            body = History();
          } else {
            body = AppMain();
          }
      }
    });
  }

  List<IconData> iconList = [
    //list of icons that required by animated navigation bar.
    Icons.home,
    // Icons.access_time,
    Icons.history,
    Icons.pie_chart,
    Icons.book,
    Icons.settings,
  ];

  Future<bool> _onWillPop(BuildContext context) async {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Do you want to exit?'),
            actions: [
              TextButton(
                child: Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                        color: AppGlobal.PrimaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text('No')),
                onPressed: () {
                  Navigator.of(context).pop(false); // Prevent back navigation
                },
              ),
              TextButton(
                child: Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                        color: AppGlobal.PrimaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text('Yes', style: TextStyle(color: Colors.white))),
                onPressed: () {
                  closeApp(); // Allow back navigation
                },
              ),
            ],
          ),
        ) as bool? ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   child: Icon(Icons.add),
        //   //params
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar(
            icons: iconList,
            activeIndex: current_index,
            gapLocation: GapLocation.end,
            notchSmoothness: NotchSmoothness.defaultEdge,
            // leftCornerRadius: 32,
            // rightCornerRadius: 32,
            backgroundColor: AppGlobal.PrimaryColor,
            activeColor: Colors.yellow,
            elevation: 10,
            iconSize: 30,
            // notchAndCornersAnimation: animation,
            backgroundGradient: LinearGradient(
              colors: [
                AppGlobal.PrimaryColor,
                AppGlobal.PrimaryColor.withOpacity(.4)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderColor: AppGlobal.PrimaryColor,
            gapWidth: 10,
            splashSpeedInMilliseconds: 300,
            inactiveColor: Colors.white,
            borderWidth: 1,
            blurEffect: true,
            height: 70,
            leftCornerRadius: 12,
            // rightCornerRadius: 2,
            // notchAndCornersAnimation: AnimationController(
            //     vsync: NavigatorState(), duration: Duration(milliseconds: 500)),
            // safeAreaValues: SafeAreaValues(top: 10, bottom: 10),
            shadow: BoxShadow(
                color: Colors.black.withOpacity(.5),
                offset: Offset(0, 10),
                blurRadius: 10),
            splashColor: Colors.white,
            onTap: OnTapped
            // (index) => setState(() => current_index = index),
            //other params
            ),
        appBar: AppBar(
          title: Text(
            "'আমাল ট্র্যাকার",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: AppGlobal.PrimaryColor,
          leading: Text(''),
          //action button
          // actions: <Widget>[
          //   Container(
          //     margin: EdgeInsets.fromLTRB(2, 0, 10, 0),
          //     child: IconButton(
          //       icon: Icon(Icons.arrow_forward),
          //       onPressed: () {
          //         Navigator.pushNamed(context, '/borjoniyo');
          //       },
          //     ),
          //   ),
          // ],
        ),
        body: WillPopScope(onWillPop: () => _onWillPop(context), child: body)
        //  DefaultTabController(
        //   length: 3,
        //   child: Scaffold(
        //     body: SafeArea(
        //       child: Stack(
        //         children: [
        //           Padding(
        //             padding: const EdgeInsets.all(16.0),
        //             child: SegmentedTabControl(
        //               // Customization of widget
        //               splashColor: Colors.green,
        //               radius: const Radius.circular(3),
        //               backgroundColor: Colors.grey.shade300,
        //               indicatorColor: Colors.orange.shade200,
        //               tabTextColor: Colors.black45,
        //               selectedTabTextColor: Colors.white,
        //               squeezeIntensity: 2,
        //               height: 45,
        //               tabPadding: const EdgeInsets.symmetric(horizontal: 8),
        //               textStyle: Theme.of(context).textTheme.bodyText1,
        //               // Options for selection
        //               // All specified values will override the [SegmentedTabControl] setting
        //               tabs: [
        //                 SegmentTab(
        //                   label: 'ACCOUNT',
        //                   // For example, this overrides [indicatorColor] from [SegmentedTabControl]
        //                   color: Colors.red.shade200,
        //                 ),
        //                 SegmentTab(
        //                   label: 'HOME',
        //                   backgroundColor: Colors.blue.shade100,
        //                   selectedTextColor: Colors.black45,
        //                   textColor: Colors.black26,
        //                 ),
        //                 const SegmentTab(label: 'NEW'),
        //               ],
        //             ),
        //           ),
        //           // Sample pages
        //           Padding(
        //             padding: const EdgeInsets.only(top: 70),
        //             child: TabBarView(
        //               physics: const BouncingScrollPhysics(),
        //               children: [
        //                 Text("Hello First"),
        //                 Text("Hello Secound"),
        //                 Text("Hello 3rd")
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),

        // pages[0],

        // Column(
        //   children: [
        //     Container(
        //       child: Text("Dashboard:" +
        //           "Hello " +
        //           localStorage.getItem('name') +
        //           ", " +
        //           localStorage.getItem('gender')),
        //     ),
        //     pages[current_index],
        //     //       new CircularPercentIndicator(
        //     //   radius: 120.0,
        //     //   lineWidth: 13.0,
        //     //   animation: true,
        //     //   percent: 0.7,
        //     //   center: new Text(
        //     //     "70.0%",
        //     //     style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        //     //   ),
        //     //   footer: new Text(
        //     //     "Sales this week",
        //     //     style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
        //     //   ),
        //     //   circularStrokeCap: CircularStrokeCap.round,
        //     //   progressColor: Colors.purple,
        //     // ),
        //   ],
        // ),
        );
  }
}
