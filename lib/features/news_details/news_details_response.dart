
class NewsDetailsResponse {
  int? status;
  String? message;
  Data? data;
  dynamic error;
  String? errorMsg;

  NewsDetailsResponse.makeError({this.error, this.errorMsg});
  NewsDetailsResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }
  NewsDetailsResponse({this.status, this.message, this.data});

  NewsDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  News? news;

  Data({this.news});

  Data.fromJson(Map<String, dynamic> json) {
    news = json['news'] != null ? new News.fromJson(json['news']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.news != null) {
      data['news'] = this.news!.toJson();
    }
    return data;
  }
}

class News {
  int? id;
  String? name;
  String? desc;
  String? image;

  News({this.id, this.name, this.desc, this.image});

  News.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['image'] = this.image;
    return data;
  }
}
