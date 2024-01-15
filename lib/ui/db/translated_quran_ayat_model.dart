class TranslatedQuranAyatModel {
  int? rowid;
  int? surahId;
  int? ayah;
  String? arabic;
  String? wordsArray;
  String? transliteration;
  int? page;
  int? juz;
  int? quarterHizb;
  int? manzil;
  int? hasAsbabun;
  int? edition;
  String? text;
  String? footnotes;

  TranslatedQuranAyatModel({
    this.rowid,
    this.surahId,
    this.ayah,
    this.arabic,
    this.wordsArray,
    this.transliteration,
    this.page,
    this.juz,
    this.quarterHizb,
    this.manzil,
    this.hasAsbabun,
    this.edition,
    this.text,
    this.footnotes,
  });

  TranslatedQuranAyatModel.fromJson(Map<String, dynamic> json) {
    rowid = json['rowid'];
    surahId = json['surah_id'];
    ayah = json['ayah'];
    arabic = json['arabic'];
    wordsArray = json['words_array'];
    transliteration = json['transliteration'];
    page = json['page'];
    juz = json['juz'];
    quarterHizb = json['quarter_hizb'];
    manzil = json['manzil'];
    hasAsbabun = json['has_asbabun'];
    edition = json['edition'];
    text = json['text'];
    footnotes = json['footnotes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rowid'] = rowid;
    data['surah_id'] = surahId;
    data['ayah'] = ayah;
    data['arabic'] = arabic;
    data['words_array'] = wordsArray;
    data['transliteration'] = transliteration;
    data['page'] = page;
    data['juz'] = juz;
    data['quarter_hizb'] = quarterHizb;
    data['manzil'] = manzil;
    data['has_asbabun'] = hasAsbabun;
    data['edition'] = edition;
    data['text'] = text;
    data['footnotes'] = footnotes;
    return data;
  }
}
