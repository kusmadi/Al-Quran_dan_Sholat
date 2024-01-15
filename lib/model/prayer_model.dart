class PrayerModel {
  int? id;
  String? payerName;

  PrayerModel({this.id, this.payerName});

  PrayerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    payerName = json['payer_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['payer_name'] = payerName;
    return data;
  }
}
