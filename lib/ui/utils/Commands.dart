import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/ui/utils/Constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Commands {
//  static Future<Database> _database;

//  static Future<Database> get database async {
//    if (_database != null) return _database;
//
//    // if _database is null we instantiate it
//    _database = await _openDataBase();
//    return _database;
//  }

  static Database _database;
  Future<Database> get database async {
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "$DB_NAME.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $DB_NAME ("
          "id INTEGER PRIMARY KEY,"
          "userId INTEGER,"
          "title TEXT,"
          "body TEXT"
          ")");
    });
  }

//  static _openDataBase() async {
//    openDatabase(
//      join(await getDatabasesPath(), 'post_database.db'),
//      onCreate: (db, version) {
//        return db.execute(
//          "CREATE TABLE $DB_NAME(id INTEGER PRIMARY KEY, userId INTEGER, title TEXT, body TEXT)",
//        );
//      },
//      version: 1,
//    );
//  }

  static showSnackBar(context, String whatToShow) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(whatToShow)));
  }
}
