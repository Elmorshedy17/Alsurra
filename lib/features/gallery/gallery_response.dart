class GalleryResponse {
  int? status;
  String? message;
  Data? data;

  dynamic error;
  String? errorMsg;

  GalleryResponse.makeError({this.error, this.errorMsg});
  GalleryResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  GalleryResponse({this.status, this.message, this.data});

  GalleryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<Gallery>? gallery;
  Info? info;

  Data({this.gallery, this.info});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['gallery'] != null) {
      gallery = <Gallery>[];
      json['gallery'].forEach((v) {
        gallery!.add(Gallery.fromJson(v));
      });
    }
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
  }
}

class Gallery {
  int? id;
  String? name;
  String? image;

  Gallery({this.id, this.name, this.image});

  Gallery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Gallery &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          image == other.image;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ image.hashCode;
}

class Info {
  int? currentPage;
  String? firstPageUrl;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Info(
      {this.currentPage,
      this.firstPageUrl,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Info.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    firstPageUrl = json['first_page_url'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}
