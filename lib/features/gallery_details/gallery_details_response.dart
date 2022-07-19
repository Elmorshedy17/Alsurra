class GalleryDetailsResponse {
  int? status;
  String? message;
  Data? data;

  dynamic error;
  String? errorMsg;

  GalleryDetailsResponse.makeError({this.error, this.errorMsg});
  GalleryDetailsResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  GalleryDetailsResponse({this.status, this.message, this.data});

  GalleryDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  GalleryDetails? gallery;

  Data({this.gallery});

  Data.fromJson(Map<String, dynamic> json) {
    gallery = json['gallery'] != null
        ? GalleryDetails.fromJson(json['gallery'])
        : null;
  }
}

class GalleryDetails {
  int? id;
  String? name;
  List<String>? images;

  GalleryDetails({this.id, this.name, this.images});

  GalleryDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    images = json['images'].cast<String>();
  }
}
