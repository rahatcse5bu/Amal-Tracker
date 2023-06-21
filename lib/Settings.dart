import 'package:daily_amal_tracker/global.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:elegant_notification/elegant_notification.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool hayejEnabled = false;
  bool notificationEnabled = false;
  LocalStorage localStorage = LocalStorage("amal_tracker");
  TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    nameController.text = localStorage.getItem('name');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Settings'),
      // ),
      body: Center(
        child: Card(
          elevation: 7,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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

                SwitchListTile(
                  activeColor: AppGlobal.PrimaryColor,
                  title: Text('Hayej/Nefaj'),
                  value: hayejEnabled,
                  onChanged: (value) {
                    setState(() {
                      hayejEnabled = value;
                    });
                  },
                ),
                SwitchListTile(
                  activeColor: AppGlobal.PrimaryColor,
                  title: Text('Notification'),
                  value: notificationEnabled,
                  onChanged: (value) {
                    setState(() {
                      notificationEnabled = value;
                    });
                  },
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
    );
  }
}
