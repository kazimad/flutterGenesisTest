import 'dart:io';

import 'package:flutter_genesis_test/ui/utils/constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseMovieHelper {
  static final columnId = '_id';

  DatabaseMovieHelper._privateConstructor();

  static final DatabaseMovieHelper instance = DatabaseMovieHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "$DB_MOVIE_NAME.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $DB_MOVIE_NAME ("
          "adult INTEGER,"
          "backdrop_path TEXT,"
          "id INTEGER PRIMARY KEY,"
          "original_language TEXT,"
          "original_title TEXT,"
          "overview TEXT,"
          "popularity REAL,"
          "poster_path TEXT,"
          "release_date TEXT,"
          "title TEXT,"
          "video INTEGER,"
          "vote_average INTEGER,"
          "vote_count INTEGER, "
          "is_favorite INTEGER"
          ")");
    });
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(DB_MOVIE_NAME, row);
  }

  Future<List> insertAll(List<Map<String, dynamic>> listToInsert) async {
    Database db = await instance.database;
    var batch = db.batch();
    listToInsert.forEach((each) {
      batch.insert(DB_MOVIE_NAME, each);
    });
    return await batch.commit();
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(DB_MOVIE_NAME);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $DB_MOVIE_NAME'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db
        .update(DB_MOVIE_NAME, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(DB_MOVIE_NAME, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    Database db = await instance.database;
    return await db.rawDelete("Delete from $DB_MOVIE_NAME");
  }
}
