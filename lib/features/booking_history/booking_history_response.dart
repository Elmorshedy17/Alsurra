class BookingHistoryResponse {
  int? status;
  String? message;
  Data? data;

  dynamic error;
  String? errorMsg;

  BookingHistoryResponse.makeError({this.error, this.errorMsg});
  BookingHistoryResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  BookingHistoryResponse({this.status, this.message, this.data});

  BookingHistoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  Bookings? bookings;

  Data({this.bookings});

  Data.fromJson(Map<String, dynamic> json) {
    bookings =
        json['bookings'] != null ? Bookings.fromJson(json['bookings']) : null;
  }
}

class Bookings {
  List<BookingData>? playgrounds;
  List<BookingData>? chalets;
  List<BookingData>? hotels;
  List<BookingData>? courses;
  List<BookingData>? offres;
  List<BookingData>? disounts;
  List<BookingData>? activities;
  List<BookingData>? all;

  Bookings(
      {this.playgrounds,
      this.chalets,
      this.hotels,
      this.courses,
      this.offres,
      this.disounts,
      this.activities,
      this.all});

  Bookings.fromJson(Map<String, dynamic> json) {
    if (json['playgrounds'] != null) {
      playgrounds = <BookingData>[];
      json['playgrounds'].forEach((v) {
        playgrounds!.add(BookingData.fromJson(v));
      });
    }
    if (json['chalets'] != null) {
      chalets = <BookingData>[];
      json['chalets'].forEach((v) {
        chalets!.add(BookingData.fromJson(v));
      });
    }
    if (json['hotels'] != null) {
      hotels = <BookingData>[];
      json['hotels'].forEach((v) {
        hotels!.add(BookingData.fromJson(v));
      });
    }
    if (json['courses'] != null) {
      courses = <BookingData>[];
      json['courses'].forEach((v) {
        courses!.add(BookingData.fromJson(v));
      });
    }
    if (json['offres'] != null) {
      offres = <BookingData>[];
      json['offres'].forEach((v) {
        offres!.add(BookingData.fromJson(v));
      });
    }
    if (json['disounts'] != null) {
      disounts = <BookingData>[];
      json['disounts'].forEach((v) {
        disounts!.add(BookingData.fromJson(v));
      });
    }
    if (json['activities'] != null) {
      activities = <BookingData>[];
      json['activities'].forEach((v) {
        activities!.add(BookingData.fromJson(v));
      });
    }
    if (json['all'] != null) {
      all = <BookingData>[];
      json['all'].forEach((v) {
        all!.add(BookingData.fromJson(v));
      });
    }
  }
}

class BookingData {
  int? id;
  String? title;
  String? date;
  String? time;
  String? option;
  int? count;
  String? price;
  String? qrCode;

  BookingData(
      {this.id,
      this.title,
      this.date,
      this.time,
      this.option,
      this.count,
      this.price,
      this.qrCode});

  BookingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
    time = json['time'];
    option = json['option'];
    count = json['count'];
    price = json['price'];
    qrCode = json['qr_code'];
  }
}
