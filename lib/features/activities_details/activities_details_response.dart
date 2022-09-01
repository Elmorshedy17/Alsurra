class ActivityDetailsResponse {
  int? status;
  String? message;
  Data? data;

  dynamic error;
  String? errorMsg;

  ActivityDetailsResponse.makeError({this.error, this.errorMsg});
  ActivityDetailsResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }
  ActivityDetailsResponse({this.status, this.message, this.data});

  ActivityDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  ActivityDetails? activityDetails;

  Data({this.activityDetails});

  Data.fromJson(Map<String, dynamic> json) {
    activityDetails = json['activity'] != null
        ? ActivityDetails.fromJson(json['activity'])
        : null;
  }
}

class ActivityDetails {
  int? id;
  String? name;
  String? date;
  String? desc;
  int? count;
  String? price;
  String? oldPrice;
  String? image;
  String? card;

  ActivityDetails({
    this.id,
    this.name,
    this.date,
    this.desc,
    this.count,
    this.price,
    this.oldPrice,
    this.image,
    this.card,
  });

  ActivityDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    date = json['date'];
    desc = json['desc'];
    count = json['count'];
    price = json['price'];
    oldPrice = json['old_price'];
    image = json['image'];
    card = json['card'];
  }
}
