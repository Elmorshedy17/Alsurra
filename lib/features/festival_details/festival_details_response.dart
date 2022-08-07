

class FestivalDetailsResponse {
  int? status;
  String? message;
  Data? data;
  dynamic error;
  String? errorMsg;

  FestivalDetailsResponse.makeError({this.error, this.errorMsg});
  FestivalDetailsResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }
  FestivalDetailsResponse({this.status, this.message, this.data});

  FestivalDetailsResponse.fromJson(Map<String, dynamic> json) {
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
  Offer? offer;

  Data({this.offer});

  Data.fromJson(Map<String, dynamic> json) {
    offer = json['offer'] != null ? new Offer.fromJson(json['offer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.offer != null) {
      data['offer'] = this.offer!.toJson();
    }
    return data;
  }
}

class Offer {
  int? id;
  String? name;
  String? desc;
  String? startDate;
  String? endDate;
  String? image;
  List<String>? images;

  Offer(
      {this.id,
        this.name,
        this.desc,
        this.startDate,
        this.endDate,
        this.image,
        this.images});

  Offer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    image = json['image'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['image'] = this.image;
    data['images'] = this.images;
    return data;
  }
}

