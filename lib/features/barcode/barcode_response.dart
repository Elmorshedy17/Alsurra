class BarcodeResponse {
  int? status;
  String? message;

  dynamic error;
  String? errorMsg;

  BarcodeResponse.makeError({this.error, this.errorMsg});
  BarcodeResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  BarcodeResponse({this.status, this.message});

  BarcodeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
