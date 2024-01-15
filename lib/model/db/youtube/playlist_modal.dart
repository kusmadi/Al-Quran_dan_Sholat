class PlaylistModel {
  int? id;
  String? title;
  String? link;
  String? channelName;
  String? channelPhoto;

  PlaylistModel(
      {this.id,
        this.title,
        this.link,
        this.channelName,
        this.channelPhoto});

  PlaylistModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    link = json['link'];
    channelName = json['channel_name'];
    channelPhoto = json['channel_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['link'] = link;
    data['channel_name'] = channelName;
    data['channel_photo'] = channelPhoto;
    return data;
  }
}
