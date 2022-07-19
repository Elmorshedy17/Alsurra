class OfferOrDiscountResponse {
  int? status;
  String? message;
  Data? data;
  dynamic error;
  String? errorMsg;

  OfferOrDiscountResponse.makeError({this.error, this.errorMsg});
  OfferOrDiscountResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }
  OfferOrDiscountResponse({this.status, this.message, this.data});

  OfferOrDiscountResponse.fromJson(Map<String, dynamic> json) {
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
  Discount? discount;

  Data({this.discount});

  Data.fromJson(Map<String, dynamic> json) {
    discount = json['discount'] != null
        ? new Discount.fromJson(json['discount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.discount != null) {
      data['discount'] = this.discount!.toJson();
    }
    return data;
  }
}

class Discount {
  int? id;
  String? name;
  String? date;
  String? duration;
  String? address;
  String? desc;
  String? conditions;
  String? card;
  String? price;
  String? oldPrice;
  String? image;

  Discount(
      {this.id,
        this.name,
        this.date,
        this.duration,
        this.address,
        this.desc,
        this.conditions,
        this.card,
        this.oldPrice,
        this.price,
        this.image});

  Discount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    date = json['date'];
    duration = json['duration'];
    address = json['address'];
    desc = json['desc'];
    conditions = json['conditions'];
    card = json['card'];
    price = json['price'];
    oldPrice = json['old_price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['date'] = this.date;
    data['duration'] = this.duration;
    data['address'] = this.address;
    data['desc'] = this.desc;
    data['conditions'] = this.conditions;
    data['card'] = this.card;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['image'] = this.image;
    return data;
  }
}
