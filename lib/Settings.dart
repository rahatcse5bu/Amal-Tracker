import 'package:daily_amal_tracker/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:elegant_notification/elegant_notification.dart';

import 'Data/data.dart';
import 'Data/prayerData.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool hayejEnabled = false;
  bool notificationEnabled = false;
  LocalStorage localStorage = LocalStorage("amal_tracker");
  TextEditingController nameController = TextEditingController();
  List<String> dropdownValues = ['8:30', '8:45'];

  Map<String, List<String>> prayerTimeData = {
    'Fajr': ['8:34', '2:34'],
    'Dhuhr': ['8:14', '3:32'],
    'Asr': ['8:54', '2:24'],
    'Maghrib': ['8:34', '4:34'],
    'Isha': ['8:14', '1:34'],
  };

  List<String> prayers = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];

  String selectedDistrict = '';
  @override
  void initState() {
    super.initState();
    for (String prayer in prayers) {
      // selectedJamaatTimes[prayer] = jamaatTimes[0];
    }
    selectedDistrict = districtNames.first;
    nameController.text = localStorage.getItem('name');
    for (var entry in prayerTimeData.entries) {
      String prayer = entry.key;
      List<String> timeValues = entry.value;

      tableRows.add(
        TableRow(
          children: [
            TableCell(
              child: Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Text(prayer),
              ),
            ),
            TableCell(
              child: Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: DropdownButton<String>(
                  value: timeValues[0],
                  onChanged: (newValue) {
                    // Handle onChanged event if needed
                  },
                  items: timeValues.map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  List<TableRow> tableRows = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Settings'),
      // ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Card(
            elevation: 7,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(2, 10, 2, 10),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  //edit your name here textediting controller
                  TextField(
                    controller: nameController,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      labelText: 'Your Name',
                      hintText: 'Md Rahat',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                    ),
                  ),
                  //elevated button for update name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 60,
                        // width: MediaQuery.of(context).size.width * .95,
                        padding: EdgeInsets.only(top: 5, bottom: 8),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: AppGlobal.PrimaryColor,
                            onPrimary: Colors.white,
                            onSurface: Colors.grey,
                          ),
                          onPressed: () {
                            localStorage.setItem(
                                'name', nameController.text.toString());
                            ElegantNotification.success(
                                    title: Text("Updated"),
                                    description:
                                        Text("Your Name has been updated"))
                                .show(context);
                          },
                          child: Text('Update Name'),
                        ),
                      ),
                    ],
                  ),

                  //User Location Starts
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Your District:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 30),
                      DropdownButton<String>(
                        value: selectedDistrict,
                        onChanged: (newValue) {
                          setState(() {
                            selectedDistrict = newValue!;
                          });
                        },
                        items: districtNames.map((district) {
                          return DropdownMenuItem<String>(
                            value: district,
                            child: Text(district),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  //User Loaction Ends
                  // Jamaat Time Table Starts
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 5.2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        child: Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          border: TableBorder.all(
                              color: AppGlobal.PrimaryColor,
                              borderRadius: BorderRadius.circular(8.0)),
                          columnWidths: {
                            0: FlexColumnWidth(1),
                            1: FlexColumnWidth(1),
                          },
                          children: [
                            TableRow(
                              decoration: BoxDecoration(
                                color: AppGlobal.PrimaryColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0),
                                ),
                              ),
                              children: [
                                TableCell(
                                  child: Container(
                                    padding: EdgeInsets.all(15.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Prayer Name',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    padding: EdgeInsets.all(15.0),
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [
                                        Text(
                                          'Jama\'at Time',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        //info icon
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text("Jama'at Info"),
                                                  content: Text(
                                                      'Jama\'at time is the time when the jama\'at starts. It may vary based on the mosques.So, Set the time according to your mosque.'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Ok'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          icon: Icon(
                                            Icons.info,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            //test

                            //table body starts
                            //loop over prayerTimeData  map and create table row
                            // for (var entry in prayerTimeData.entries) ...[
                            //   // String prayer = ;
                            //   // List<String> timeValues = entry.value;

                            //   TableRow(
                            //     children: [
                            //       TableCell(
                            //         child: Container(
                            //           padding: EdgeInsets.all(8.0),
                            //           alignment: Alignment.center,
                            //           child: Text(entry.key),
                            //         ),
                            //       ),
                            //       TableCell(
                            //         child: Container(
                            //           padding: EdgeInsets.all(8.0),
                            //           alignment: Alignment.center,
                            //           child: DropdownButton<String>(
                            //             value: dropdownValues[0],
                            //             onChanged: (newValue) {
                            //               // Handle onChanged event if needed
                            //             },
                            //             items: dropdownValues.map((value) {
                            //               return DropdownMenuItem<String>(
                            //                 value: value,
                            //                 child: Text(value),
                            //               );
                            //             }).toList(),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ]
                            TableRow(
                              children: [
                                TableCell(
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: Text(prayers[0]),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: DropdownButton<String>(
                                      value: calculateIshaJamaat('8:31', 30)[0],
                                      onChanged: (newValue) {
                                        Get.snackbar(
                                          'Jama\'at Time Updated',
                                          'You will get notification accordingly',
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor:
                                              AppGlobal.PrimaryColor,
                                          colorText: Colors.white,
                                        );
                                      },
                                      items: calculateIshaJamaat('8:31', 30)
                                          .map((value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: Text(prayers[1]),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: DropdownButton<String>(
                                      value: dropdownValues[1],
                                      onChanged: (newValue) {
                                        // Handle onChanged event if needed
                                      },
                                      items: dropdownValues.map((value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: Text(prayers[2]),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: DropdownButton<String>(
                                      value: dropdownValues[1],
                                      onChanged: (newValue) {
                                        // Handle onChanged event if needed
                                      },
                                      items: dropdownValues.map((value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: Text(prayers[3]),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: DropdownButton<String>(
                                      value: dropdownValues[1],
                                      onChanged: (newValue) {
                                        // Handle onChanged event if needed
                                      },
                                      items: dropdownValues.map((value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Repeat the above pattern for the remaining prayers
                            TableRow(
                              children: [
                                TableCell(
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: Text(prayers[4]),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: DropdownButton<String>(
                                      value: dropdownValues[1],
                                      onChanged: (newValue) {
                                        // Handle onChanged event if needed
                                      },
                                      items: dropdownValues.map((value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  // End of Jamaat Table

                  // SwitchListTile(
                  //   activeColor: AppGlobal.PrimaryColor,
                  //   title: Text('Hayej/Nefaj'),
                  //   value: hayejEnabled,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       hayejEnabled = value;
                  //     });
                  //   },
                  // ),
                  SizedBox(height: 20.0),
                  Container(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 5.2,
                      child: SwitchListTile(
                        activeColor: AppGlobal.PrimaryColor,
                        title: Text('Notification'),
                        value: localStorage.getItem('notification') == null
                            ? false
                            : localStorage.getItem('notification'),
                        onChanged: (value) async {
                          final service = await FlutterBackgroundService();
                          bool isRunning = await service.isRunning();
                          if (value == true) {
                            ElegantNotification.success(
                                    title: Text("Notification Enabled"),
                                    description: Text(
                                        "You will get notification everyday"))
                                .show(context);
                            FlutterBackgroundService()
                                .invoke('setAsForeground');

                            if (isRunning) {
                              // service.invoke('stopService');
                            } else {
                              service.startService();
                            }

                            localStorage.setItem('notification', true);
                          } else {
                            ElegantNotification.error(
                              title: Text("Notification Disabled"),
                              description: Text(
                                  "You will not get notification everyday"),
                            ).show(context);
                            FlutterBackgroundService().invoke('stopService');
                            service.invoke('stopService');
                            localStorage.setItem('notification', false);
                          }
                          setState(() {
                            notificationEnabled = value;
                          });
                        },
                      ),
                    ),
                  ),
                  // a button for going to DuaScreen() widget
                  Container(
                    width: MediaQuery.of(context).size.width * .95,
                    height: 90,
                    padding: EdgeInsets.only(top: 20, bottom: 15),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppGlobal.PrimaryColor,
                        onPrimary: Colors.white,
                        onSurface: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/dua');
                      },
                      child: Text('Dua List'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
