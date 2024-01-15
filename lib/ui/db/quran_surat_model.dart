class QuranSuratModel {
  int? rowid;
  String? surahName;
  String? arabic;
  String? translate;
  String? location;
  int? numAyah;

  QuranSuratModel({
    this.rowid,
    this.surahName,
    this.arabic,
    this.translate,
    this.location,
    this.numAyah,
  });

  QuranSuratModel.fromJson(Map<String, dynamic> json) {
    rowid = json['rowid'];
    surahName = json['surah_name'];
    arabic = json['arabic'];
    translate = json['translate'];
    location = json['location'];
    numAyah = json['num_ayah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rowid'] = rowid;
    data['surah_name'] = surahName;
    data['arabic'] = arabic;
    data['translate'] = translate;
    data['location'] = location;
    data['num_ayah'] = numAyah;
    return data;
  }
}
