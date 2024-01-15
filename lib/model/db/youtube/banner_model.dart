class BannerModel {
  int? id;
  String? name;
  String? photo;
  String? url;

  BannerModel({this.id, this.name, this.photo, this.url});

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['photo'] = photo;
    data['url'] = url;
    return data;
  }
}
