class HotelOrChaletResponse {
  int? status;
  String? message;
  Data? data;
  dynamic error;
  String? errorMsg;

  HotelOrChaletResponse.makeError({this.error, this.errorMsg});
  HotelOrChaletResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }
  HotelOrChaletResponse({this.status, this.message, this.data});

  HotelOrChaletResponse.fromJson(Map<String, dynamic> json) {
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
  Hotel? hotel;

  Data({this.hotel});

  Data.fromJson(Map<String, dynamic> json) {
    hotel = json['hotel'] != null ? new Hotel.fromJson(json['hotel']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hotel != null) {
      data['hotel'] = this.hotel!.toJson();
    }
    return data;
  }
}

class Hotel {
  int? id;
  String? name;
  String? date;
  String? desc;
  String? price;
  String? oldPrice;
  String? image;
  List<Options>? options;

  Hotel(
      {this.id,
        this.name,
        this.date,
        this.desc,
        this.price,
        this.oldPrice,
        this.image,
        this.options});

  Hotel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    date = json['date'];
    desc = json['desc'];
    price = json['price'];
    oldPrice = json['old_price'];
    image = json['image'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['date'] = this.date;
    data['desc'] = this.desc;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['image'] = this.image;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  int? id;
  String? name;
  String? price;
  int? count;

  Options({this.id, this.name, this.price, this.count});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['count'] = this.count;
    return data;
  }
}
