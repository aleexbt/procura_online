// import 'dart:io';

// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';

// class DatabaseHelper {
//   static final _databaseName = "procura_online.db";
//   static final _databaseVersion = 1;

//   //Columns for messages table
//   final id = 'id';
//   final userId = 'user_id';
//   final message = 'message';
//   final isSeen = 'is_seen';
//   final deletedFromSender = 'deleted_from_server';
//   final deletedFromReceiver = 'deleted_from_receiver';
//   final conversationId = 'conversation_id';
//   final humanReadDate = 'human_read_date';
//   final daysSectionDate = 'days_section_date';
//   final sender = 'sender';
//   final hasAttachments = 'has_attachments';
//   final media = 'media';

//   // make this a singleton class
//   DatabaseHelper._privateConstructor();

//   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

//   // only have a single app-wide reference to the database
//   static Database _dbObj;

//   Future<Database> get database async {
//     if (_dbObj != null) return _dbObj;
//     // lazily instantiate the db the first time it is accessed
//     _dbObj = await _initDatabase();
//     return _dbObj;
//   }

//   // this opens the database (and creates it if it doesn't exist)
//   _initDatabase() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, _databaseName);
//     return await openDatabase(path,
//         version: _databaseVersion, onCreate: _onCreate);
//   }

//   // SQL code to create the database table
//   Future _onCreate(Database db, int version) async {
//     await db.execute(
//         '''CREATE TABLE messages ($id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $userId TEXT, $message TEXT, $isSeen TEXT,
//          $deletedFromSender TEXT, $deletedFromReceiver TEXT,
//          $conversationId TEXT, $humanReadDate TEXT, $daysSectionDate TEXT, $hasAttachments TEXT, $media TEXT)''');
//   }
// }
