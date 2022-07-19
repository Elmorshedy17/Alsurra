
class OffersAndDiscountsResponse {
  int? status;
  String? message;
  Data? data;

  dynamic error;
  String? errorMsg;

  OffersAndDiscountsResponse.makeError({this.error, this.errorMsg});
  OffersAndDiscountsResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }


  OffersAndDiscountsResponse({this.status, this.message, this.data});

  OffersAndDiscountsResponse.fromJson(Map<String, dynamic> json) {
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
  List<Discounts>? discounts;
  Info? info;

  Data({this.discounts, this.info});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['discounts'] != null) {
      discounts = <Discounts>[];
      json['discounts'].forEach((v) {
        discounts!.add(new Discounts.fromJson(v));
      });
    }
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.discounts != null) {
      data['discounts'] = this.discounts!.map((v) => v.toJson()).toList();
    }
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    return data;
  }
}

class Discounts {
  int? id;
  String? name;
  String? desc;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Discounts &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          desc == other.desc &&
          price == other.price &&
          image == other.image;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      desc.hashCode ^
      price.hashCode ^
      image.hashCode;
  String? price;
  String? image;

  Discounts({this.id, this.name, this.desc, this.price, this.image});

  Discounts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['price'] = this.price;
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
  dynamic prevPageUrl;
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
