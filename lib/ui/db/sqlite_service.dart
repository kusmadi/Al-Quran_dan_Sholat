import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:quran/ui/db/interpreter_quran_ayat_model.dart';
import 'package:quran/ui/db/quran_ayat_model.dart';
import 'package:quran/ui/db/quran_surat_model.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  Future<Database> initializeDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "quran.db");

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data =
          await rootBundle.load(join("assets/db", "quran_per_ayah.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }

    // open the database
    return await openDatabase(path, readOnly: true);
  }

  ///Retrieve surat quran
  Future<List<QuranSuratModel>> retrieveQuranSurat() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.query('quran_surah');
    return queryResult.map((e) => QuranSuratModel.fromJson(e)).toList();
  }

  ///Retrieve ayat quran
  Future<List<InterpreterQuranAyatModel>> retrieveQuranAyat(suratId) async {
    String sql = "select quran_ayah.rowid, quran_surah.arabic as surah_name, quran_surah.location, quran_surah.num_ayah, quran_ayah.surah_id, ayah, quran_ayah.arabic, words_array, transliteration, page, juz, manzil, has_asbabun, translation.text, footnotes, wajiz, tahlili from quran_ayah inner join quran_surah on quran_surah.rowid = quran_ayah.surah_id inner join translation on quran_ayah.rowid = translation.ayah_id inner join tafsir on quran_ayah.rowid = tafsir.ayah_id WHERE quran_ayah.surah_id = ? GROUP BY quran_ayah.ayah";
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.rawQuery(sql, [suratId]);
    return queryResult.map((e) => InterpreterQuranAyatModel.fromJson(e)).toList();
  }
}
