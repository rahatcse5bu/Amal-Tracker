// import 'package:flutter/material.dart';

// import '../../global.dart';

// class Bottom extends StatefulWidget {
//   const Bottom({super.key});

//   @override
//   State<Bottom> createState() => _BottomState();
// }

// class _BottomState extends State<Bottom> {
//     int current_index = 0;
//   final List<Widget> pages = [Dashboard(), History(), Settings()];

//   void OnTapped(int index) {
//     setState(() {
//       current_index = index;
//       });
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//           bottomNavigationBar: BottomNavigationBar(
//           backgroundColor: AppGlobal.PrimaryColor,
//           iconSize: 26,
//           selectedItemColor: Colors.black,
//           unselectedItemColor: Colors.white,
//           currentIndex: current_index,
//           selectedFontSize: 20,
//           unselectedFontSize: 14,
//           onTap: OnTapped,
//           items: <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.home), label: "Home", tooltip: "Home"),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.search), label: "Search", tooltip: "Search"),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.settings),
//                 label: "Settings",
//                 tooltip: "Settings"),
//           ]),
//     );
//   }
// }
