class FajrObj {
  String fajrTableName = 'Fajr';
  String columnId = 'id';
  String columnDate = 'Date';
  String columnName_Tahajjud = 'Tahajjud';
  String column_Azan_Reply = 'Azan_Reply';
  String column_Tahiyatul_Masjid = 'Tahiyatul_Masjid';
  String column_2_Sunnah_Rakat = 'Two_Sunnah_Rakat';
  String column_2_Fard_Rakat = 'Two_Fard_Rakat';
  String column_Ayatul_Kursi = 'Ayatul_Kursi';
  String column_33_Tasbih = 'Thirty_Three_Tasbih';
  String column_10_Tasbih = 'Ten_Tasbih';
  String column_3_Surah = 'Three_Surah';
  String column_100_Subhanallah_Wa_Bihamdihi =
      'Hundred_Subhanallah_Wa_Bihamdihi';
}

FajrObj fajr = FajrObj();

List<Map<String, dynamic>> Fajr_Items = [
  {
    'id': fajr.columnName_Tahajjud,
    'title': "Tahajjud",
    'subTitle':
        "আবূ হুরায়রাহ্ (রাঃ) হতে বর্ণিত। তিনি বলেন, আমরা রসূলুল্লাহ (স)-এর সঙ্গে যাচ্ছিলাম, বিলাল দাঁড়িয়ে আযান দিতে লাগলেন। আযান শেষে বিলাল চুপ করলে রসূলুল্লাহ (স) বললেন, যে ব্যক্তি অন্তরের দৃঢ় প্রত্যয়ের সাথে এর মতো বলবে, সে অবশ্যই জান্নাতে প্রবেশ করবে। [নাসায়ী][ইবনে মাজাহ ৬৭৬]",
    'isChecked': false,
    'points': 500,
  },
  {
    'id': fajr.column_Azan_Reply,
    'title': "ফজরের আজানের জবাব",
    'subTitle':
        "আবূ হুরায়রাহ্ (রাঃ) হতে বর্ণিত। তিনি বলেন, আমরা রসূলুল্লাহ (স)-এর সঙ্গে যাচ্ছিলাম, বিলাল দাঁড়িয়ে আযান দিতে লাগলেন। আযান শেষে বিলাল চুপ করলে রসূলুল্লাহ (স) বললেন, যে ব্যক্তি অন্তরের দৃঢ় প্রত্যয়ের সাথে এর মতো বলবে, সে অবশ্যই জান্নাতে প্রবেশ করবে। [নাসায়ী][ইবনে মাজাহ ৬৭৬]",
    'isChecked': false,
    'points': 40,
  },
  {
    'id': fajr.column_Tahiyatul_Masjid,
    'title': 'তাহিয়্যাতুল মাসজিদ',
    'subTitle':
        "তোমাদের কেউ মসজিদে প্রবেশ করলে সে যেন বসার পূর্বে দু’রাকাত সলাত  আদায় করে নেয়।[বুখারী ইঃ ফাঃ ৪৩১]\nতোমাদের কেউ মসজিদে প্রবেশ করলে দু’রাকাত সলাত (তাহিয়্যাতুল-মাসজিদ) আদায় করার আগে বসবে না।[বুখারীঃ ইঃফাঃ ১০৯৪]",
    'isChecked': false,
    'points': 50,
  },
  {
    'id': fajr.column_2_Sunnah_Rakat,
    'title': "ফজরের ২ রাকা'আত সুন্নত",
    'subTitle':
        "“ফজরের দুই রাকআত (সুন্নত) পৃথিবী ও তন্মধ্যস্থিত সকল বস্তু অপেক্ষা উত্তম।”[মুসলিম ৭২৫]",
    'isChecked': false,
    'points': 90,
  },
  {
    'id': fajr.column_2_Fard_Rakat,
    'title': "ফজরের ২ রাকা'আত ফরজ",
    'subTitle':
        "“যে ব্যক্তি ফজরের নামাজ আদায় করবে সে আল্লাহর জিম্মায় থাকবে।” [মুসলিম:৬৫৭]\n “ফজরের সালাত হলো মুমিন ও মুনাফিকদের মধ্যে পার্থক্যকারী , কারন রসুল (সা) বলেছেন মুনাফিকদের জন্য ফজরের সালাত আদায় করা কষ্টকর!” [সহীহ বুখারী:৬৫৭,৬৪৪,২৪২০,৭২২৪,মুসলিম:৬৬১]\n “যে ব্যক্তি নিয়মিত ফজরের নামাজ আদায় করে সে কখনোই জাহান্নামে প্রবেশ করবে না”[মুসলিম-৬৩৪]",
    'isChecked': false,
    'points': 160,
  },
  {
    'id': fajr.column_Ayatul_Kursi,
    'title': "ফজরের পর আয়াতুল কুরসি",
    'subTitle':
        "‘যে ব্যক্তি প্রত্যেক ফরজ নামাজের পর আয়াতুল কুরসী পড়বে তার জান্নাতে প্রবেশের মধ্যে কেবল মৃত্যুই একমাত্র বাঁধা।’ [সুনানে নাসায়ী: ৯৯২৮]",
    'isChecked': false,
    'points': 50,
  },
  {
    'id': fajr.column_33_Tasbih,
    'title':
        "ফজরের পর ৩৩ বার সুবহানআল্লহ,৩৩ বার আলহামদুলিল্লাহ এবং ৩৩ বার আল্লহু আকবার",
    'subTitle':
        "আবূ হুরায়রা (রা) থেকে বর্ণিত:গরীব সাহাবীগণ বললেনঃ হে আল্লাহ্‌র রসূল (স)! ধনী লোকেরা তো উচ্চমর্যাদা ও চিরস্থায়ী নি'য়ামত নিয়ে আমাদের থেকে এগিয়ে গেলেন। তিনি জিজ্ঞেস করলেনঃ তা কেমন করে? তাঁরা বললেনঃ আমরা যে রকম সলাত আদায় করি, তাঁরাও সে রকম সলাত আদায় করেন। আমরা যেমন জিহাদ করি, তাঁরাও তেমন জিহাদ করেন এবং তাঁরাও তাদের অতিরিক্ত মাল দিয়ে সদাকাহ-খয়রাত করেন; কিন্তু আমাদের কাছে সম্পদ নেই। তিনি বললেনঃ আমি কি তোমাদের একটি 'আমাল বাতলে দেব না, যে 'আমাল দ্বারা তোমরা তোমাদের পূর্ববর্তীদের মর্যাদা লাভ করতে পারবে, আর তোমাদের পরবর্তীদের চেয়ে এগিয়ে যেতে পারবে, আর তোমাদের মত 'আমাল কেউ করতে পারবে না, কেবলমাত্র যারা তোমাদের মত 'আমাল করবে তারা ব্যতীত। সে 'আমাল হলো তোমরা প্রত্যেক সালাতের পর ১০ বার 'সুবহানাল্লাহ', ১০ বার 'আলহামদু লিল্লাহ' এবং ১০ বার 'আল্লাহু আকবার' পাঠ করবে।[সহিহ বুখারী- ৬৩২৯]",
    'isChecked': false,
    'points': 50,
  },
  {
    'id': fajr.column_10_Tasbih,
    'title':
        "ফজরের পর ১০ বার সুবহানআল্লহ, ১০ বার আলহামদুলিল্লাহ এবং ১০ বার আল্লহু আকবার",
    'subTitle':
        "যে ব্যক্তি প্রত্যেক ফরয সালাতের পর সুবহানাল্লাহ ৩৩ বার, আলহামদুলিল্লাহ ৩৩ বার, আল্লাহু আকবার ৩৩ বার পাঠ করার পর এই দোয়া (لَا إِلَهَ إِلاَّ اللَّهُ وَحْدَهُ لَا شَرِيْكَ لَهُ لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَىْءٍ قَدِيْرٌ) ১বার পাঠ করে মোট ১০০ বার পূর্ণ করবে তার সমস্ত গুনাহ(ছগীরা) মাফ হয়ে যাবে; যদিও তা সুমুদ্রের ফেনা পরিমাণ হয়।[সহিহ মুসলিম: ১৩৮০]",
    'isChecked': false,
    'points': 70,
  },
  {
    'id': fajr.column_3_Surah,
    'title': "সূরা ইখলাস, সূরা ফালাক ও সূরা নাস ১ বার",
    'subTitle':
        "উকবা ইবনু আমির (রাঃ) বলেন, রাসূলুল্লাহ (স.) আমাকে নির্দেশ দিয়েছেন, প্রত্যেক সালাতের পরে সূরা ফালাক ও সূরা নাস পাঠ করতে। দ্বিতীয় বর্ণনায় তিনি বলেন, রাসূলুল্লাহ (স.) আমাকে প্রত্যেক সালাতের পরে মুআওয়িযাত, (সূরা ইখলাস, সূরা ফালাক ও সূরা নাস) পাঠ করতে নির্দেশ দিয়েছেন[সুনানু আবী দাউদ ১৫২৩, সুনানুত তিরমিযী ২৯০৩]",
    'isChecked': false,
    'points': 50,
  },
  {
    'id': fajr.column_100_Subhanallah_Wa_Bihamdihi,
    'title': "একশত বার ‘সুবহানাল্লহি ওয়া বি হামদিহী’ পাঠ করা",
    'subTitle':
        "আবু হুরাইরাহ (রদ্বি) থেকে বর্ণিত, নবী (স) বলেছেনঃ যে ব্যক্তি সকালে ও বিকালে একশত বার বলেঃ সুবাহানাল্লহি ওয়া বিহামদিহী”, কিয়ামতের দিন তার চাইলে উত্তম (আমালকারী) আর কেউ হবে না। তবে যে লোক তার ন্যায় কিংবা তার চাইতে অধিক পরিমান তা বলে (সে উত্তম ‘আমালকারী বলে গণ্য হবে)।”[তাহ’লীকুর রাগিব (হাঃ ১/২২৬), মুসলিম। জামে’ আত তিরমিজি ৩৪৬৯]",
    'isChecked': false,
    'points': 180,
  },
];
