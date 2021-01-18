// import 'package:procura_online/database/database_helper.dart';
// import 'package:procura_online/models/message_model.dart';
// import 'package:sqflite/sqflite.dart';

// class MessagesDb {
//   var tableName = 'messages';

//   //Insert into table
//   Future<int> insertMsg(Message message) async {
//     Database db = await DatabaseHelper.instance.database;
//     print(message.id);
//     return await db.insert(tableName, message.toJson());
//   }
// }
