class BookingResponse {
  int? status;
  String? message;
  Data? data;

  dynamic error;
  String? errorMsg;

  BookingResponse.makeError({this.error, this.errorMsg});
  BookingResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  BookingResponse({this.status, this.message, this.data});

  BookingResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? url;

  Data({this.url});

  Data.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }
}
