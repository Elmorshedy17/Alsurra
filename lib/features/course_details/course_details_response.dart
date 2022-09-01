class CourseDetailsResponse {
  int? status;
  String? message;
  Data? data;

  dynamic error;
  String? errorMsg;

  CourseDetailsResponse.makeError({this.error, this.errorMsg});
  CourseDetailsResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }
  CourseDetailsResponse({this.status, this.message, this.data});

  CourseDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  CourseDetails? courseDetails;

  Data({this.courseDetails});

  Data.fromJson(Map<String, dynamic> json) {
    courseDetails =
        json['course'] != null ? CourseDetails.fromJson(json['course']) : null;
  }
}

class CourseDetails {
  int? id;
  String? name;
  String? date;
  String? desc;
  int? count;
  String? price;
  String? oldPrice;
  String? image;
  String? category;
  String? card;

  CourseDetails(
      {this.id,
      this.name,
      this.date,
      this.desc,
      this.count,
      this.category,
      this.price,
      this.oldPrice,
      this.card,
      this.image});

  CourseDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    date = json['date'];
    desc = json['desc'];
    count = json['count'];
    price = json['price'];
    image = json['image'];
    category = json['category'];
    oldPrice = json['old_price'];
    card = json['card'];
  }
}
