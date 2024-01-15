class AsbabunNuzulModel {
  int? rowid;
  int? ayahId;
  String? text;

  AsbabunNuzulModel({this.rowid, this.ayahId, this.text});

  AsbabunNuzulModel.fromJson(Map<String, dynamic> json) {
    rowid = json['rowid'];
    ayahId = json['ayah_id'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rowid'] = rowid;
    data['ayah_id'] = ayahId;
    data['text'] = text;
    return data;
  }
}
