class SettingFrame {
  int? id;
  String? frame;
  String? openbg;
  int? suratId;
  int? ayatId;

  SettingFrame({this.id, this.frame, this.openbg, this.suratId, this.ayatId});

  SettingFrame.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    frame = json['frame'];
    openbg = json['openbg'];
    suratId = json['surat_id'];
    ayatId = json['ayat_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['frame'] = frame;
    data['openbg'] = openbg;
    data['surat_id'] = suratId;
    data['ayat_id'] = ayatId;
    return data;
  }
}
