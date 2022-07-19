
class FAQResponse {
  int? status;
  String? message;
  Data? data;
  dynamic error;
  String? errorMsg;

  FAQResponse.makeError({this.error, this.errorMsg});
  FAQResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }
  FAQResponse({this.status, this.message, this.data});

  FAQResponse.fromJson(Map<String, dynamic> json) {
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
  List<Faq>? faq;

  Data({this.faq});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['faq'] != null) {
      faq = <Faq>[];
      json['faq'].forEach((v) {
        faq!.add(new Faq.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.faq != null) {
      data['faq'] = this.faq!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Faq {
  int? id;
  String? name;
  String? desc;

  Faq({this.id, this.name, this.desc});

  Faq.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['desc'] = this.desc;
    return data;
  }
}
