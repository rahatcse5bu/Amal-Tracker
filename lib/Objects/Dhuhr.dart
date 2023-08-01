class DhuhrObj {
  String DhuhrTableName = 'Dhuhr';
  String columnId = 'id';
  String columnDate = 'Date';
  String column_Azan_Reply = 'Azan_Reply';
  String column_2_Tahiyatul_Mosjid = 'Two_Tahiyatul_Mosjid';
  String column_4_Sunnah_Rakat = 'Four_Sunnah_Rakat';
  String column_4_Fard = 'Four_Fard';
  String column_Ayatul_Kursi = 'Ayatul_Kursi';
  String column_33_Tasbih = 'Thirty_Three_Tasbih';
  String column_10_Tasbih = 'Ten_Tasbih';
  String column_2_Sunnah_Rakat = 'Two_Sunnah_Rakat';
  String column_2_Nafil = 'Two_Nafil';
}

DhuhrObj dhuhr = DhuhrObj();

List<Map<String, dynamic>> Dhuhr_Items = [
  {
    'id': dhuhr.column_Azan_Reply,
    'title': "যোহরের আজানের জবাব",
    'subTitle':
        "আবূ হুরায়রাহ্ (রাঃ) হতে বর্ণিত। তিনি বলেন, আমরা রসূলুল্লাহ (স)-এর সঙ্গে যাচ্ছিলাম, বিলাল দাঁড়িয়ে আযান দিতে লাগলেন। আযান শেষে বিলাল চুপ করলে রসূলুল্লাহ (স) বললেন, যে ব্যক্তি অন্তরের দৃঢ় প্রত্যয়ের সাথে এর মতো বলবে, সে অবশ্যই জান্নাতে প্রবেশ করবে। [নাসায়ী][ইবনে মাজাহ ৬৭৬]",
    'isChecked': false,
    'points': 50,
  },
  {
    'id': dhuhr.column_2_Tahiyatul_Mosjid,
    'title': "তাহিয়াতুল মাসজিদ ২ রাকা'আত নফল",
    'subTitle':
        "তোমাদের কেউ মসজিদে প্রবেশ করলে সে যেন বসার পূর্বে দু’রাকাত সলাত  আদায় করে নেয়।[বুখারী ইঃ ফাঃ ৪৩১]\nতোমাদের কেউ মসজিদে প্রবেশ করলে দু’রাকাত সলাত (তাহিয়্যাতুল-মাসজিদ) আদায় করার আগে বসবে না।[বুখারীঃ ইঃফাঃ ১০৯৪]",
    'isChecked': false,
    'points': 50,
  },
  {
    'id': dhuhr.column_4_Sunnah_Rakat,
    'title': "যোহরের ৪ রাকা'আত সুন্নত",
    'subTitle':
        "প্রাত্যহিক সুন্নত নামাজের অংশ। বিশেষ ওজর বা রুখসত ছাড়া এই নামাজ ত্যাগ করা উচিত নয়। ",
    'isChecked': false,
    'points': 50,
  },
  {
    'id': dhuhr.column_4_Fard,
    'title': "যোহরের ৪ রাকা'আত ফরজ",
    'subTitle':
        "প্রতি ৫ ওয়াক্তে ১৭ রাকা'আত ফরজ নামাজের অংশ। বাধ্যতামূলক পড়তেই হবে,না পড়লে গুনাহ হবে।",
    'isChecked': false,
    'points': 150,
  },
  {
    'id': dhuhr.column_Ayatul_Kursi,
    'title': "যোহরের পর আয়াতুল কুরসি",
    'subTitle':
        "‘যে ব্যক্তি প্রত্যেক ফরজ নামাজের পর আয়াতুল কুরসী পড়বে তার জান্নাতে প্রবেশের মধ্যে কেবল মৃত্যুই একমাত্র বাঁধা।’ [সুনানে নাসায়ী: ৯৯২৮]",
    'isChecked': false,
    'points': 50,
  },
  {
    'id': dhuhr.column_33_Tasbih,
    'title':
        "যোহরের পর ৩৩ বার সুবহানআল্লহ,৩৩ বার আলহামদুলিল্লাহ এবং ৩৩ বার আল্লহু আকবার",
    'subTitle':
        "আবূ হুরায়রা (রা) থেকে বর্ণিত:গরীব সাহাবীগণ বললেনঃ হে আল্লাহ্‌র রসূল (স)! ধনী লোকেরা তো উচ্চমর্যাদা ও চিরস্থায়ী নি'য়ামত নিয়ে আমাদের থেকে এগিয়ে গেলেন। তিনি জিজ্ঞেস করলেনঃ তা কেমন করে? তাঁরা বললেনঃ আমরা যে রকম সলাত আদায় করি, তাঁরাও সে রকম সলাত আদায় করেন। আমরা যেমন জিহাদ করি, তাঁরাও তেমন জিহাদ করেন এবং তাঁরাও তাদের অতিরিক্ত মাল দিয়ে সদাকাহ-খয়রাত করেন; কিন্তু আমাদের কাছে সম্পদ নেই। তিনি বললেনঃ আমি কি তোমাদের একটি 'আমাল বাতলে দেব না, যে 'আমাল দ্বারা তোমরা তোমাদের পূর্ববর্তীদের মর্যাদা লাভ করতে পারবে, আর তোমাদের পরবর্তীদের চেয়ে এগিয়ে যেতে পারবে, আর তোমাদের মত 'আমাল কেউ করতে পারবে না, কেবলমাত্র যারা তোমাদের মত 'আমাল করবে তারা ব্যতীত। সে 'আমাল হলো তোমরা প্রত্যেক সালাতের পর ১০ বার 'সুবহানাল্লাহ', ১০ বার 'আলহামদু লিল্লাহ' এবং ১০ বার 'আল্লাহু আকবার' পাঠ করবে।[সহিহ বুখারী- ৬৩২৯]",
    'isChecked': false,
    'points': 50,
  },
  {
    'id': dhuhr.column_10_Tasbih,
    'title':
        "যোহরের পর ১০ বার সুবহানআল্লহ, ১০ বার আলহামদুলিল্লাহ এবং ১০ বার আল্লহু আকবার",
    'subTitle':
        "যে ব্যক্তি প্রত্যেক ফরয সালাতের পর সুবহানাল্লাহ ৩৩ বার, আলহামদুলিল্লাহ ৩৩ বার, আল্লাহু আকবার ৩৩ বার পাঠ করার পর এই দোয়া (لَا إِلَهَ إِلاَّ اللَّهُ وَحْدَهُ لَا شَرِيْكَ لَهُ لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَىْءٍ قَدِيْرٌ) ১বার পাঠ করে মোট ১০০ বার পূর্ণ করবে তার সমস্ত গুনাহ(ছগীরা) মাফ হয়ে যাবে; যদিও তা সুমুদ্রের ফেনা পরিমাণ হয়।[সহিহ মুসলিম: ১৩৮০]",
    'isChecked': false,
    'points': 50,
  },
  {
    'id': dhuhr.column_2_Sunnah_Rakat,
    'title': "যোহরের ২ রাকা'আত সুন্নত",
    'subTitle':
        "প্রাত্যহিক সুন্নত নামাজের অংশ। বিশেষ ওজর বা রুখসত ছাড়া এই নামাজ ত্যাগ করা উচিত নয়। ",
    'isChecked': false,
    'points': 50,
  },
  {
    'id': dhuhr.column_2_Nafil,
    'title': "যোহরের পর ২ রাকা'আত নফল",
    'subTitle':
        "যোহরে সর্বমোট ১২ রাকা'আত পড়ার বিশেষ ফজিলত আছে।\n“যে ব্যক্তি যোহরের পূর্বে ৪ রাকা'আত এবং পরে ৪ রাকা'আত (সুন্নত নামাযের) প্রতি সবিশেষ যত্নবান হবে, আল্লাহ তাকে জাহান্নামের জন্য হারাম করে দেবেন।” [মিশকাত ১১৬৭, সহিহ তারগিব ৫৮১]",
    'isChecked': false,
    'points': 50,
  },
];
