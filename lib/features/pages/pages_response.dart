
class PagesResponse {
  int? status;
  String? message;
  Data? data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PagesResponse &&
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
  dynamic error;
  String? errorMsg;

  PagesResponse.makeError({this.error, this.errorMsg});
  PagesResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }
  PagesResponse({this.status, this.message, this.data});

  PagesResponse.fromJson(Map<String, dynamic> json) {
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
  List<Pages>? pages;

  Data({this.pages});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['pages'] != null) {
      pages = <Pages>[];
      json['pages'].forEach((v) {
        pages!.add(new Pages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pages != null) {
      data['pages'] = this.pages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pages {
  int? id;
  String? title;
  String? desc;

  Pages({this.id, this.title, this.desc});

  Pages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['desc'] = this.desc;
    return data;
  }
}
