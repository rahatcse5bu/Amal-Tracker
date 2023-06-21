// import 'package:expandable_text/expandable_text.dart';
// import 'package:flutter/material.dart';
// import 'package:expansion_tile_card/expansion_tile_card.dart';

// import '../Data/data.dart';
// import '../global.dart';

// class DuaScreen extends StatefulWidget {
//   const DuaScreen({super.key});

//   @override
//   State<DuaScreen> createState() => _DuaScreenState();
// }

// class _DuaScreenState extends State<DuaScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dua List'),
//         centerTitle: true,
//         backgroundColor: AppGlobal.PrimaryColor,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//               Navigator.pushNamed(context, '/dashboard');
//             },
//             icon: Icon(Icons.arrow_back)),
//       ),
//       body: Container(
//           child: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: Dua_Items.length,
//               itemBuilder: (context, index) {
//                 Map<String, dynamic> dua = Dua_Items[index];

//                 return ExpansionTileCard(
//                   elevation: 5.2,
//                   animateTrailing: true,
//                   borderRadius: BorderRadius.circular(8),
//                   colorCurve: Curves.easeInCubic,
//                   expandedTextColor: AppGlobal.PrimaryColor,
//                   // baseColor: AppGlobal.PrimaryColor,
//                   expandedColor: Colors.white,
//                   paddingCurve: Curves.easeInCubic,
//                   trailing: Icon(
//                     Icons.arrow_drop_down,
//                     color: AppGlobal.PrimaryColor,
//                   ),
//                   leading: CircleAvatar(
//                     backgroundColor: AppGlobal.PrimaryColor,
//                     child: Text(
//                       '${index + 1}',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   title: Text(dua['title']),
//                   children: [
//                     Container(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 10, horizontal: 5),
//                       margin:
//                           EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             dua['arabic'],
//                             style: TextStyle(
//                                 fontSize: 28, fontFamily: 'Noor E Huda'),
//                           ),
//                           SizedBox(height: 10),
//                           ExpandableText(
//                             dua['bengali'],
//                             expandText: 'more',
//                             collapseText: 'less',
//                             maxLines: 4,
//                             style: TextStyle(fontSize: 13),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ],
//       )),
//     );
//   }
// }
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

import '../Data/data.dart';
import '../global.dart';

class DuaScreen extends StatefulWidget {
  const DuaScreen({Key? key}) : super(key: key);

  @override
  State<DuaScreen> createState() => _DuaScreenState();
}

class _DuaScreenState extends State<DuaScreen> {
  late List<Map<String, dynamic>> filteredDuas;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredDuas = Dua_Items;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void searchDuas(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredDuas = Dua_Items;
      } else {
        filteredDuas = Dua_Items.where((dua) {
          final String title = dua['title'].toLowerCase();
          final String arabic = dua['arabic'].toLowerCase();
          final String bengali = dua['bengali'].toLowerCase();
          return title.contains(query.toLowerCase()) ||
              arabic.contains(query.toLowerCase()) ||
              bengali.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dua List'),
        centerTitle: true,
        backgroundColor: AppGlobal.PrimaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/dashboard');
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: searchDuas,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: Icon(Icons.search),
                hintText: 'Search Dua',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredDuas.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> dua = filteredDuas[index];

                return ExpansionTileCard(
                  elevation: 5.2,
                  animateTrailing: true,
                  borderRadius: BorderRadius.circular(8),
                  colorCurve: Curves.easeInCubic,
                  expandedTextColor: AppGlobal.PrimaryColor,
                  expandedColor: Colors.white,
                  paddingCurve: Curves.easeInCubic,
                  trailing: Icon(
                    Icons.arrow_drop_down,
                    color: AppGlobal.PrimaryColor,
                  ),
                  leading: CircleAvatar(
                    backgroundColor: AppGlobal.PrimaryColor,
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(dua['title']),
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dua['arabic'],
                            style: TextStyle(
                                fontSize: 28, fontFamily: 'Noor E Huda'),
                          ),
                          SizedBox(height: 10),
                          ExpandableText(
                            dua['bengali'],
                            expandText: 'more',
                            collapseText: 'less',
                            maxLines: 4,
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
