import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "procura_online.db";
  static final _databaseVersion = 1;


  //Columns for User Table
  final id = 'id';
  final token = 'token';
  final name = 'name';
  final email = 'email';
  final avatar = 'avatar';
  final subscription = 'subscription';
  final isUserLoggedIn = 'isUserLoggedIn';

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _dbObj;

  Future<Database> get database async {
    if (_dbObj != null) return _dbObj;
    // lazily instantiate the db the first time it is accessed
    _dbObj = await _initDatabase();
    return _dbObj;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE user_table ($id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $token TEXT, $email TEXT, $name TEXT,
         $avatar TEXT, $subscription TEXT,
         $isUserLoggedIn INTEGER NOT NULL)''');
  }
}
