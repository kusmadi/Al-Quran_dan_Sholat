class InterpreterQuranAyatModel {
  int? rowid;
  String? surahName;
  String? location;
  int? numAyah;
  int? surahId;
  int? ayah;
  String? arabic;
  String? wordsArray;
  String? transliteration;
  int? page;
  int? juz;
  int? manzil;
  int? hasAsbabun;
  String? text;
  String? footnotes;
  String? wajiz;
  String? tahlili;

  InterpreterQuranAyatModel({
    this.rowid,
    this.surahName,
    this.location,
    this.numAyah,
    this.surahId,
    this.ayah,
    this.arabic,
    this.wordsArray,
    this.transliteration,
    this.page,
    this.juz,
    this.manzil,
    this.hasAsbabun,
    this.text,
    this.footnotes,
    this.wajiz,
    this.tahlili,
  });

  InterpreterQuranAyatModel.fromJson(Map<String, dynamic> json) {
    rowid = json['rowid'];
    surahName = json['surah_name'];
    location = json['location'];
    numAyah = json['num_ayah'];
    surahId = json['surah_id'];
    ayah = json['ayah'];
    arabic = json['arabic'];
    wordsArray = json['words_array'];
    transliteration = json['transliteration'];
    page = json['page'];
    juz = json['juz'];
    manzil = json['manzil'];
    hasAsbabun = json['has_asbabun'];
    text = json['text'];
    footnotes = json['footnotes'];
    wajiz = json['wajiz'];
    tahlili = json['tahlili'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rowid'] = rowid;
    data['surah_name'] = surahName;
    data['location'] = location;
    data['num_ayah'] = numAyah;
    data['surah_id'] = surahId;
    data['ayah'] = ayah;
    data['arabic'] = arabic;
    data['words_array'] = wordsArray;
    data['transliteration'] = transliteration;
    data['page'] = page;
    data['juz'] = juz;
    data['manzil'] = manzil;
    data['has_asbabun'] = hasAsbabun;
    data['text'] = text;
    data['footnotes'] = footnotes;
    data['wajiz'] = wajiz;
    data['tahlili'] = tahlili;
    return data;
  }
}
