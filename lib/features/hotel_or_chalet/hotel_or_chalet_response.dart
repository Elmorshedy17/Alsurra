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
}

class Data {
  Hotel? hotel;

  Data({this.hotel});

  Data.fromJson(Map<String, dynamic> json) {
    hotel = json['hotel'] != null ? new Hotel.fromJson(json['hotel']) : null;
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
  String? card;
  List<Options>? options;

  Hotel(
      {this.id,
      this.name,
      this.date,
      this.desc,
      this.price,
      this.oldPrice,
      this.image,
      this.card,
      this.options});

  Hotel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    date = json['date'];
    desc = json['desc'];
    price = json['price'];
    oldPrice = json['old_price'];
    image = json['image'];
    card = json['card'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
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
}
