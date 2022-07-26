class PhotoGalleryModel {
  bool? status;
  String? message;
  List<Photos>? photos;

  PhotoGalleryModel({this.status, this.message, this.photos});

  PhotoGalleryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(new Photos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.photos != null) {
      data['photos'] = this.photos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Photos {
  String? id;
  String? author;
  int? width;
  int? height;
  String? url;
  String? downloadUrl;

  Photos(
      {this.id,
      this.author,
      this.width,
      this.height,
      this.url,
      this.downloadUrl});

  Photos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author = json['author'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    downloadUrl = json['download_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['author'] = this.author;
    data['width'] = this.width;
    data['height'] = this.height;
    data['url'] = this.url;
    data['download_url'] = this.downloadUrl;
    return data;
  }
}
