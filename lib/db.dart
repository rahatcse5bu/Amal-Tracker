import 'dart:async';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'Data/data.dart';
import 'Objects/Asr.dart';
import 'Objects/Dhuhr.dart';
import 'Objects/Fajr.dart';
import 'Objects/Fazayel.dart';
import 'Objects/General.dart';
import 'Objects/Isha.dart';
import 'Objects/Maghrib.dart';
import 'Overview.dart';
import 'widgets/Fajr.dart';
import 'AppMain.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _database;

  DatabaseHelper._instance();
  Database? myDatabase;
  DhuhrObj dhuhr = DhuhrObj();

  FajrObj fajr = FajrObj();
  GeneralObj general = GeneralObj();
  AsrObj asr = AsrObj();
  MaghribObj maghrib = MaghribObj();
  IshaObj isha = IshaObj();
  FazayelObj fazayel = FazayelObj();

  // Format the date as "yyyy-MM-dd"
  String formattedStringDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  // String formattedStringDate =
  //     '${DateTime.now().day.toString().padLeft(2, '0')} ${DateFormat.MMM().format(DateTime.now())} ${DateTime.now().year}';

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(appDirectory.path, 'mmdy55gall_tracker_18521.db');

    // final dbPath =
    //     path.join(path.dirname(Platform.script.toFilePath()), 'data/drift.db');

    final database =
        await openDatabase(dbPath, version: 1, onCreate: _createDb);
    myDatabase = database;
    return database;
  }

  void _createDb(Database db, int version) async {
    // await db.execute(
    //     'CREATE TABLE $tableName ($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName TEXT, $columnRoll TEXT, $columnCGPA REAL, $columnZilla TEXT)');
    String createFajrTableQuery =
        "CREATE TABLE IF NOT EXISTS ${fajr.fajrTableName} (${fajr.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,${fajr.columnDate} TEXT UNIQUE,${fajr.columnName_Tahajjud} INTEGER,${fajr.column_Azan_Reply} INTEGER,${fajr.column_Tahiyatul_Masjid} INTEGER,${fajr.column_2_Sunnah_Rakat} INTEGER,${fajr.column_2_Fard_Rakat} INTEGER,${fajr.column_Ayatul_Kursi} INTEGER,${fajr.column_33_Tasbih} INTEGER,${fajr.column_10_Tasbih} INTEGER,${fajr.column_3_Surah} INTEGER,${fajr.column_100_Subhanallah_Wa_Bihamdihi} INTEGER);";
    String createDhuhrTableQuery =
        "CREATE TABLE IF NOT EXISTS ${dhuhr.DhuhrTableName} (${dhuhr.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,${dhuhr.columnDate} TEXT UNIQUE,${dhuhr.column_Azan_Reply} INTEGER,${dhuhr.column_2_Tahiyatul_Mosjid} INTEGER,${dhuhr.column_4_Sunnah_Rakat} INTEGER,${dhuhr.column_4_Fard} INTEGER,${dhuhr.column_Ayatul_Kursi} INTEGER,${dhuhr.column_33_Tasbih} INTEGER,${dhuhr.column_10_Tasbih} INTEGER,${dhuhr.column_2_Sunnah_Rakat} INTEGER , ${dhuhr.column_2_Nafil} INTEGER);";
    String createGeneralTableQuery =
        "CREATE TABLE IF NOT EXISTS ${general.GeneralTableName} ( ${general.columnId} INTEGER PRIMARY KEY AUTOINCREMENT, ${general.columnDate} TEXT UNIQUE,${general.column_non_Mahram_Kotha} INTEGER,${general.column_non_Mahram_Dristi} INTEGER,${general.column_unnecessary_Tasks} INTEGER,${general.column_hundred_Istigfar} INTEGER,${general.column_moja_Kore_Mittha} INTEGER,${general.column_salat_Khushukhuju} INTEGER,${general.column_five_TK_Swadhaka} INTEGER,${general.column_oshlilota_Porihar} INTEGER,${general.column_gheebat_Porihar} INTEGER,${general.column_sura_Ikhlas} INTEGER);";
    String createAsrTableQuery =
        "CREATE TABLE IF NOT EXISTS ${asr.AsrTableName} (${asr.columnId} INTEGER PRIMARY KEY AUTOINCREMENT, ${asr.columnDate} TEXT UNIQUE, ${asr.column_azan_Reply} INTEGER, ${asr.column_tahiyatul_Mosjid} INTEGER, ${asr.column_four_Rakaat_Fard} INTEGER, ${asr.column_ayatul_Kursi} INTEGER, ${asr.column_33_Tasbih} INTEGER, ${asr.column_10_Tasbih} INTEGER);";
    String createMaghribTableQuery =
        "CREATE TABLE IF NOT EXISTS ${maghrib.MaghribTableName} (${maghrib.columnId} INTEGER PRIMARY KEY AUTOINCREMENT, ${maghrib.columnDate} TEXT UNIQUE,${maghrib.column_Azan_Reply} INTEGER, ${maghrib.column_3_Ralat_Fard} INTEGER, ${maghrib.column_Ayatul_Kursi} INTEGER,${maghrib.column_33_Tasbih} INTEGER, ${maghrib.column_10_Tasbih} INTEGER, ${maghrib.column_3_Surah} INTEGER, ${maghrib.column_100_Subhanallah_Wa_Bihamdihi} INTEGER, ${maghrib.column_2_Rakat_Sunnah} INTEGER);";
    String createIshaTableQuery =
        "CREATE TABLE IF NOT EXISTS ${isha.IshaTableName} ( ${isha.columnId} INTEGER PRIMARY KEY AUTOINCREMENT, ${isha.columnDate} TEXT UNIQUE, ${isha.column_Azan_Reply} INTEGER, ${isha.column_Tahiyatul_Mosjid} INTEGER, ${isha.column_4_Rakat_Fard} INTEGER, ${isha.column_Ayatul_Kursi} INTEGER, ${isha.column_33_Tashbih} INTEGER, ${isha.column_10_Tashbih} INTEGER, ${isha.column_2_Rakat_Sunnah} INTEGER, ${isha.column_witr} INTEGER, ${isha.column_Subhanil_Malikil_Quddus} INTEGER);";
    String createFazayelTableQuery =
        "CREATE TABLE IF NOT EXISTS ${fazayel.FazayelTableName} ( ${fazayel.columnId} INTEGER PRIMARY KEY AUTOINCREMENT, ${fazayel.columnDate} TEXT UNIQUE,${fazayel.columnBishesDua} INTEGER,${fazayel.column4_Jon_Golam} INTEGER,${fazayel.column_10_Golam_100_Neki} INTEGER,${fazayel.column_Somudrer_Fena} INTEGER,${fazayel.column_Mizaner_Palla} INTEGER,${fazayel.column_1000_Neki} INTEGER,${fazayel.column_Jannater_Guptodhon} INTEGER,${fazayel.column_70_Onisto} INTEGER,${fazayel.column_Sorbosrestho_Dua} INTEGER,${fazayel.column_Sorbottom_Jikr} INTEGER,${fazayel.column_Chiroyesthayee_Nek_Amal} INTEGER,${fazayel.column_Quran_Ek_tritiyo} INTEGER, ${fazayel.column_Beshi_Beshi_Ikhlash} INTEGER,${fazayel.column_Suparish} INTEGER,${fazayel.column_Raat_E_Bakara} INTEGER,${fazayel.column_Ekti_Sorner_Prashadh} INTEGER,${fazayel.column_Jahannam_Mukti_Swarner_Gach} INTEGER,${fazayel.column_Jannate_Ekti_Khajur_Gach} INTEGER,${fazayel.column_Jannat_Lav_Jahannam_Mukti} INTEGER,${fazayel.column_Deen_Otol_Thaka} INTEGER,${fazayel.column_Islam_Otol_Thaka} INTEGER,${fazayel.column_Gunah_Maf_Chaowa} INTEGER,${fazayel.column_Rasul_Istigfar} INTEGER,${fazayel.column_Rasul_Istigfar_Mrittur_Agee} INTEGER,${fazayel.column_Darud_Pathh} INTEGER);";
    await db.execute(createFajrTableQuery);
    await db.execute(createDhuhrTableQuery);
    await db.execute(createGeneralTableQuery);
    await db.execute(createAsrTableQuery);
    await db.execute(createMaghribTableQuery);
    await db.execute(createIshaTableQuery);
    await db.execute(createFazayelTableQuery);

    // print("Rahat Query---> " + createDhuhrTableQuery.toString());
  }

  Future<List<Map<String, dynamic>>> getDataInRange(
      String table, DateTime startDate, DateTime endDate) async {
    // Database db = await DatabaseHelper;
    Database db = await instance.database;
    // DateFormat('yyyy-MM-dd').format(now); DB date format
    final start = DateFormat('yyyy-MM-dd').format(startDate);
    final end = DateFormat('yyyy-MM-dd').format(endDate);
    print("Start =====>" + start.toString());
    print('End =====>' + end.toString());
    final result = await db.query(
      table,
      where: 'Date BETWEEN ? AND ?',
      whereArgs: [start, end],
    );
    print('result=>' + result.toString());
    return result;
  }

  Future<List<PrayerData>> getDataInRangeForFilter(
      String table, DateTime startDate, DateTime endDate) async {
    List<String> myTableNames = [
      'Fajr',
      'Dhuhr',
      'General',
      'Asr',
      'Maghrib',
      'Isha',
      'Fazayel',
    ];
    Database db = await instance.database;
    final start = DateFormat('yyyy-MM-dd').format(startDate);
    final end = DateFormat('yyyy-MM-dd').format(endDate);

    final result = await db.query(
      table,
      where: 'Date BETWEEN ? AND ?',
      whereArgs: [start, end],
    );

    List<PrayerData> prayerDataList = result.map((row) {
      DateTime date = DateTime.parse(row['Date'] as String);
      double value = 0;
      switch (table) {
        case "Fajr":
          Fajr_Items.forEach((item) {
            String columnName = item['id'];
            if (row[columnName] == 1) {
              value += item['points'];
            }
          });
          break;
        case "Dhuhr":
          Dhuhr_Items.forEach((item) {
            String columnName = item['id'];
            if (row[columnName] == 1) {
              value += item['points'];
            }
          });
          break;
        case "General":
          General_Items.forEach((item) {
            String columnName = item['id'];
            if (row[columnName] == 1) {
              value += item['points'];
            }
          });
          break;
        case "Asr":
          Asr_Items.forEach((item) {
            String columnName = item['id'];
            if (row[columnName] == 1) {
              value += item['points'];
            }
          });
          break;
        case "Maghrib":
          Maghrib_Items.forEach((item) {
            String columnName = item['id'];
            if (row[columnName] == 1) {
              value += item['points'];
            }
          });
          break;
        case "Isha":
          Isha_Items.forEach((item) {
            String columnName = item['id'];
            if (row[columnName] == 1) {
              value += item['points'];
            }
          });
          break;
        case "Fazayel":
          Qadr_Data.forEach((item) {
            String columnName = item['id'];
            if (row[columnName] == 1) {
              value += item['points'];
            }
          });
          break;
        default:
      }

      return PrayerData(date, value);
    }).toList();

    return prayerDataList;
  }

  Future<double> lifeTimePointCounter() async {
    List<String> myTableNames = [
      'Fajr',
      'Dhuhr',
      'General',
      'Asr',
      'Maghrib',
      'Isha',
      'Fazayel',
    ];

    Database db = await instance.database;

    double value = 0;

    // Iterate tables as table
    await Future.forEach(myTableNames, (table) async {
      final result = await db.query(table);
      // Loop through the result for each table
      result.forEach((row) {
        // print("row=> " + row.toString() + "Tables=.> " + table.toString());
        switch (table) {
          case 'Fajr':
            Fajr_Items.forEach((item) {
              String columnName = item['id'];
              if (row[columnName] == 1) {
                value += item['points'];
              }
            });
            break;
          case 'Dhuhr':
            Dhuhr_Items.forEach((item) {
              String columnName = item['id'];
              if (row[columnName] == 1) {
                value += item['points'];
              }
            });
            break;
          case 'General':
            General_Items.forEach((item) {
              String columnName = item['id'];
              if (row[columnName] == 1) {
                value += item['points'];
              }
            });
            break;
          case 'Asr':
            Asr_Items.forEach((item) {
              String columnName = item['id'];
              if (row[columnName] == 1) {
                value += item['points'];
              }
            });
            break;
          case 'Maghrib':
            Maghrib_Items.forEach((item) {
              String columnName = item['id'];
              if (row[columnName] == 1) {
                value += item['points'];
              }
            });
            break;
          case 'Isha':
            Isha_Items.forEach((item) {
              String columnName = item['id'];
              if (row[columnName] == 1) {
                value += item['points'];
              }
            });
            break;
          case 'Fazayel':
            Qadr_Data.forEach((item) {
              String columnName = item['id'];
              if (row[columnName] == 1) {
                value += item['points'];
              }
            });
            break;
          default:
        }
      });
    });
    // print("Value--->" + value.toString());
    return value;
  }

  //Existing Rows Checking Func
  Future<bool> isRowEmpty(String Table) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> existingRows = await db.query(
      Table,
      where: 'Date = ?',
      whereArgs: [formattedStringDate],
      limit: 1,
    );
    if (existingRows.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> getTodaysPoint(
      String tableName, String formattedStringDate) async {
    int totalSum = 0;

    // Retrieve columns dynamically
    List<Map<String, dynamic>> columns = await myDatabase!.rawQuery(
      'PRAGMA table_info($tableName)',
    );

    // Iterate through the columns to exclude columnId and columnDate
    for (var i = 2; i < columns.length; i++) {
      var column = columns[i];
      String columnName = column['name'];
      // print('Column Name ---> $columnName');
      // Query to calculate the sum of the column values for the current date
      List<Map<String, dynamic>> result = await myDatabase!.rawQuery(
        'SELECT SUM($columnName) FROM $tableName WHERE Date = ?',
        [formattedStringDate],
      );
      int columnSum = (result[0].values.first ?? 0).toInt();

      totalSum += columnSum;
    }

    return totalSum;
  }

  Future<List<Map<String, dynamic>>> getAllData(String tableName) async {
    Database db = await instance.database;
    // final List<Map<String, dynamic>> result = await db.query(tableName);
    final List<Map<String, dynamic>> result = await db.query(
      tableName,
      orderBy: 'Date DESC',
    );
    return result;
  }

  Future<int> insertData(String tableName, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }

  Future<int> updateData(
      String tableName, Map<String, dynamic> row, int id) async {
    Database db = await instance.database;
    return await db.update(tableName, row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteData(String tableName, String date) async {
    Database db = await instance.database;
    return await db.delete(tableName, where: 'Date = ?', whereArgs: [date]);
  }

  ///Fajr to do

  Future<List<Map<String, dynamic>>> fetchValuesFromDatabase(
      String tableName,
      String columnDate,
      String amal_date,
      List<Map<String, dynamic>> fajrItems) async {
    Database db = await instance.database;
    // DateTime now = DateTime.now();
    // String currentDate =
    //     "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    // String formattedDate = DateTime.now().toIso8601String().substring(0, 10);
    // String formattedStringDate =
    //     '${DateTime.now().day.toString().padLeft(2, '0')} ${DateFormat.MMM().format(DateTime.now())} ${DateTime.now().year}';

    List<dynamic> columnIds = fajrItems.map((item) => item['id']).toList();
    String columnsToSelect = columnIds.join(',');

    List<Map<String, dynamic>> fetchedItems = await db.query(
      tableName,
      columns: [columnDate, ...columnIds],
      where: '$columnDate = ?',
      whereArgs: [amal_date],
    );
    // print("fetched items====>" + fetchedItems.toString());
    if (fetchedItems.isNotEmpty) {
      Map<String, dynamic> fetchedItem = fetchedItems.first;
      fajrItems.forEach((item) {
        String id = item['id'];
        if (fetchedItem.containsKey(id)) {
          item['isChecked'] = fetchedItem[id] == 1 ? true : false;
        }
      });
    }
    // print("Fetched Items---------------------" + fajrItems.toString());
    return fajrItems;
  }

  List<Map<String, dynamic>> modifiedFajrItems = [];
  List<Map<String, dynamic>> modifiedDhuhrItems = [];
  List<Map<String, dynamic>> modifiedGeneralItems = [];
  List<Map<String, dynamic>> modifiedAsrItems = [];
  List<Map<String, dynamic>> modifiedMaghribItems = [];
  List<Map<String, dynamic>> modifiedIshaItems = [];
  List<Map<String, dynamic>> modifiedFazayelItems = [];
  Future<List<Map<String, dynamic>>> initializeData(
      String tableName, String amal_date) async {
    switch (tableName) {
      case 'Fajr':
        modifiedFajrItems = await instance.fetchValuesFromDatabase(
            tableName, 'Date', amal_date.toString(), Fajr_Items);

        return modifiedFajrItems;
      case 'Dhuhr':
        modifiedDhuhrItems = await instance.fetchValuesFromDatabase(
            tableName, 'Date', amal_date.toString(), Dhuhr_Items);
        return modifiedDhuhrItems;
      case 'General':
        modifiedGeneralItems = await instance.fetchValuesFromDatabase(
            'General', 'Date', amal_date.toString(), General_Items);

        modifiedGeneralItems = General_Items;
        return modifiedGeneralItems;
      case 'Asr':
        modifiedAsrItems = await instance.fetchValuesFromDatabase(
            'Asr', 'Date', amal_date.toString(), Asr_Items);

        modifiedAsrItems = Asr_Items;
        return modifiedAsrItems;
      case 'Maghrib':
        modifiedAsrItems = await instance.fetchValuesFromDatabase(
            'Maghrib', 'Date', amal_date.toString(), Maghrib_Items);

        modifiedMaghribItems = Maghrib_Items;
        return modifiedMaghribItems;
      case 'Isha':
        modifiedIshaItems = await instance.fetchValuesFromDatabase(
            'Isha', 'Date', amal_date.toString(), Isha_Items);

        modifiedIshaItems = Isha_Items;
        return modifiedIshaItems;
      case 'Fazayel':
        modifiedFazayelItems = await instance.fetchValuesFromDatabase(
            'Fazayel', 'Date', amal_date.toString(), Qadr_Data);

        modifiedFazayelItems = Qadr_Data;
        return modifiedFazayelItems;

      default:
        return modifiedFajrItems;
      // case 'Asr':
      //   modifiedFajrItems = await instance.fetchValuesFromDatabase(
      //       tableName, 'Date', amal_date.toString(), Asr_Items);
      //   break;
    }
  }

  //update data
  updateDatabaseValue(
      String Table, String Col, String amal_date, bool value) async {
    Database db = await instance.database;

    var x = await db.update(
      Table,
      {Col: value ? 1 : 0}, // Assuming 1 represents true and 0 represents false
      where: 'Date = ?',
      whereArgs: [amal_date],
    );
    print("Table=> " +
        Table +
        "Coll=>" +
        Col +
        "amal_date=>" +
        amal_date +
        "value=>" +
        value.toString());
    print("Data reinitialized=>" + x.toString());

    return await initializeData(Table, amal_date.toString());
  }

  Future<num> calculateTotalAchievedPoints(
      String tableName, String date) async {
    num totalAchievedPoints = 0;
    List<Map<String, dynamic>> myList = [];
    myList = await initializeData(tableName, date);
    for (var item in myList) {
      if (item['isChecked'] && item['points'] != null) {
        totalAchievedPoints += item['points'];
      }
    }

    return totalAchievedPoints;
  }

  num calculateAvailablePoints(String items) {
    // items = Fajr_Items;
    num availablePoints = 0;
    switch (items) {
      case 'Fajr':
        Fajr_Items.forEach((item) {
          if (item.containsKey('points') && item['points'] != null) {
            availablePoints += (item['points'] as num? ?? 0);
            // print('point->>>>>' + item['points'].toString());
          }
        });

        return availablePoints;
      case 'Dhuhr':
        Dhuhr_Items.forEach((item) {
          if (item.containsKey('points') && item['points'] != null) {
            availablePoints += (item['points'] as num? ?? 0);
            // print('point->>>>>' + item['points'].toString());
          }
        });

        return availablePoints;
      case 'General':
        General_Items.forEach((item) {
          if (item.containsKey('points') && item['points'] != null) {
            availablePoints += (item['points'] as num? ?? 0);
            // print('point->>>>>' + item['points'].toString());
          }
        });

        return availablePoints;
      case 'Asr':
        Asr_Items.forEach((item) {
          if (item.containsKey('points') && item['points'] != null) {
            availablePoints += (item['points'] as num? ?? 0);
            // print('point->>>>>' + item['points'].toString());
          }
        });

        return availablePoints;
      case 'Maghrib':
        Maghrib_Items.forEach((item) {
          if (item.containsKey('points') && item['points'] != null) {
            availablePoints += (item['points'] as num? ?? 0);
            // print('point->>>>>' + item['points'].toString());
          }
        });

        return availablePoints;
      case 'Isha':
        Isha_Items.forEach((item) {
          if (item.containsKey('points') && item['points'] != null) {
            availablePoints += (item['points'] as num? ?? 0);
            // print('point->>>>>' + item['points'].toString());
          }
        });

        return availablePoints;
      case 'Fazayel':
        Qadr_Data.forEach((item) {
          if (item.containsKey('points') && item['points'] != null) {
            availablePoints += (item['points'] as num? ?? 0);
            // print('point->>>>>' + item['points'].toString());
          }
        });

        return availablePoints;
      default:
        return 0;
    }
  }

  num grossTotalAvailablePoints(List Tables) {
    num totalAvailablePoints = 0;
    for (var table in Tables) {
      num availablePoints = calculateAvailablePoints(table);

      totalAvailablePoints += availablePoints;
    }

    return totalAvailablePoints;
  }

  Future<num> todaysGrossTotalAchievedPoint(List Tables, String Date) async {
    num todaysTotalPoints = 0;
    for (var table in Tables) {
      num totalAchievedPoints = await calculateTotalAchievedPoints(table, Date);

      todaysTotalPoints += totalAchievedPoints;
    }
    return todaysTotalPoints;
  }

  Future<double> getTodaysProgress(String Table, String Date) async {
    double progress = 0;
    num totalAchievedPoints = await calculateTotalAchievedPoints(Table, Date);
    num availablePoints = await calculateAvailablePoints(Table);
    progress = (totalAchievedPoints / availablePoints);
    // print('Progress->>>>>' + progress.toString());
    return progress;
  }

  Future<double> getTodaysTotalProgress(List Tables, String Date) async {
    double progress = 0;
    num totalAchievedPoints = await todaysGrossTotalAchievedPoint(Tables, Date);
    num availablePoints = 0;
    for (var table in Tables) {
      availablePoints += calculateAvailablePoints(table);
    }
    progress = (totalAchievedPoints / availablePoints);
    // print('Progress->>>>>' + progress.toString());
    return progress;
  }

 Future<bool> checkTodaysFardPrayer(String tableName) async {
      Database db = await instance.database;

  String columnName = '';

  if (tableName == 'Fajr') {
    columnName = 'Two_Fard_Rakat';
  } else if (tableName == 'Dhuhr') {
    columnName = 'Four_Fard';
  } else if (tableName == 'Asr') {
    columnName = 'four_Rakaat_Fard';
  } else if (tableName == 'Maghrib') {
    columnName = 'Three_Rakat_Fard';
  } else if (tableName == 'Isha') {
    columnName = 'Four_Rakat_Fard';
  }

  // Fetch the corresponding column value from the database
  List<Map<String, dynamic>> result = await db.rawQuery(
    'SELECT $columnName FROM $tableName WHERE Date = ?',
    [formattedStringDate],
  );

  // Return the today's value (true or false) based on the database result
  if (result.isNotEmpty) {
    int columnValue = result.first.values.first;
    return (columnValue == 1);
  }

  return false; // Default value if no result found
}
}
