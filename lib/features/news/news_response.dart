class NewsResponse {
  int? status;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsResponse &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          message == other.message &&
          data == other.data &&
          error == other.error &&
          errorMsg == other.errorMsg;

  @override
  int get hashCode =>
      status.hashCode ^
      message.hashCode ^
      data.hashCode ^
      error.hashCode ^
      errorMsg.hashCode;
  String? message;
  Data? data;

  dynamic error;
  String? errorMsg;

  NewsResponse.makeError({this.error, this.errorMsg});
  NewsResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  NewsResponse({this.status, this.message, this.data});

  NewsResponse.fromJson(Map<String, dynamic> json) {
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
  List<News>? news;
  Info? info;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Data &&
          runtimeType == other.runtimeType &&
          news == other.news &&
          info == other.info;

  @override
  int get hashCode => news.hashCode ^ info.hashCode;

  Data({this.news, this.info});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['news'] != null) {
      news = <News>[];
      json['news'].forEach((v) {
        news!.add(new News.fromJson(v));
      });
    }
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.news != null) {
      data['news'] = this.news!.map((v) => v.toJson()).toList();
    }
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    return data;
  }
}

class News {
  int? id;
  String? name;
  String? image;

  News({this.id, this.name, this.image});

  News.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['first_page_url'] = this.firstPageUrl;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}
