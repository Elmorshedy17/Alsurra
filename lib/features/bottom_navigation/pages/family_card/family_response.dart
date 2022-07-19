class FamilyCartResponse {
  int? status;
  String? message;
  Data? data;
  var error;
  String? errorMsg;

  FamilyCartResponse.makeError({this.error, this.errorMsg});
  FamilyCartResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }
  FamilyCartResponse({this.status, this.message, this.data});

  FamilyCartResponse.fromJson(Map<String, dynamic> json) {
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
  Card? card;

  Data({this.card});

  Data.fromJson(Map<String, dynamic> json) {
    card = json['card'] != null ? new Card.fromJson(json['card']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.card != null) {
      data['card'] = this.card!.toJson();
    }
    return data;
  }
}

class Card {
  int? id;
  String? name;
  String? qrCode;
  List<String>? users;

  Card({this.id, this.name, this.qrCode, this.users});

  Card.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    qrCode = json['qr_code'];
    users = json['users'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['qr_code'] = this.qrCode;
    data['users'] = this.users;
    return data;
  }
}
