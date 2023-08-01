//import material dart package
import 'package:daily_amal_tracker/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';

import 'global.dart';

class GetGender extends StatefulWidget {
  const GetGender({super.key});

  @override
  State<GetGender> createState() => _GetGenderState();
}

class _GetGenderState extends State<GetGender> {
  String GenderValue = 'male';
  List<S2Choice<String>> GenderOptions = [
    S2Choice<String>(value: 'male', title: 'পুরুষ'),
    S2Choice<String>(value: 'female', title: 'মহিলা'),
    S2Choice<String>(value: 'no_interest', title: 'কোন পছন্দ নেই'),
  ];
  LocalStorage localStorage = LocalStorage("amal_tracker");
  TextEditingController NameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              "আপনার নাম ও লিঙ্গ নির্বাচন করুন",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: AppGlobal.PrimaryColor,
            //action button
            actions: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(2, 0, 10, 0),
                child: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    Navigator.pushNamed(context, '/borjoniyo');
                  },
                ),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Card(
                    elevation: 9.1,
                    shadowColor: AppGlobal.PrimaryColor.withOpacity(0.85),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      // a list of what to do in the morning full design
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),

                        //textinput for name
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          margin: EdgeInsets.only(bottom: 5),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6)),
                          ),
                          child: TextField(
                            controller: NameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'আপনার নাম',
                            ),
                            onChanged: (text) {
                              localStorage.setItem("name", text);
                              localStorage.setItem('notification', true);
                            },
                          ),
                        ),

                        SmartSelect<String>.single(
                            modalType: S2ModalType.popupDialog,
                            modalHeaderStyle: S2ModalHeaderStyle(
                              backgroundColor: AppGlobal.PrimaryColor,
                              brightness: Brightness.dark,
                              centerTitle: true,
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            modalStyle: S2ModalStyle(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            title: "নির্বাচন করুন",
                            choiceLayout: S2ChoiceLayout.grid,
                            choiceType: S2ChoiceType.chips,
                            choiceStyle: S2ChoiceStyle(
                              showCheckmark: false,
                              // clipBehavior: Clip.antiAlias,
                            ),
                            // value: value,
                            choiceItems: GenderOptions,
                            selectedValue: GenderValue,
                            onChange: (state) => setState(() => {
                                  GenderValue = state.value,
                                  localStorage.setItem("gender", state.value),
                                })),
                        // for (var i = 0; i < koroniyo_list.length; i++) ...[
                        //   Card(
                        //     elevation: 3.5,
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(6),
                        //     ),
                        //     child: ListTile(
                        //       leading: Icon(Icons.wb_sunny),
                        //       title: Text(koroniyo_list[i]),
                        //       // subtitle: Text("সকালের কাজ করুন"),
                        //     ),
                        //   ),
                        // ],
                        // elevated button for next page
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 80,
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              margin: EdgeInsets.only(bottom: 10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppGlobal.PrimaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  primary: AppGlobal.PrimaryColor,
                                ),
                                onPressed: () async {
                                  await localStorage.setItem(
                                      "name", NameController.text);
                                  await localStorage.setItem(
                                      "gender", GenderValue);
                                  await Get.to(
                                    Dashboard(
                                      isHistory: false,
                                    ),
                                    transition: Transition.zoom,
                                    duration: Duration(milliseconds: 900),
                                  );
                                  // Navigator.pushNamed(context, '/dashboard');
                                },
                                child: Text("পরবর্তী পৃষ্ঠা দেখুন"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
