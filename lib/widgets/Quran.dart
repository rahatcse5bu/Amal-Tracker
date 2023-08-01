import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../details.dart';
import '../global.dart';
import 'Surah.dart';
import 'package:quran/quran.dart' as quran;

class Quran extends StatefulWidget {
  const Quran({super.key, required this.amal_date});
  final String amal_date;
  @override
  State<Quran> createState() => _QuranState();
}

class _QuranState extends State<Quran> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Quran'),
      //   centerTitle: true,
      //   backgroundColor: AppGlobal.PrimaryColor,
      //   leading: IconButton(
      //       onPressed: () {
      //         Get.to(Details(
      //             amal_date: widget.amal_date.toString(), id: 1.toString()));
      //       },
      //       icon: Icon(Icons.arrow_back)),
      // ),
      body: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width * .98,
              margin: EdgeInsets.only(top: 20, bottom: 15),
              decoration: BoxDecoration(
                  color: AppGlobal.PrimaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    // bottomLeft: Radius.circular(200),
                    // bottomRight: Radius.circular(200),
                  ),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                    style: BorderStyle.solid,
                  )),
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Center(
                  child: Text("Al Quran",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)))),
          Expanded(
            child: ListView.builder(
              itemCount: 114, // Total number of surahs
              itemBuilder: (context, index) {
                final surahNumber = index + 1;
                final surahTitle = quran.getSurahName(surahNumber);
                final String modifiedSurahTitle = surahTitle.replaceAll(
                    RegExp(r'Al |'
                        'Ad |'
                        'As |'
                        'At |'
                        'Ash |'
                        'Az |'
                        'An |'
                        'Ar '),
                    '');
                // Replace with actual surah titles

                return Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.25),
                        spreadRadius: 0.0,
                        blurRadius: 0.1,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Card(
                    elevation: 3.2,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: ListTile(
                        onTap: () {
                          Get.to(Surah(surah_no: surahNumber));
                        },
                        leading: CircleAvatar(
                          backgroundColor: AppGlobal.PrimaryColor,
                          child: Text(
                            modifiedSurahTitle.substring(0, 1),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        title: Text(surahTitle),
                        subtitle: Text(
                            quran.getSurahNameArabic(surahNumber) +
                                "(" +
                                quran.getPlaceOfRevelation(surahNumber) +
                                ")",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Noor E Huda',
                            )),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
