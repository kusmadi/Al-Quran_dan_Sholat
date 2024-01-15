import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quran/config/constant.dart';
import 'package:quran/model/db/youtube/banner_model.dart';
import 'package:quran/model/db/youtube/channel_model.dart';
import 'package:quran/model/db/youtube/playlist_modal.dart';
import 'package:quran/model/db/youtube/playlist_populer_model.dart';
import 'package:quran/model/prayer_model.dart';
import 'package:quran/ui/db/interpreter_quran_ayat_model.dart';
import 'package:quran/ui/db/quran_surat_model.dart';
import 'package:quran/ui/db/sqlite_service.dart';

class QuranServices {
  static Future<List<BannerModel>> getBanners() async {
    String url = '$GLOBAL_URL/api/getBanners';
    final response = await http.get(Uri.parse(url));
    String responseBody = response.body;
    dynamic jsonObject = json.decode(responseBody);
    final convertedJsonObject = jsonObject.cast<Map<String, dynamic>>();
    List<BannerModel> list = convertedJsonObject
        .map<BannerModel>((json) => BannerModel.fromJson(json))
        .toList();
    return list;
  }

  static Future<List<PlaylistModel>> getPlaylists(channelId) async {
    String url = '$GLOBAL_URL/api/getPlaylists/$channelId';
    final response = await http.get(Uri.parse(url));
    String responseBody = response.body;
    dynamic jsonObject = json.decode(responseBody);
    final convertedJsonObject = jsonObject.cast<Map<String, dynamic>>();
    List<PlaylistModel> list = convertedJsonObject
        .map<PlaylistModel>((json) => PlaylistModel.fromJson(json))
        .toList();
    return list;
  }

  static Future<List<PlaylistPopularModel>> getPlaylistPopuler() async {
    String url = '$GLOBAL_URL/api/getPlaylistPopuler';
    final response = await http.get(Uri.parse(url));
    String responseBody = response.body;
    dynamic jsonObject = json.decode(responseBody);
    final convertedJsonObject = jsonObject.cast<Map<String, dynamic>>();
    List<PlaylistPopularModel> list = convertedJsonObject
        .map<PlaylistPopularModel>(
            (json) => PlaylistPopularModel.fromJson(json))
        .toList();
    return list;
  }

  static Future<List<ChannelModel>> getChannels() async {
    String url = '$GLOBAL_URL/api/getChannels';
    final response = await http.get(Uri.parse(url));
    String responseBody = response.body;
    dynamic jsonObject = json.decode(responseBody);
    final convertedJsonObject = jsonObject.cast<Map<String, dynamic>>();
    List<ChannelModel> list = convertedJsonObject
        .map<ChannelModel>((json) => ChannelModel.fromJson(json))
        .toList();
    return list;
  }

  static Future<List<PrayerModel>> getPrayer() async {
    String url = '$GLOBAL_URL/api/getPrayer';
    final response = await http.post(Uri.parse(url));
    String responseBody = response.body;
    dynamic jsonObject = json.decode(responseBody);
    final convertedJsonObject = jsonObject.cast<Map<String, dynamic>>();
    List<PrayerModel> list = convertedJsonObject
        .map<PrayerModel>((json) => PrayerModel.fromJson(json))
        .toList();
    return list;
  }

  static Future<List<QuranSuratModel>> getQuranAllSurat() async {
    SqliteService sqliteService = SqliteService();
    sqliteService.initializeDB();
    List<QuranSuratModel> dbQuranPerSurat =
        await sqliteService.retrieveQuranSurat();
    String responseBody = jsonEncode(dbQuranPerSurat);
    dynamic jsonObject = json.decode(responseBody);
    final convertedJsonObject = jsonObject.cast<Map<String, dynamic>>();
    List<QuranSuratModel> list = convertedJsonObject
        .map<QuranSuratModel>((json) => QuranSuratModel.fromJson(json))
        .toList();
    return list;
  }

  static Future<List<InterpreterQuranAyatModel>> getQuranPerSurat(
      suratId) async {
    SqliteService sqliteService = SqliteService();
    sqliteService.initializeDB();
    List<InterpreterQuranAyatModel> dbQuranPerSurat =
        await sqliteService.retrieveQuranAyat(suratId);
    String responseBody = jsonEncode(dbQuranPerSurat);
    dynamic jsonObject = json.decode(responseBody);
    final convertedJsonObject = jsonObject.cast<Map<String, dynamic>>();
    List<InterpreterQuranAyatModel> list = convertedJsonObject
        .map<InterpreterQuranAyatModel>(
            (json) => InterpreterQuranAyatModel.fromJson(json))
        .toList();
    return list;
  }
}
