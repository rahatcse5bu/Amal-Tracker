import 'package:daily_amal_tracker/BottomSheet.dart';
import 'package:daily_amal_tracker/Data/data.dart';
import 'package:daily_amal_tracker/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sqflite/sqflite.dart';

import 'Objects/Fajr.dart';
import 'db.dart';
import 'details.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> data = [];
  Random random = Random();
  int randomBool() => random.nextBool() ? 1 : 0;

  // String formattedDate = DateTime.now().toIso8601String().substring(0, 10);
  // String formattedStringDate =
  //     '${DateTime.now().day.toString().padLeft(2, '0')} ${DateFormat.MMM().format(DateTime.now())} ${DateTime.now().year}';
  String formattedStringDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    // Inserting initial values into the database
    // _insertIshaData('Isha');
    // _insertFazayelData('Fazayel');
    checkIfRowExists(formattedStringDate).then((value) {
      if (value == false) {
        print("No Row Exists");
        _insertData('Fajr');
        _insertDhuhrData('Dhuhr');
        _insertGeneralData('General');
        _insertAsrData('Asr');
        _insertMaghribData('Maghrib');
        _insertIshaData('Isha');
        _insertFazayelData('Fazayel');
      } else {
        print("Row already Exists: History Init");
        // _deleteData('Fajr', formattedStringDate);
        // _deleteData('Dhuhr', formattedStringDate);
        // _deleteData('Asr', formattedStringDate);
        // _deleteData('General', formattedStringDate);
        // _deleteData('Maghrib', formattedStringDate);
        // _deleteData('Isha', formattedStringDate);
        // fetchData('Fajr');
      }
      fetchData('Fajr');
    });
    // List data = dbHelper.getAllData() as List;
    // print("Hello World");
    // print(data.toString());
  }

  Future<void> fetchData(String Table) async {
    List<Map<String, dynamic>> fetchedData = await dbHelper.getAllData(Table);
    setState(() {
      data = fetchedData;
    });
  }

  Future<bool> _insertData(String Table) async {
    try {
      Map<String, dynamic> row2 = {
        'Date': formattedStringDate,
        'Tahajjud': 0,
        'Azan_Reply': 0,
        'Tahiyatul_Masjid': 0,
        'Two_Sunnah_Rakat': 0,
        'Two_Fard_Rakat': 0,
        'Ayatul_Kursi': 0,
        'Thirty_Three_Tasbih': 0,
        'Ten_Tasbih': 0,
        'Three_Surah': 0,
        'Hundred_Subhanallah_Wa_Bihamdihi': 0,
      };
      await dbHelper.insertData(Table, row2);
      return true;
    } catch (e) {
      if (e is DatabaseException && e.isUniqueConstraintError()) {
        print('Duplicate date. Cannot insert the same date again.');
      } else {
        print('Error occurred while inserting data: $e');
      }
      return false;
    }
  }

  Future<bool> _insertDhuhrData(String Table) async {
    try {
      Map<String, dynamic> row2 = {
        'Date': formattedStringDate,
        'Azan_Reply': 0,
        'Two_Tahiyatul_Mosjid': 0,
        'Four_Sunnah_Rakat': 0,
        'Four_Fard': 0,
        'Ayatul_Kursi': 0,
        'Thirty_Three_Tasbih': 0,
        'Ten_Tasbih': 0,
        'Two_Sunnah_Rakat': 0,
        'Two_Nafil': 0,
      };
      await dbHelper.insertData(Table, row2);
      return true;
    } catch (e) {
      if (e is DatabaseException && e.isUniqueConstraintError()) {
        print('Duplicate date. Cannot insert the same date again.');
      } else {
        print('Error occurred while inserting data: $e');
      }
      return false;
    }
  }

  Future<bool> _insertGeneralData(String Table) async {
    try {
      Map<String, dynamic> rowData = {
        'Date': formattedStringDate,
        'non_Mahram_Kotha': 0,
        'non_Mahram_Dristi': 0,
        'unnecessary_Tasks': 0,
        'hundred_Istigfar': 0,
        'moja_Kore_Mittha': 0,
        'salat_Khushukhuju': 0,
        'five_TK_Swadhaka': 0,
        'oshlilota_Porihar': 0,
        'gheebat_Porihar': 0,
        'sura_Ikhlas': 0,
      };

      await dbHelper.insertData(Table, rowData);
      return true;
    } catch (e) {
      if (e is DatabaseException && e.isUniqueConstraintError()) {
        print('Duplicate date. Cannot insert the same date again.');
      } else {
        print('Error occurred while inserting data: $e');
      }
      return false;
    }
  }

  Future<bool> _insertAsrData(String Table) async {
    try {
      Map<String, dynamic> row = {
        'Date': formattedStringDate,
        'azan_Reply': 0,
        'tahiyatul_Mosjid': 0,
        'four_Rakaat_Fard': 0,
        'ayatul_Kursi': 0,
        'Thirty_Three_Tasbih': 0,
        'Ten_Tasbih': 0,
      };
      await dbHelper.insertData(Table, row);
      return true;
    } catch (e) {
      if (e is DatabaseException && e.isUniqueConstraintError()) {
        print('Duplicate date. Cannot insert the same date again.');
      } else {
        print('Error occurred while inserting data: $e');
      }
      return false;
    }
  }

  Future<bool> _insertMaghribData(String table) async {
    try {
      Map<String, dynamic> row = {
        'Date': formattedStringDate,
        'Azan_Reply': 0,
        'Three_Rakat_Fard': 0,
        'Ayatul_Kursi': 0,
        'Thirty_Three_Tasbih': 0,
        'Ten_Tasbih': 0,
        'Three_Surah': 0,
        'Hundred_Subhanallah_Wa_Bihamdihi': 0,
        'Two_Rakat_Sunnah': 0,
      };

      await dbHelper.insertData(table, row);
      return true;
    } catch (e) {
      if (e is DatabaseException && e.isUniqueConstraintError()) {
        print('Duplicate date. Cannot insert the same date again.');
      } else {
        print('Error occurred while inserting data: $e');
      }
      return false;
    }
  }

  Future<bool> _insertIshaData(String table) async {
    try {
      Map<String, dynamic> row = {
        'Date': formattedStringDate,
        'Azan_Reply': 0,
        'Tahiyatul_Mosjid': 0,
        'Four_Rakat_Fard': 0,
        'Ayatul_Kursi': 0,
        'Thirty_Three_Tashbih': 0,
        'Two_Rakat_Sunnah': 0,
        'Witr': 0,
      };

      await dbHelper.insertData(table, row);
      return true;
    } catch (e) {
      if (e is DatabaseException && e.isUniqueConstraintError()) {
        print('Duplicate date. Cannot insert the same date again.');
      } else {
        print('Error occurred while inserting data: $e');
      }
      return false;
    }
  }

  Future<bool> _insertFazayelData(String table) async {
    try {
      Map<String, dynamic> row = {
        'Date': formattedStringDate,
        'BishesDua': 0,
        'Char_Jon_Golam': 0,
        'Dosh_Golam_Eksho_Neki': 0,
        'Somudrer_Fena': 0,
        'Mizaner_Palla': 0,
        'Hajar_Neki': 0,
        'Jannater_Guptodhon': 0,
        'Sottur_Onisto': 0,
        'Sorbosrestho_Dua': 0,
        'Sorbottom_Jikr': 0,
        'Chiroyesthayee_Nek_Amal': 0,
        'Quran_Ek_tritiyo': 0,
        'Beshi_Beshi_Ikhlash': 0,
        'Suparish': 0,
        'Raat_E_Bakara': 0,
        'Ekti_Sorner_Prashadh': 0,
        'Jahannam_Mukti_Swarner_Gach': 0,
        'Jannate_Ekti_Khajur_Gach': 0,
        'Jannat_Lav_Jahannam_Mukti': 0,
        'Deen_Otol_Thaka': 0,
        'Islam_Otol_Thaka': 0,
        'Gunah_Maf_Chaowa': 0,
        'Rasul_Istigfar': 0,
        'Rasul_Istigfar_Mrittur_Agee': 0,
        'Darud_Pathh': 0,
      };

      await dbHelper.insertData(table, row);

      return true;
    } catch (e) {
      if (e is DatabaseException && e.isUniqueConstraintError()) {
        print('Duplicate date. Cannot insert the same date again.');
      } else {
        print('Error occurred while inserting data: $e');
      }
      return false;
    }
  }

  Future<bool> checkIfRowExists(String formattedStringDate) async {
    Database db = await DatabaseHelper.instance.database;
    int count = 0;
    List<String> tables = [
      'Fajr',
      'Dhuhr',
      'Asr',
      'Maghrib',
      'General',
      'Isha',
      'Fazayel',
    ];

    for (String table in tables) {
      List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT * FROM $table WHERE Date = ?',
        [formattedStringDate],
      );
      count += result.length;
      // print("result: ${result.length}");

      // String query = 'SELECT * FROM $table WHERE Date = ?';
      // print("Query for $table is: $query");
    }
    // print("count: $count");
    if (count == tables.length) {
      return true;
    } else {
      // Row with today's date does not exist in any table
      return false;
    }
  }

  void _deleteData(String Table, String date) async {
    // Delete data based on Roll
    print("date to be deleted: $date");
    int deletedRowCount = await dbHelper.deleteData(Table, date);
    setState(() {
      // data.removeWhere((element) => element[dbHelper.columnId] == id);
      fetchData(Table);
    });
    print('Deleted rows: $deletedRowCount');
  }

  Future<int> pointsByDate(String formatedStringDate) async {
    int todaysPoint = 0;

    todaysPoint += await dbHelper.getTodaysPoint('Fajr', formatedStringDate);
    todaysPoint += await dbHelper.getTodaysPoint('Dhuhr', formatedStringDate);
    todaysPoint += await dbHelper.getTodaysPoint('General', formatedStringDate);
    todaysPoint += await dbHelper.getTodaysPoint('Asr', formatedStringDate);
    todaysPoint += await dbHelper.getTodaysPoint('Maghrib', formatedStringDate);
    todaysPoint += await dbHelper.getTodaysPoint('Isha', formatedStringDate);
    todaysPoint += await dbHelper.getTodaysPoint('Fazayel', formatedStringDate);
    return todaysPoint;
  }

  List<String> myTableNames = [
    'Fajr',
    'Dhuhr',
    'General',
    'Asr',
    'Maghrib',
    'Isha',
    'Fazayel'
  ];

  DateTime? startDate;
  DateTime? endDate;
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  Future<List<Map<String, dynamic>>> fetchDataByRange(String table) async {
    List<Map<String, dynamic>> fetchedData =
        await dbHelper.getDataInRange(table, startDate!, endDate!);
    setState(() {
      data = fetchedData;
      // print('Data====>' + data.toString());
    });
    return fetchedData;
  }

  // Function to show the bottom sheet
  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Start Date input
              SizedBox(height: 16.0),
              Container(
                // color: AppGlobal.PrimaryColor,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: AppGlobal.PrimaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0))),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
                child: Center(
                  child: Text('Filter By Date:',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black,
                              offset: Offset(5.0, 5.0),
                            ),
                          ])),
                ),
              ),

              SizedBox(height: 16.0),
              TextField(
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      startDate = selectedDate;
                      _startDateController.text =
                          DateFormat('dd-MM-yyyy').format(selectedDate);

                      print('Start Date=> ' + endDate.toString());
                    });
                  }
                },
                controller: _startDateController,
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0))),
                  hintText: 'Start Date',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          startDate = selectedDate;
                          print('Start Date=> ' + endDate.toString());
                        });
                      }
                    },
                  ),
                ),
                // onTap: () {
                //   _selectDate(context);
                // },
              ),
              SizedBox(height: 16.0),
              // End Date input

              //textformfield date picker
              TextFormField(
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      endDate = selectedDate;
                      _endDateController.text =
                          DateFormat('dd-MM-yyyy').format(selectedDate);
                      print('End Date=> ' + endDate.toString());
                    });
                  }
                },
                controller: _endDateController,
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0))),
                  hintText: 'End Date',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          endDate = selectedDate;
                          print('End Date=> ' + endDate.toString());
                        });
                      }
                    },
                  ),
                ),
                // onTap: () {
                //   _selectDate(context);
                // },
              ),

              SizedBox(height: 16.0),
              // Filter button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: AppGlobal.PrimaryColor,
                    backgroundColor: AppGlobal.PrimaryColor,
                    elevation: 5,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    )),
                onPressed: () async {
                  // Perform filtering based on the selected dates
                  // ...
                  // Close the bottom sheet

                  fetchDataByRange('Fajr').then(
                    (value) => setState(() {
                      data = value;
                      print('my data => ' + data.toString());
                    }),
                  );
                  Navigator.pop(context);
                },
                child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                    child: Center(
                        child: Text('Filter', style: TextStyle(fontSize: 20)))),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('History'),
      //   backgroundColor: AppGlobal.PrimaryColor,
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: MediaQuery.of(context).size.width * .98,
                margin: EdgeInsets.only(top: 10, bottom: 5),
                decoration: BoxDecoration(
                    color: AppGlobal.PrimaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      // bottomLeft: Radius.circular(500),
                      // bottomRight: Radius.circular(900),
                    ),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                      style: BorderStyle.solid,
                    )),
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Center(
                    child: Text("History",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)))),
            data.length > 0
                ? SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        for (final item in data)
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.75),
                                      spreadRadius: 1.0,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  // color: AppGlobal.PrimaryColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: ListTile(
                                    // tileColor: AppGlobal.PrimaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Details(
                                                amal_date: item[dbHelper
                                                        .fajr.columnDate]
                                                    .toString(),
                                                id: item[dbHelper.fajr.columnId]
                                                    .toString())),
                                      );

                                      // _deleteData(item[dbHelper.columnId]);
                                    },
                                    leading: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(6.0), //or 15.0

                                      child: Container(
                                        height: 80.0,
                                        width: 130.0,
                                        color: AppGlobal.PrimaryColor,
                                        child: Center(
                                          child: Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                item[dbHelper
                                                            .fajr.columnDate] ==
                                                        formattedStringDate
                                                    ? Text(
                                                        "Today",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.white),
                                                      )
                                                    : Text(
                                                        DateFormat(
                                                                'dd MMM yyyy')
                                                            .format(DateTime.parse(
                                                                item[dbHelper
                                                                    .fajr
                                                                    .columnDate]))
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                Text(
                                                  "",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    iconColor: Colors.blue,
                                    subtitle: FutureBuilder<double>(
                                      future: dbHelper.getTodaysTotalProgress(
                                          myTableNames,
                                          item[dbHelper.fajr.columnDate]
                                              .toString()),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<double> snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Container(
                                              height: 30,
                                              width: 30,
                                              child: CircularProgressIndicator(
                                                backgroundColor: Colors.white,
                                              )); // Show a loading indicator while waiting for the result
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}'); // Show an error message if an error occurred
                                        } else {
                                          double progress = snapshot.data ??
                                              0; // Retrieve the result from the snapshot

                                          return LinearPercentIndicator(
                                            // barRadius: 20.0,
                                            leading: Text(''),
                                            alignment: MainAxisAlignment.start,
                                            width: 120.0,
                                            lineHeight: 15.0,
                                            percent: progress.toPrecision(2),
                                            animation: true,
                                            curve: Curves.easeInCirc,
                                            // restartAnimation: true,
                                            animationDuration: 1000,
                                            clipLinearGradient: true,
                                            // isRTL: true,
                                            maskFilter: MaskFilter.blur(
                                                BlurStyle.solid, 3),

                                            barRadius: Radius.circular(5),
                                            center: Text(
                                              "${(progress * 100).toStringAsFixed(2)}%",
                                              style: new TextStyle(
                                                  fontSize: 10.0,
                                                  color: Colors.white),
                                            ),
                                            trailing: Center(
                                                child: Icon(Icons.mood,
                                                    color: Colors.white)),
                                            linearStrokeCap:
                                                LinearStrokeCap.roundAll,
                                            backgroundColor: Colors.grey,
                                            progressColor:
                                                AppGlobal.PrimaryColor,
                                          );
                                        }
                                      },
                                    ),
                                    title: FutureBuilder<num>(
                                        future: dbHelper
                                            .todaysGrossTotalAchievedPoint(
                                                myTableNames,
                                                item[dbHelper.fajr.columnDate]
                                                    .toString()),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<num> snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Container(
                                                height: 30,
                                                width: 30,
                                                child:
                                                    CircularProgressIndicator(
                                                  backgroundColor: Colors.white,
                                                )); // Show a loading indicator while waiting for the result
                                          } else if (snapshot.hasError) {
                                            return Text(
                                                'Error: ${snapshot.error}'); // Show an error message if an error occurred
                                          } else {
                                            num progress = snapshot.data ??
                                                0; // Retrieve the result from the snapshot
                                            return Text(
                                                '   ${progress.toString()}/${dbHelper.grossTotalAvailablePoints(myTableNames)} ',
                                                style: TextStyle(fontSize: 13));
                                          }
                                        }),

                                    // Text(
                                    //     "Points: ${dbHelper.todaysGrossTotalAchievedPoint(myTableNames, item[dbHelper.fajr.columnDate].toString())}"),

                                    // minVerticalPadding: 18,
                                    horizontalTitleGap: 10,
                                    minLeadingWidth: 10,

                                    // isThreeLine: true,
                                    //  Text(${pointsByDate(formattedStringDate.toString()).then()}),
                                    trailing: IconButton(
                                      onPressed: () {
                                        _deleteData('Fajr',
                                            item[dbHelper.fajr.columnDate]);
                                        _deleteData('Dhuhr',
                                            item[dbHelper.dhuhr.columnDate]);
                                        _deleteData('Asr',
                                            item[dbHelper.asr.columnDate]);
                                        _deleteData('General',
                                            item[dbHelper.general.columnDate]);
                                        _deleteData('Maghrib',
                                            item[dbHelper.maghrib.columnDate]);
                                        _deleteData('Isha',
                                            item[dbHelper.isha.columnDate]);
                                        _deleteData('Fazayel',
                                            item[dbHelper.fazayel.columnDate]);
                                        // fetchData('Fajr');
                                        setState(() {});
                                        Navigator.popAndPushNamed(
                                            context, '/history');
                                      },
                                      icon:
                                          Icon(Icons.delete, color: Colors.red),
                                    ),
                                  ),
                                ),
                              ),
                              Divider(),
                            ],
                          ),
                        // bootom sheet
                      ],
                    ),
                  )
                : Center(
                    child: Text("No Data Found"),
                  ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // FloatingActionButton(
          //   backgroundColor: AppGlobal.PrimaryColor,
          //   onPressed: () => {
          //     // _updateData
          //   },
          //   child: Icon(Icons.edit),
          // ),
          SizedBox(height: 16),
          FloatingActionButton(
            backgroundColor: AppGlobal.PrimaryColor,
            onPressed: () => {
              _showBottomSheet(),
              // _deleteData(2);
            },
            child: Icon(Icons.filter_alt_sharp),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            backgroundColor: AppGlobal.PrimaryColor,
            onPressed: () => {
              checkIfRowExists(formattedStringDate).then((value) {
                if (value) {
                  print('Row exists');
                  Get.to(
                      Details(
                        amal_date: formattedStringDate,
                        id: formattedStringDate,
                      ),
                      transition: Transition.rightToLeftWithFade,
                      duration: Duration(milliseconds: 990));
                } else {
                  print('Row does not exist');
                  _insertData('Fajr')
                      .then((value) => _insertDhuhrData('Dhuhr'))
                      .then((value) => _insertAsrData('Asr'))
                      .then((value) => _insertGeneralData('General'))
                      .then((value) => _insertMaghribData('Maghrib'))
                      .then((value) => _insertFazayelData('Fazayel'))
                      .then((value) => fetchData('Fajr'));
                  // .then((value) => _insertIshaData('Isha')),
                }
              }),
            },
            child: Icon(Icons.add),
          ),
        ],
      ),

      // showMaterialModalBottomSheet(
      //   expand: false,
      //   context: context,
      //   backgroundColor: Colors.transparent,
      //   builder: (context) => ModalFit(),
      // ),
    );
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // Insert data manually when the widget dependencies have changed
  //   _insertData();
  // }
}
