import 'dart:io';

import 'package:flutter_genesis_test/ui/utils/constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseMovieHelper {
  DatabaseMovieHelper._privateConstructor();

  static Database _database;
  static final columnId = '_id';
  static final DatabaseMovieHelper instance = DatabaseMovieHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "$DB_MOVIE_NAME.db");
    return await openDatabase(path, version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async {
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

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(DB_MOVIE_NAME);
  }

  Future<List<Map<String, dynamic>>> queryMoviesWithId(List<dynamic> moviesIds) async {
    Database db = await instance.database;
    var moviesIdsString = moviesIds.toString().replaceAll("[", "(").replaceAll("]", ")");
    var res = await db.query(DB_MOVIE_NAME, where: 'id in $moviesIdsString');
    return res.isNotEmpty ? res : null;
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $DB_MOVIE_NAME'));
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(DB_MOVIE_NAME, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(DB_MOVIE_NAME, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    Database db = await instance.database;
    return await db.rawDelete("Delete from $DB_MOVIE_NAME");
  }
}
