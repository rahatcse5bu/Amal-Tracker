import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'Objects/Asr.dart';
import 'Objects/Dhuhr.dart';
import 'Objects/Fajr.dart';
import 'Objects/General.dart';
import 'Objects/Isha.dart';
import 'Objects/Maghrib.dart';
import 'db.dart';
import 'global.dart';

class Overview extends StatefulWidget {
  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  final dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> prayerItems = [];

  Future<List<PrayerData>> initializeData(
      String tableName, String columnDate, String amal_date) async {
    List<Map<String, dynamic>> modifiedItems = await dbHelper
        .fetchValuesFromDatabase(tableName, columnDate, amal_date, prayerItems);
    List<PrayerData> prayerDataList = [];

    for (var item in modifiedItems) {
      DateTime date = item[columnDate];
      double totalPoints = 0;

      // Calculate total points for the date
      prayerItems.forEach((prayerItem) {
        double points = item[prayerItem['id']];
        totalPoints += points ?? 0;
      });

      prayerDataList.add(PrayerData(date, totalPoints));
    }

    return prayerDataList;
  }

  Future<List<PrayerData>> fetchPrayerData(
      String tableName, String columnDate, String amal_date) async {
    switch (tableName) {
      case 'Fajr':
        return initializeData(tableName, columnDate, amal_date);
      case 'Dhuhr':
        return initializeData(tableName, columnDate, amal_date);
      case 'General':
        return initializeData(tableName, columnDate, amal_date);
      case 'Asr':
        return initializeData(tableName, columnDate, amal_date);
      case 'Maghrib':
        return initializeData(tableName, columnDate, amal_date);
      case 'Isha':
        return initializeData(tableName, columnDate, amal_date);
      default:
        return [];
    }
  }

  Future<Map<String, List<PrayerData>>> fetchAllPrayerData(
      List<String> tableNames) async {
    Database db = await dbHelper.database;
    Map<String, List<PrayerData>> prayerDataByTable = {};

    for (var tableName in tableNames) {
      List<Map<String, dynamic>> fetchedItems = await db.query(tableName);

      List<PrayerData> prayerDataList = [];

      for (var item in fetchedItems) {
        String dateString = item['Date'];
        DateTime date = DateFormat('dd MMM yyyy').parse(dateString);
        double points = item['points'] ?? 0.0;

        PrayerData prayerData = PrayerData(date, points);
        prayerDataList.add(prayerData);
      }

      prayerDataByTable[tableName] = prayerDataList;
    }

    return prayerDataByTable;
  }

  List<String> myTableNames = [
    'Fajr',
    'Dhuhr',
    'General',
    'Asr',
    'Maghrib',
    'Isha'
  ];
  String formattedStringDate =
      '${DateTime.now().day.toString().padLeft(2, '0')} ${DateFormat.MMM().format(DateTime.now())} ${DateTime.now().year}';

  Future<List<PrayerData>> prayerDateByTable(String Table) async {
    Map<String, List<PrayerData>> prayerDataByTable =
        await fetchAllPrayerData(myTableNames);
    switch (Table) {
      case 'Fajr':
        return prayerDataByTable['Fajr']!;
      case 'Dhuhr':
        return prayerDataByTable['Dhuhr']!;
      case 'General':
        return prayerDataByTable['General']!;
      case 'Asr':
        return prayerDataByTable['Asr']!;
      case 'Maghrib':
        return prayerDataByTable['Maghrib']!;
      case 'Isha':
        return prayerDataByTable['Isha']!;

      default:
        return [];
    }
  }

  // List<PrayerData> fajrData = [];
  // List<PrayerData> dhuhrData = [];
  // List<PrayerData> asrData = [];
  // List<PrayerData> generalData = [];
  // List<PrayerData> maghribData = [];
  // List<PrayerData> ishaData = [];

  // Future<Map<String, List<PrayerData>>> prayerDataByTable =
  Future<void> fetchLast2MonthData() async {
    DateTime startDate = DateTime.now().subtract(Duration(days: 60));
    DateTime endDate = DateTime.now();
    try {
      await dbHelper.getDataInRangeForFilter('Fajr', startDate, endDate).then(
            (value) => setState(() {
              fajrData = value;
              print('my data => ' + value.toString());
            }),
          );
      await dbHelper.getDataInRangeForFilter('Dhuhr', startDate, endDate).then(
            (_dhuhr) => setState(() => {
                  dhuhrData = _dhuhr,
                  print('dhhr data => ' + _dhuhr.toString()),
                }),
          );
      await dbHelper
          .getDataInRangeForFilter('General', startDate, endDate)
          .then((_general) => {
                setState(() => {generalData = _general}),
              });

      await dbHelper
          .getDataInRangeForFilter('Asr', startDate, endDate)
          .then((_asr) => {
                setState(() => {asrData = _asr}),
              });
      await dbHelper
          .getDataInRangeForFilter('Maghrib', startDate, endDate)
          .then((_maghrib) => {
                setState(() => {maghribData = _maghrib}),
              });
      await dbHelper
          .getDataInRangeForFilter('Isha', startDate, endDate)
          .then((_isha) => {
                setState(() => {ishaData = _isha}),
              });
      await dbHelper
          .getDataInRangeForFilter('Fazayel', startDate, endDate)
          .then((_fazayel) => {
                setState(() => {fazayelData = _fazayel}),
              });
    } catch (error) {
      // Handle any errors that occurred during execution
      print('Error: $error');
    }
  }

  var twoMonthsAgo = DateFormat('dd MMM yyyy')
      .format(DateTime.now().subtract(Duration(days: 60)));

  var today = DateFormat('dd MMM yyyy').format(DateTime.now());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchLast2MonthData();
    final dateTime = DateTime.now().subtract(Duration(days: 60));
    twoMonthsAgo = DateFormat('dd MMM yyyy').format(dateTime);
    today = DateFormat('dd MMM yyyy').format(DateTime.now());
    // fetchData();
  }

  Future<void> fetchData() async {
    prayerItems.addAll(Fajr_Items);
    prayerItems.addAll(Dhuhr_Items);
    prayerItems.addAll(General_Items);
    prayerItems.addAll(Asr_Items);
    prayerItems.addAll(Maghrib_Items);
    prayerItems.addAll(Isha_Items);

    fajrData = await prayerDateByTable('Fajr');
    dhuhrData = await prayerDateByTable('Dhuhr');
    generalData = await prayerDateByTable('General');
    asrData = await prayerDateByTable('Asr');
    maghribData = await prayerDateByTable('Maghrib');
    ishaData = await prayerDateByTable('Isha');

    setState(() {});
  }

  List<PrayerData> fajrData = [];

  List<PrayerData> dhuhrData = [];

  List<PrayerData> generalData = [];

  List<PrayerData> asrData = [];

  List<PrayerData> maghribData = [];

  List<PrayerData> ishaData = [];
  List<PrayerData> fazayelData = [
    // PrayerData(DateTime(2023, 1, 1), 40),
    // PrayerData(DateTime(2023, 1, 2), 60),
    // PrayerData(DateTime(2023, 1, 3), 30),
    // // Add more data points as needed
  ];
  List<Map<String, dynamic>> data = [];
  late DateTime startDate;
  late DateTime endDate;
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
                          DateFormat('yyyy-MM-dd').format(selectedDate);
                      // print('Start Date=> ' + endDate.toString());
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
                      icon: Icon(Icons.calendar_today), onPressed: (() => {})),
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
                          DateFormat('yyyy-MM-dd').format(selectedDate);
                      // print('End Date=> ' + endDate.toString());
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
                      icon: Icon(Icons.calendar_today), onPressed: () {}),
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
                  setState(() {
                    final formattedStartDate =
                        DateFormat('dd MMM yyyy').format(startDate);
                    final formattedEndDate =
                        DateFormat('dd MMM yyyy').format(endDate);
                    twoMonthsAgo = formattedStartDate.toString();
                    today = formattedEndDate.toString();
                  });
                  // Perform filtering based on the selected dates
                  // ...
                  // Close the bottom sheet
                  try {
                    await dbHelper
                        .getDataInRangeForFilter('Fajr', startDate, endDate)
                        .then(
                          (value) => setState(() {
                            fajrData = value;
                            // print('my data => ' + value.toString());
                          }),
                        );
                    await dbHelper
                        .getDataInRangeForFilter('Dhuhr', startDate, endDate)
                        .then(
                          (_dhuhr) => setState(() => {
                                dhuhrData = _dhuhr,
                                // print('dhhr data => ' + _dhuhr.toString()),
                              }),
                        );
                    await dbHelper
                        .getDataInRangeForFilter('General', startDate, endDate)
                        .then((_general) => {
                              setState(() => {generalData = _general}),
                            });

                    await dbHelper
                        .getDataInRangeForFilter('Asr', startDate, endDate)
                        .then((_asr) => {
                              setState(() => {asrData = _asr}),
                            });
                    await dbHelper
                        .getDataInRangeForFilter('Maghrib', startDate, endDate)
                        .then((_maghrib) => {
                              setState(() => {maghribData = _maghrib}),
                            });
                    await dbHelper
                        .getDataInRangeForFilter('Isha', startDate, endDate)
                        .then((_isha) => {
                              setState(() => {ishaData = _isha}),
                            });
                    await dbHelper
                        .getDataInRangeForFilter('Fazayel', startDate, endDate)
                        .then((_fazayel) => {
                              setState(() => {fazayelData = _fazayel}),
                            });

                    Navigator.pop(context);
                  } catch (error) {
                    // Handle any errors that occurred during execution
                    print('Error: $error');
                  }
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
      //   title: Text('Overview'),
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppGlobal.PrimaryColor,
        onPressed: () => {
          _showBottomSheet(),
          // _deleteData(2);
        },
        child: Icon(Icons.filter_alt_outlined),
      ),
      body:
          //tabs view
          DefaultTabController(
        length: 7,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Overview"),
            leading: Text(""),
            backgroundColor: AppGlobal.PrimaryColor,
            bottom: TabBar(
              physics: ScrollPhysics(),
              isScrollable: true,
              dividerColor: Colors.white,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                // color: Colors.white,
              ),
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  child: Text('ফজর'),
                ),
                Tab(
                  child: Text('যোহর'),
                ),
                Tab(
                  child: Text('দৈনন্দিন কার্যক্রম'),
                ),
                Tab(
                  child: Text('আসর'),
                ),
                Tab(
                  child: Text('মাগরিব'),
                ),
                Tab(
                  child: Text('ইশা'),
                ),
                Tab(
                  child: Text("ফাযায়েলে 'আমাল"),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: _buildPrayerCard('Fajr', fajrData)),
              SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: _buildPrayerCard('Dhuhr', dhuhrData)),
              SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: _buildPrayerCard('General', generalData)),
              SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: _buildPrayerCard('Asr', asrData)),
              SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: _buildPrayerCard('Maghrib', maghribData)),
              SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: _buildPrayerCard('Isha', ishaData)),
              SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: _buildPrayerCard('Fazayel', fazayelData)),
            ],
          ),
        ),
      ),

      // ListView(
      //   padding: EdgeInsets.all(16),
      //   children: [
      //     _buildPrayerCard('Fajr', fajrData),
      //     _buildPrayerCard('Dhuhr', dhuhrData),
      //     _buildPrayerCard('General', generalData),
      //     _buildPrayerCard('Asr', asrData),
      //     _buildPrayerCard('Maghrib', maghribData),
      //     _buildPrayerCard('Isha', ishaData),
      //     _buildPrayerCard('Fazayel', fazayelData),
      //   ],
      // ),
    );
  }

  String engToBangla(String title) {
    switch (title) {
      case 'Fajr':
        return 'ফজর';
      case 'Dhuhr':
        return 'যোহর';
      case 'General':
        return 'দৈনন্দিন কার্যক্রম';
      case 'Asr':
        return 'আসর';
      case 'Maghrib':
        return 'মাগরিব';
      case 'Isha':
        return 'ইশা';
      case 'Fazayel':
        return "ফাযায়েলে 'আমাল";

      default:
        return title;
    }
  }

  Widget _buildPrayerCard(String title, List<PrayerData> data) {
    return Card(
      child: Column(
        children: [
          Container(
            // color: AppGlobal.PrimaryColor,
            padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: AppGlobal.PrimaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
            child: Center(
              child: Text(
                engToBangla(title),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 15),

          Container(
              child: Center(
            child: Text("Showing From ${twoMonthsAgo} to ${today}",
                style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          )),
          SizedBox(height: 15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: SfCircularChart(
                series: <CircularSeries>[
                  PieSeries<PrayerData, DateTime>(
                    dataSource: data,
                    radius: '93%',
                    xValueMapper: (PrayerData prayer, _) => prayer.date,
                    yValueMapper: (PrayerData prayer, _) => prayer.points,
                    enableTooltip: true,
                    dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      textStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: SfCartesianChart(
                primaryXAxis: DateTimeAxis(),
                primaryYAxis: LogarithmicAxis(),
                series: <ChartSeries>[
                  LineSeries<PrayerData, DateTime>(
                    color: AppGlobal.PrimaryColor,
                    enableTooltip: true,
                    name: 'Prayer Points',
                    // width: 2,
                    xAxisName: 'Date',
                    yAxisName: 'Points',
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    markerSettings: MarkerSettings(isVisible: true),
                    dataSource: data,
                    xValueMapper: (PrayerData data, _) => data.date,
                    yValueMapper: (PrayerData data, _) => data.points,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          //column/bar Chart here
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: SfCartesianChart(
                primaryXAxis: DateTimeAxis(),
                primaryYAxis: LogarithmicAxis(),
                series: <ChartSeries>[
                  ColumnSeries<PrayerData, DateTime>(
                    width: .8,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    markerSettings: MarkerSettings(isVisible: true),
                    pointColorMapper: (PrayerData data, _) {
                      // Customize color based on data value
                      if (data.points >= 500) {
                        return Colors.red;
                      } else if (data.points >= 300) {
                        return Colors.orange;
                      } else {
                        return Colors.green;
                      }
                    },
                    dataSource: data,
                    xValueMapper: (PrayerData data, _) => data.date,
                    yValueMapper: (PrayerData data, _) => data.points,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: SfCartesianChart(
                primaryXAxis: DateTimeAxis(),
                primaryYAxis: LogarithmicAxis(),
                series: <ChartSeries>[
                  AreaSeries<PrayerData, DateTime>(
                    dataSource: data,
                    isVisible: true,
                    color: AppGlobal.PrimaryColor,
                    borderColor: Colors.amber,
                    borderDrawMode: BorderDrawMode.top,
                    dashArray: <double>[5, 5],
                    borderWidth: 2,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    isVisibleInLegend: true,
                    xAxisName: 'Date',
                    yAxisName: 'Points',
                    gradient: LinearGradient(
                      colors: <Color>[
                        AppGlobal.PrimaryColor,
                        Colors.orange,
                      ],
                      stops: <double>[0.2, 0.9],
                    ),
                    xValueMapper: (PrayerData prayer, _) => prayer.date,
                    yValueMapper: (PrayerData prayer, _) => prayer.points,
                    enableTooltip: true,
                  ),
                ],
                trackballBehavior: TrackballBehavior(
                  enable: true,
                  activationMode: ActivationMode.singleTap,
                  tooltipSettings: InteractiveTooltip(
                    enable: true,
                    color: Colors.grey[200],
                    textStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PrayerData {
  final DateTime date;
  final double points;

  PrayerData(this.date, this.points);
}
