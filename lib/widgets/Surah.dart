import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/quran.dart' as quran;

import '../global.dart';

class Surah extends StatefulWidget {
  const Surah({super.key, required this.surah_no});
  final int surah_no;
  @override
  State<Surah> createState() => _SurahState();
}

class _SurahState extends State<Surah> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text((quran.getSurahName(widget.surah_no)).toString()),
          centerTitle: true,
          backgroundColor: AppGlobal.PrimaryColor,
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ListView.builder(
              itemCount: quran.getVerseCount(widget.surah_no),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    quran.getVerse(widget.surah_no, index + 1,
                        verseEndSymbol: true),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 35,
                      fontFamily: 'Noor E Huda',
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
