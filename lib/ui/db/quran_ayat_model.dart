class QuranAyatModel {
  int? rowid;
  int? surahId;
  int? ayah;
  String? arabic;
  String? transliteration;
  int? page;
  int? juz;
  int? manzil;
  String? noTashkeel;
  int? hasAsbabun;
  String? wordsArray;

  QuranAyatModel({
    this.rowid,
    this.surahId,
    this.ayah,
    this.arabic,
    this.transliteration,
    this.page,
    this.juz,
    this.manzil,
    this.noTashkeel,
    this.hasAsbabun,
    this.wordsArray,
  });

  QuranAyatModel.fromJson(Map<String, dynamic> json) {
    rowid = json['rowid'];
    surahId = json['surah_id'];
    ayah = json['ayah'];
    arabic = json['arabic'];
    transliteration = json['transliteration'];
    page = json['page'];
    juz = json['juz'];
    manzil = json['manzil'];
    noTashkeel = json['no_tashkeel'];
    hasAsbabun = json['has_asbabun'];
    wordsArray = json['words_array'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rowid'] = rowid;
    data['surah_id'] = surahId;
    data['ayah'] = ayah;
    data['arabic'] = arabic;
    data['transliteration'] = transliteration;
    data['page'] = page;
    data['juz'] = juz;
    data['manzil'] = manzil;
    data['no_tashkeel'] = noTashkeel;
    data['has_asbabun'] = hasAsbabun;
    data['words_array'] = wordsArray;
    return data;
  }
}
