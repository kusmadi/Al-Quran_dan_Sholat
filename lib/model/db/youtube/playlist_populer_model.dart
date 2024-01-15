class PlaylistPopularModel {
  int? id;
  String? name;
  String? photo;
  List<Playlists>? playlists;

  PlaylistPopularModel({this.id, this.name, this.photo, this.playlists});

  PlaylistPopularModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    if (json['playlists'] != null) {
      playlists = <Playlists>[];
      json['playlists'].forEach((v) {
        playlists!.add(Playlists.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['photo'] = photo;
    if (playlists != null) {
      data['playlists'] = playlists!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Playlists {
  String? title;
  String? link;
  int? channelId;

  Playlists({this.title, this.link, this.channelId});

  Playlists.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    link = json['link'];
    channelId = json['channel_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['link'] = link;
    data['channel_id'] = channelId;
    return data;
  }
}
