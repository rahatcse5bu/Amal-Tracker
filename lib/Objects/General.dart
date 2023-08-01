class GeneralObj {
  String GeneralTableName = 'General';
  String columnId = 'id';
  String columnDate = 'Date';
  String column_non_Mahram_Kotha = 'non_Mahram_Kotha';
  String column_non_Mahram_Dristi = 'non_Mahram_Dristi';
  String column_unnecessary_Tasks = 'unnecessary_Tasks';
  String column_hundred_Istigfar = 'hundred_Istigfar';
  String column_moja_Kore_Mittha = 'moja_Kore_Mittha';
  String column_salat_Khushukhuju = 'salat_Khushukhuju';
  String column_five_TK_Swadhaka = 'five_TK_Swadhaka';
  String column_oshlilota_Porihar = 'oshlilota_Porihar';
  String column_gheebat_Porihar = 'gheebat_Porihar';
  String column_sura_Ikhlas = 'sura_Ikhlas';
}

GeneralObj general = new GeneralObj();

List<Map<String, dynamic>> General_Items = [
  {
    'id': general.column_non_Mahram_Kotha,
    'title': "নন মাহরামের সাথে কথা না বলা",
    'subTitle': "",
    'isChecked': false,
    'points': 150,
  },
  {
    'id': general.column_non_Mahram_Dristi,
    'title': "নন মাহরাম থেকে দৃষ্টি হিফাজত করা",
    'subTitle': "",
    'isChecked': false,
    'points': 150,
  },
  {
    'id': general.column_unnecessary_Tasks,
    'title': "অপ্রয়োজনীয় কথা/কাজ পরিহার করা",
    'subTitle': "",
    'isChecked': false,
    'points': 50,
  },
  {
    'id': general.column_hundred_Istigfar,
    'title': "কমপক্ষে ১০০ বার ইস্তিগফার করা",
    'subTitle': " ",
    'isChecked': false,
    'points': 50,
  },
  {
    'id': general.column_moja_Kore_Mittha,
    'title': "মজা করেও মিথ্যা কথা না বলা",
    'subTitle': "",
    'isChecked': false,
    'points': 100,
  },
  {
    'id': general.column_salat_Khushukhuju,
    'title': "স্বলাত খুশুখুজুর সাথে আদায় করা",
    'subTitle': "",
    'isChecked': false,
    'points': 100,
  },
  {
    'id': general.column_five_TK_Swadhaka,
    'title': "কমপক্ষে ৫ টাকা দান/স্বদাক্বা করা",
    'subTitle': "",
    'isChecked': false,
    'points': 50,
  },
  {
    'id': general.column_oshlilota_Porihar,
    'title': "অশ্লীলতা পরিহার করা,  অশ্লীল বাক্য উচ্চারণ না করা",
    'subTitle': "",
    'isChecked': false,
    'points': 50,
  },
  {
    'id': general.column_gheebat_Porihar,
    'title': "গীবত থেকে বিরত থাকা",
    'subTitle': "",
    'isChecked': false,
    'points': 100
  },
  {
    'id': general.column_sura_Ikhlas,
    'title': "সূরা ইখলাস ১০ বার",
    'subTitle':
        "“যে ব্যক্তি ১০ বার সূরা ইখলাস পাঠ করবে, আল্লাহ তাঁর জন্য জান্নাতে একটি বাড়ি বানিয়ে রাখবেন।”[সহীহুল জামিয়িস সাগীর ৬৪৭২]",
    'isChecked': false,
    'points': 100,
  },
];
