import 'package:daily_amal_tracker/getGender.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

import 'dashboard.dart';
import 'global.dart';
import 'package:localstorage/localstorage.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  List<ContentConfig> listContentConfig = [];
  Color activeColor = const Color(0xff0BEEF9);
  Color inactiveColor = const Color(0xff03838b);
  double sizeIndicator = 20;
  LocalStorage localStorage = LocalStorage("amal_tracker");

  @override
  void initState() {
    super.initState();
    localStorage.setItem('isIntroVisited', true);
    listContentConfig.add(
      ContentConfig(
        backgroundColor: AppGlobal.PrimaryColor,
        title: "'আমাল ট্রাকার",
        maxLineTitle: 2,
        styleTitle: const TextStyle(
          color: Color(0xffFFDAB9),
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Alinur Tumatul',
        ),
        description:
            "এখানে আপনি আপনার প্রাত্যহিক 'আমালগুলো ইনপুট দিতে পারবেন এবং তা পরবর্তীতে ট্রাক করতে পারবেন। 'আমাল ট্রাকারে রয়েছে পয়েন্ট সিস্টেম এবং নোটিফিকেশন সিস্টেম। আপনি কোনো কারণে 'আমাল করতে ভুলে গেলে কিংবা ইনপুট দিতে ভুলে গেলে নোটিফিকেশন দিয়ে আপনাকে ইনফর্ম করা হবে।",
        styleDescription: const TextStyle(
          color: Color(0xffFFDAB9),
          fontSize: 15.0,
          // fontStyle: FontStyle.italic,
          fontFamily: 'Alinur Tumatul',
        ),
        marginDescription: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 20.0,
          bottom: 70.0,
        ),
        centerWidget: Divider(
          color: Color(0xffFFDAB9),
          height: 3,
          thickness: 2,
          indent: 30,
          endIndent: 30,
        ),
        // const Text(
        //   "Replace this with a custom widget",
        //   style: TextStyle(color: Colors.white),
        // ),
        // backgroundNetworkImage: "https://rahatcse5bu.com/files/Islamic.png",
        // backgroundFilterOpacity: 0.5,
        backgroundFilterColor: AppGlobal.PrimaryColor,
        // backgroundImageFit: BoxFit.fitHeight,

        onCenterItemPress: () {},
      ),
    );

    listContentConfig.add(
      const ContentConfig(
        title: "পয়েন্ট সিস্টেম",
        styleTitle: TextStyle(
          color: Color(0xffFFDAB9),
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Alinur Tumatul',
        ),
        description:
            "এখানে প্রতিটা টাস্ক কম্প্লিশনের উপর প্রি-ডিফাইন্ড একটি পয়েন্ট দেওয়া হয়। ইসলামিক ফরজ,সুন্নত, নফল কিংবা ফাজায়েলে এসকল 'আমালের প্রতিদান/রিওয়ার্ড আল্লাহ সুবহানাহু ওয়া তা'আলা নিজে উত্তম জাযা দিবেন ইনশাআল্লহ। সেই জাযা দুনিয়াবি ভার্চুয়াল এই পয়েন্ট দিয়ে জাজ করা কিংবা কম্পেয়ার করার কোনো সুযোগ নেই।মূলত, ইউজারকে উদ্বুদ্ধ করতে পয়েন্ট সিস্টেমটি ইমপ্লিমেন্ট করা হয়েছে। এখানে উল্লেখ করা পয়েন্ট বেশি থাকা মানে সেই 'আমালটির ফজিলত বেশি, বিষয়টি মোটেও এমন নয়। বরং ফাজায়েল নির্ধারিত হবে ক্বুরআন ও সুন্নাহ দ্বারা।",
        styleDescription: TextStyle(
          color: Color(0xffFFDAB9),
          fontSize: 15.0,
          // fontStyle: FontStyle.italic,
          fontFamily: 'Alinur Tumatul',
        ),
        centerWidget: Divider(
          color: Color(0xffFFDAB9),
          height: 3,
          thickness: 2,
          indent: 30,
          endIndent: 30,
        ),
        // backgroundImage: "https://rahatcse5bu.com/files/mosque.jpg",
        // backgroundImageFit: BoxFit.contain,
        // maxLineTextDescription: 3,
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "নোটিফিকেশন সিস্টেম",
        styleTitle: TextStyle(
          color: Color(0xffFFDAB9),
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Alinur Tumatul',
        ),
        description:
            "অ্যাপটিতে মিসিং 'আমালগুলো এবং আপকামিং 'আমালগুলোর উপর ভিত্তি করে  নোটিফিকেশন দেওয়া হবে ইনশাআল্লহ।আপনার বিগত ১ সপ্তাহের প্রতিটা 'আমাল অ্যানালাইসিস করে প্রাপ্ত তথ্যের ভিত্তিতে আপনাকে নোটিফিকেশন দিয়ে রিমাইন্ডার দেওয়া হবে ইনশাআল্লহ। ইথিকাল ইউজার এক্সপেরিয়েন্স বিবেচনায়  নোটিফিকেশন সিস্টেম সেটিংস থেকে অফ করেও রাখার সুযোগ থাকছে",
        styleDescription: TextStyle(
          color: Color(0xffFFDAB9),
          fontSize: 15.0,
          // fontStyle: FontStyle.italic,
          fontFamily: 'Alinur Tumatul',
        ),
        centerWidget: Divider(
          color: Color(0xffFFDAB9),
          height: 3,
          thickness: 2,
          indent: 30,
          endIndent: 30,
        ),
        // maxLineTextDescription: 5,
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "হিস্টোরি ও ওভারভিউ",
        styleTitle: TextStyle(
          color: Color(0xffFFDAB9),
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Alinur Tumatul',
        ),
        description:
            "হিস্টোরি সেকশনে আপনার লাইফটাইম সকল এক্টিভিটি সেইভ থাকবে ইনশাআল্লহ।তারিখ দিয়ে হিস্টোরি ফিল্টার করার সুযোগও রাখা হয়েছে।থাকছে ওভারভিউ সেকশনে সেকশন-ভিত্তিক গ্রাফিকাল রিপ্রেজেন্টেশন। অ্যাপের/ফোনের স্টোরেজ বিবেচনায় চাইলে হিস্টোরিগুলো ডিলেট করে দেওয়া যাবে।",
        styleDescription: TextStyle(
          color: Color(0xffFFDAB9),
          fontSize: 15.0,
          // fontStyle: FontStyle.italic,
          fontFamily: 'Alinur Tumatul',
        ),
        centerWidget: Divider(
          color: Color(0xffFFDAB9),
          height: 3,
          thickness: 2,
          indent: 30,
          endIndent: 30,
        ),
        // maxLineTextDescription: 3,
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "আল ক্বুরআন",
        styleTitle: TextStyle(
          color: Color(0xffFFDAB9),
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Alinur Tumatul',
        ),
        description:
            "থার্ড পার্টি একটি প্যাকেজের সহায়তায় আল ক্বুরআনও সংযুক্ত করা হয়েছে।শুধুমাত্র অ্যারাবিক ভার্সনই আপাতত।",
        styleDescription: TextStyle(
          color: Color(0xffFFDAB9),
          fontSize: 15.0,
          // fontStyle: FontStyle.italic,
          fontFamily: 'Alinur Tumatul',
        ),
        centerWidget: Divider(
          color: Color(0xffFFDAB9),
          height: 3,
          thickness: 2,
          indent: 30,
          endIndent: 30,
        ),
        // maxLineTextDescription: 3,
      ),
    );
  }

  void onDonePress() {
    localStorage.setItem('isIntroVisited', true);
    print("onDonePress caught");
    //navigate to Dashboard() page after done
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => Dashboard(isHistory: false),
    //   ),
    // );
    if (localStorage.getItem('name') == null &&
        localStorage.getItem('gender') == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => GetGender(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(isHistory: false),
        ),
      );
    }
  }

  void onNextPress() {
    print("onNextPress caught");
  }

  Widget renderNextBtn() {
    return const Icon(
      Icons.navigate_next,
      size: 25,
    );
  }

  Widget renderDoneBtn() {
    return const Icon(
      Icons.done,
      size: 25,
    );
  }

  Widget renderSkipBtn() {
    return const Icon(
      Icons.skip_next,
      size: 25,
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
      foregroundColor: MaterialStateProperty.all<Color>(activeColor),
      backgroundColor: MaterialStateProperty.all<Color>(inactiveColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      key: UniqueKey(),
      // Content config
      listContentConfig: listContentConfig,
      backgroundColorAllTabs: AppGlobal.PrimaryColor,

      // Skip button
      renderSkipBtn: renderSkipBtn(),
      skipButtonStyle: myButtonStyle(),

      // Next button
      renderNextBtn: renderNextBtn(),
      onNextPress: onNextPress,
      nextButtonStyle: myButtonStyle(),

      // Done button
      renderDoneBtn: renderDoneBtn(),
      onDonePress: onDonePress,
      doneButtonStyle: myButtonStyle(),

      // Indicator
      indicatorConfig: IndicatorConfig(
        sizeIndicator: sizeIndicator,
        indicatorWidget: Container(
          width: sizeIndicator,
          height: 10,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4), color: inactiveColor),
        ),
        activeIndicatorWidget: Container(
          width: sizeIndicator,
          height: 10,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4), color: activeColor),
        ),
        spaceBetweenIndicator: 10,
        typeIndicatorAnimation: TypeIndicatorAnimation.sliding,
      ),

      // Navigation bar
      navigationBarConfig: NavigationBarConfig(
        navPosition: NavPosition.bottom,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).viewPadding.top > 0 ? 20 : 10,
          bottom: MediaQuery.of(context).viewPadding.bottom > 0 ? 20 : 10,
        ),
        backgroundColor: Colors.black.withOpacity(0.5),
      ),

      // Scroll behavior
      isAutoScroll: true,
      isLoopAutoScroll: false, autoScrollInterval: Duration(seconds: 5),
      curveScroll: Curves.bounceIn,
    );
  }
}
