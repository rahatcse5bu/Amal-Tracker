import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localstorage/localstorage.dart';

import 'global.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LocalStorage localStorage = LocalStorage("amal_tracker");

  int generateRandomSeconds() {
    Random random = Random();

    // Generate a random number between 1 and 60 (inclusive)
    int seconds = random.nextInt(6) + 4;
    return seconds;

    // print('Random Seconds: $seconds');
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: generateRandomSeconds()), () {
      // Navigator.pushReplacementNamed(context, '/dashboard');
      // Navigator.pushReplacementNamed(context, '/getGender');
      print('isIntroVisited: ${localStorage.getItem('isIntroVisited')}');
      if (localStorage.getItem('isIntroVisited') == false ||
          localStorage.getItem('isIntroVisited') == null) {
        print("Intro");
//go to intro
        Navigator.pushReplacementNamed(context, '/intro');
      } else {
        //intro already visited by the user
        //don't go to intro
        //chcek if the name & gender input exists or not
        if (localStorage.getItem('name') == null &&
            localStorage.getItem("gender") == null) {
          //go to getGender
          Navigator.pushReplacementNamed(context, '/getGender');
        } else {
          //name and gender already exists in the localstorage
          //go to dashboard
          Navigator.pushReplacementNamed(context, '/dashboard');
        }
      }
    });
    print('isIntroVisited 2: ${localStorage.getItem('isIntroVisited')}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //hide appbar

      body: Container(
        // color: Color(0xff1A237E),
        color: AppGlobal.PrimaryColor,
        // full width and height
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //AssetImage
              Image.asset(
                'images/Amal_Tracker_Logo.png',
                // width: double.infinity,
                height: 80,
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              // Text(
              //   'Dept. of CSE, BU',
              //   style: TextStyle(fontSize: 20, color: Colors.white),
              // ),
              SizedBox(
                height: 25,
              ),
              //circular progress indicator
              CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
              SizedBox(
                height: 20,
              ),
              Text("Developed By: ",
                  style: GoogleFonts.nanumMyeongjo(
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      // fontFamily: 'Cursive',
                    ),
                  )),
              SizedBox(
                height: 5,
              ),
              Text("Md. Rahat",
                  style: GoogleFonts.nanumMyeongjo(
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      // fontFamily: 'Cursive',
                    ),
                  )),
              SizedBox(
                height: 5,
              ),
              Text("CSE 5th Batch",
                  style: GoogleFonts.nanumMyeongjo(
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      // fontFamily: 'Cursive',
                    ),
                  )),
              SizedBox(
                height: 5,
              ),
              Text("University of Barisal",
                  style: GoogleFonts.nanumMyeongjo(
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      // fontFamily: 'Cursive',
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
