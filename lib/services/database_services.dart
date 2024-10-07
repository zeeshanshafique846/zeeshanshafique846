import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code_scanner_app/main.dart';
import 'package:qr_code_scanner_app/modals/ScanModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Future<bool> checkIfTableExists(String tableName) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName';");

    return result.isNotEmpty;
  }

  static const dbName = 'code_db.db';
  static const dbVersion = 1;
  static const dbTable = 'qr_history_table';
  static final DatabaseHelper instance = DatabaseHelper();
  // Columns
  static const columnid = 'id';
  static const columntype = 'type';
  static const columnqrType = 'qr_type';
  static const columntitle = 'title';
  static const columnfirst_name = 'first_name';
  static const columnlast_name = 'last_name';
  static const columnwifi_name = 'wifi_name';
  static const columnimage_url = 'image_url';
  static const columnlink = 'link';
  static const columnpassword = 'password';
  static const columnprotocol = 'protocol';
  static const columnis_hidden = 'is_hidden';
  static const columnstart_datetime = 'start_datetime';
  static const columnend_datetime = 'end_datetime';
  static const columnevent_location = 'event_location';
  static const columnevent_description = 'event_description';
  static const columnjob = 'job';
  static const columnindustry = 'industry';
  static const columnemail = 'email';
  static const columncontact_number = 'contact_number';
  static const columncomapny_name = 'company_name';
  static const columnwebsite = 'website';
  static const columnaddress = 'address';
  static const columncity = 'city';
  static const columncountry = 'country';
  static const columncreated_at = 'created_at';
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDb();
    return _database!;
  }

  initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    print("path  : $path");
    return await openDatabase(path, version: dbVersion, onCreate: onCreate);
  }

  Future onCreate(Database db, int version) async {
    // bool tableExists = await checkIfTableExists(dbTable);

    await db.execute('''
      CREATE TABLE $dbTable (
        $columnid INTEGER PRIMARY KEY AUTOINCREMENT,
        $columntype TEXT,
        $columnqrType TEXT,
        $columntitle TEXT,
        $columnfirst_name TEXT,
        $columnlast_name TEXT,
        $columnwifi_name TEXT,
        $columnimage_url TEXT,
        $columnlink TEXT,
        $columnpassword TEXT,
        $columnprotocol TEXT,
        $columnis_hidden TEXT,
        $columnstart_datetime TEXT,
        $columnend_datetime TEXT,
        $columnevent_location TEXT,
        $columnevent_description TEXT,
        $columnjob TEXT,
        $columnindustry TEXT,
        $columnemail TEXT,
        $columncontact_number TEXT,
        $columncomapny_name TEXT,
        $columnwebsite TEXT,
        $columnaddress TEXT,
        $columncity TEXT,
        $columncountry TEXT,
        $columncreated_at TEXT
      )
    ''');
  }

  insert(Map<String, dynamic> row,
      {HistoryModel? history, String? imageUrl}) async {
    history!.imageUrl = imageUrl!;
    Database db = await instance.database;
    print("db   >   $db");
    return await db.insert(dbTable, HistoryModel.toMap(history!));
  }

  Future<List<Map<String, dynamic>>> queryDatabase() async {
    Database db = await instance.database;
    return await db.query(dbTable);
  }

  Future<int> update(Map<String, dynamic> row, int id) async {
    Database db = await instance.database;
    return await db.update(
      dbTable,
      row,
      where: '$columnid = ?',
      whereArgs: [id],
    );
  }

  Future<List<String>> getColumnNames() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result =
        await db.rawQuery('PRAGMA table_info($dbTable)');

    List<String> columnNames = [];
    for (var row in result) {
      columnNames.add(row['name']);
    }

    return columnNames;
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(
      dbTable,
      where: '$columnid = ?',
      whereArgs: [id],
    );
  }

  // Future<List<Map<String, dynamic>>> getwithId(String collectionName) async {
  //   Database db = await instance.database;
  //   return await db.rawQuery(
  //       'SELECT * FROM $dbTable WHERE $columnCollectionName=?',
  //       [collectionName]);
  // }

  // Future<List<Map<String, dynamic>>> getwithoutId() async {
  //   Database db = await instance.database;
  //   return await db
  //       .rawQuery('SELECT * FROM $dbTable WHERE $columnstatus=?', [1]);
  // }
}
