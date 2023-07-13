import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SqlHelper {
  static Future<void> createTable(sql.Database database) async {
    print("inside create table");
    await database.execute(
        """ CREATE TABLE  items(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    firstname TEXT,lastname TEXT,dob TEXT,about TEXT,address TEXT,education TEXT,skills TEXT,hobbies TEXT)""");
  }

  static Future<sql.Database> db() async {
    //print("inside  db");
    return sql.openDatabase("resumePath.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTable(database);
    });
  }

  static Future<int> createIem(String? firstname, String? lastName, String? dob,
      String? about, String? address,String? education, String? skills, String? hobbies) async {
    print("inside create item${getItems()}");
    final db = await SqlHelper.db();
    final data = {
      "firstname": firstname,
      "lastname": lastName,
      "dob": dob,
      "about": about,
      "education":education,
      "address": address,
      "skills": skills,
      "hobbies": hobbies
    };
    print("${data}");
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SqlHelper.db();
    return db.query("items", orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SqlHelper.db();
    return db.query("items", where: "id=?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(int id, String? firstname, String? lastName, String? dob,
      String? about,String? education, String? address, String? skills, String? hobbies) async {
    final db = await SqlHelper.db();

    final data = {
      "firstname": firstname,
      "lastname": lastName,
      "dob": dob,
      "about": about,
      "education":education,
      "address": address,
      "skills": skills,
      "hobbies": hobbies
    };
    final result =
        await db.update("items", data, where: "id=?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SqlHelper.db();

    try {
      await db.delete("items", where: "id=?", whereArgs: [id]);
    } catch (error) {
      debugPrint("something went wrong ");
    }
  }
}
