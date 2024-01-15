import 'dart:convert';

import 'package:path/path.dart';
import 'package:quran/ui/db/settings.dart';
import 'package:sqflite/sqflite.dart';

class SqliteSetting {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    print('$path/quran.db');
    return openDatabase(
      join(path, base64.encode(utf8.encode('quran.db'))),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE settings (id INTEGER PRIMARY KEY AUTOINCREMENT, frame TEXT NOT NULL, surat_id INT NOT NULL, ayat_id INT NOT NULL, openbg TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  ///Retrieve
  Future<List<SettingFrame>> retrieveSettings() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('settings');
    return queryResult.map((e) => SettingFrame.fromJson(e)).toList();
  }

  ///Save
  Future<int> insertSetting(List<SettingFrame> Settings) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var setting in Settings) {
      result = await db.insert('settings', setting.toJson());
    }
    return result;
  }

  ///Update
  Future<int> updateSetting(List<SettingFrame> Settings, int id) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var Setting in Settings) {
      result = await db.update(
        'settings',
        Setting.toJson(),
        where: "id = ?",
        whereArgs: [id],
      );
    }
    return result;
  }

  ///Delete
  Future<void> deleteSetting(int id) async {
    final db = await initializeDB();
    await db.delete(
      'settings',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
