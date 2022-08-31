import 'dart:developer';

import 'package:dio/dio.dart';

class PaymentGatWay {
  static Future<PaymentGatWayResponse> paymentResponse(String url) async {
    try {
      Response response = await Dio(BaseOptions(
        contentType: 'application/json',
      )).get(url);
      log('XXxXX PaymentResponse ${response.data}');
      return PaymentGatWayResponse.fromJson(response.data);
    } on DioError catch (e) {
      log('XXxXX PaymentResponse eee response ${e.response}');
      log('XXxXX PaymentResponse eee message ${e.message}');
      log('XXxXX PaymentResponse eee error ${e.error}');
      return PaymentGatWayResponse.error(error: e);
    }
  }
}

class PaymentGatWayResponse {
  int? status;
  String? message;
  Data? data;

  dynamic error;

  PaymentGatWayResponse.error({this.error});

  PaymentGatWayResponse({this.status, this.message, this.data});

  PaymentGatWayResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? service;
  String? reservationId;
  String? date;
  String? time;
  String? paymentLink;

  Data(
      {this.service,
      this.reservationId,
      this.date,
      this.time,
      this.paymentLink});

  Data.fromJson(Map<String, dynamic> json) {
    service = json['service'];
    reservationId = json['reservation_id'];
    date = json['date'];
    time = json['time'];
    paymentLink = json['payment_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service'] = service;
    data['reservation_id'] = reservationId;
    data['date'] = date;
    data['time'] = time;
    data['payment_link'] = paymentLink;
    return data;
  }
}
