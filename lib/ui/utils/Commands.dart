import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Commands {
  static Future<Database> _database;

  static Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await _openDataBase();
    return _database;
  }

  static _openDataBase() async {
    openDatabase(
      join(await getDatabasesPath(), 'post_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE posts(id INTEGER PRIMARY KEY, userId INTEGER, title TEXT, body TEXT)",
        );
      },
      version: 1,
    );
  }

  static showSnackBar(context, String whatToShow) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(whatToShow)));
  }
}
