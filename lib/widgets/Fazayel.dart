//import main.dart
import 'dart:convert';

import 'package:confetti/confetti.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:sqflite/sqflite.dart';
import '../Data/data.dart';
import '../db.dart';
import '../details.dart';
import '../global.dart';

// import '../Data/localStorageFunc.dart';

class Fazayel extends StatefulWidget {
  Fazayel({super.key, required this.amal_date, required this.id});
  String amal_date;
  String id;
  @override
  State<Fazayel> createState() => _FazayelState();
}

class _FazayelState extends State<Fazayel> {
  bool? val = false;
  final dbHelper = DatabaseHelper.instance;
  // Assuming you have initialized and opened the database
  bool isConfetti = false;
  ConfettiController? _confettiController;
  @override
  initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
    dbHelper
        .initializeData('Fazayel', widget.amal_date.toString())
        .then((value) => setState(() {
              print('value----------------: ' + value.toString());
              // dbHelper.modifiedFajrItems = value;
            }));
  }

  @override
  void dispose() {
    _confettiController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${DateFormat('dd MMM yyyy').format(DateTime.parse(widget.amal_date))}'),
          centerTitle: true,
          backgroundColor: AppGlobal.PrimaryColor,
          leading: IconButton(
              onPressed: () {
                Get.to(Details(
                    amal_date: widget.amal_date.toString(), id: 1.toString()));
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: Stack(children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                // Todo list with SwitchListTile widget and a button to add new todo
                Column(children: [
                  Card(
                      elevation: 5,
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(children: [
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
                                  "ফাযায়েলে 'আমাল ট্রাকিং: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            // CheckboxListTile

                            for (var i = 0;
                                i < dbHelper.modifiedFazayelItems.length;
                                i++) ...[
                              dbHelper.modifiedFazayelItems.length > 0
                                  ? SwitchListTile(
                                      secondary:
                                          dbHelper.modifiedFazayelItems[i]
                                                      ['isChecked'] ==
                                                  false
                                              ? Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                )
                                              : Icon(
                                                  Icons.check,
                                                  color: AppGlobal.PrimaryColor,
                                                ),
                                      activeColor:
                                          dbHelper.modifiedFazayelItems[i]
                                                      ['isChecked'] ==
                                                  false
                                              ? Colors.red
                                              : AppGlobal.PrimaryColor,
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      title: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: dbHelper
                                                      .modifiedFazayelItems[i]
                                                  ['title'],
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            TextSpan(
                                              text: " [" +
                                                  dbHelper
                                                      .modifiedFazayelItems[i]
                                                          ['points']
                                                      .toString() +
                                                  "]",
                                              style: TextStyle(
                                                  color: AppGlobal.PrimaryColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      isThreeLine: true,
                                      subtitle: ExpandableText(
                                        dbHelper.modifiedFazayelItems[i]
                                            ['description'],
                                        expandText: 'show more',
                                        collapseText: 'show less',
                                        maxLines: 2,
                                        linkColor: Colors.blue,
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 12),
                                      ),
                                      value: dbHelper.modifiedFazayelItems[i]
                                          ['isChecked'],
                                      onChanged: (bool? newValue) {
                                        if (newValue == true) {
                                          setState(() {
                                            isConfetti = true;
                                          });
                                          _confettiController?.play();
                                        } else {
                                          setState(() {
                                            isConfetti = false;
                                          });
                                          _confettiController?.stop();
                                        }
                                        dbHelper
                                            .updateDatabaseValue(
                                                'Fazayel',
                                                dbHelper.modifiedFazayelItems[i]
                                                        ['id']
                                                    .toString(),
                                                widget.amal_date.toString(),
                                                newValue as bool)
                                            .then((value) => setState(() {
                                                  dbHelper.modifiedFazayelItems =
                                                      value;
                                                  print("Fazayel  " +
                                                      value.toString());
                                                }));

                                        //     showDialog(
                                        //         context: context,
                                        //         builder: (BuildContext context) {
                                        //           return AlertDialog(
                                        //             title: Row(
                                        //               mainAxisAlignment:
                                        //                   MainAxisAlignment.spaceBetween,
                                        //               children: [
                                        //                 Icon(Icons.check_circle,
                                        //                     color: AppGlobal.PrimaryColor),
                                        //                 SizedBox(width: 2),
                                        //                 Text('জাযাকাল্লহু খইরন!'),
                                        //               ],
                                        //             ),
                                        //             content: Text(
                                        //                 "জাযাকাল্লহু খইরন। আপনি সফলভাবে আজকের ফজরের কাজগুলো সম্পন্ন করেছেন! "),
                                        //             actions: [
                                        //               TextButton(
                                        //                 onPressed: () {
                                        //                   Navigator.of(context).pop();
                                        //                 },
                                        //                 child: Center(child: Text('ঠিক আছে')),
                                        //               ),
                                        //             ],
                                        //           );
                                        //         });
                                        //     print("All Done");
                                        //   }

                                        // });
                                      },
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(
                                      color: AppGlobal.PrimaryColor,
                                      value: 0.2,
                                      backgroundColor: Colors.grey,
                                    )),
                            ]
                          ]))),
                ])
              ],
            ),
          ),
          if (isConfetti)
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: ConfettiWidget(
                  confettiController: _confettiController!,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  maxBlastForce: 12,
                  minBlastForce: 10,
                  emissionFrequency: 0.32,
                  numberOfParticles: 10,
                  gravity: .35,
                  colors: [
                    Colors.green,
                    Colors.blue,
                    Colors.orange,
                    Colors.purple,
                    Colors.red,
                    Colors.yellow,
                    Colors.pink,
                    Colors.cyan,
                    Colors.teal,
                    Colors.lime,
                    Colors.amber,
                    Colors.indigo,
                    Colors.brown,
                    Colors.grey,
                    Colors.black,
                  ],
                ),
              ),
            ),
        ]));
  }
}
