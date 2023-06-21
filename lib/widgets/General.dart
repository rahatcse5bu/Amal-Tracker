//import main.dart
import 'dart:convert';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';

import '../Data/data.dart';
import '../db.dart';
import '../details.dart';
import '../global.dart';

class General extends StatefulWidget {
  General({super.key, required this.amal_date, required this.id});
  String amal_date;
  String id;
  @override
  State<General> createState() => _GeneralState();
}

class _GeneralState extends State<General> {
  bool? val = false;
  final LocalStorage storage = new LocalStorage('ramadan_planner_1');
  final dbHelper = DatabaseHelper.instance;
  bool isConfetti = false;
  ConfettiController? _confettiController;
  @override
  initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
    dbHelper
        .initializeData('General', widget.amal_date.toString())
        .then((value) => setState(() {
              print('Gen value----------------: ' + value.toString());
              dbHelper.modifiedGeneralItems = value;
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
        title: Text(
            '${DateFormat('dd MMM yyyy').format(DateTime.parse(widget.amal_date))}'),
        centerTitle: true,
        backgroundColor: AppGlobal.PrimaryColor,
        leading: IconButton(
            onPressed: () {
              Get.to(Details(
                  amal_date: widget.amal_date.toString(), id: 1.toString()));
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  // Todo list with SwitchListTile widget and a button to add new todo
                  Column(children: [
                    Card(
                        elevation: 5,
                        child: Padding(
                            padding: EdgeInsets.all(18.0),
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
                                    "অত্যন্ত প্রয়োজনীয়:}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              // CheckboxListTile

                              for (var i = 0;
                                  i < dbHelper.modifiedGeneralItems.length;
                                  i++) ...[
                                SwitchListTile(
                                  secondary: dbHelper.modifiedGeneralItems[i]
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
                                  activeColor: dbHelper.modifiedGeneralItems[i]
                                              ['isChecked'] ==
                                          false
                                      ? Colors.red
                                      : AppGlobal.PrimaryColor,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: dbHelper.modifiedGeneralItems[i]
                                              ['title'],
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: " [" +
                                              dbHelper.modifiedGeneralItems[i]
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
                                  subtitle: Text(
                                    dbHelper.modifiedGeneralItems[i]
                                        ['subTitle'],
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  value: dbHelper.modifiedGeneralItems[i]
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
                                            'General',
                                            dbHelper.modifiedGeneralItems[i]
                                                    ['id']
                                                .toString(),
                                            widget.amal_date.toString(),
                                            newValue as bool)
                                        .then((value) => setState(() {
                                              dbHelper.modifiedGeneralItems =
                                                  value;
                                            }));
                                  },
                                ),
                              ]
                            ]))),
                  ])
                ],
              )),
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
        ],
      ),
    );
  }
}
