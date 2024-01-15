class ChannelModel {
  int? id;
  String? name;
  String? photo;
  String? favorite;
  List<Playlists>? playlists;

  ChannelModel({this.id, this.name, this.photo, this.favorite, this.playlists});

  ChannelModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    favorite = json['favorite'];
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
    data['favorite'] = favorite;
    if (playlists != null) {
      data['playlists'] = playlists!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Playlists {
  int? channelId;

  Playlists({this.channelId});

  Playlists.fromJson(Map<String, dynamic> json) {
    channelId = json['channel_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['channel_id'] = channelId;
    return data;
  }
}
