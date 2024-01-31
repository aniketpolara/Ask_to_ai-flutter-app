class PhotosModel {
  String? url;

  PhotosModel({this.url});

  PhotosModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['url'] = url;
    return data;
  }
}
