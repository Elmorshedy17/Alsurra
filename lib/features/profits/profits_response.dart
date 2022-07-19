


class ProfitsResponse {
  int? status;
  String? message;
  Data? data;
  var error;
  String? errorMsg;

  ProfitsResponse.makeError({this.error, this.errorMsg});
  ProfitsResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }
  ProfitsResponse({this.status, this.message, this.data});

  ProfitsResponse.fromJson(Map<String, dynamic> json) {
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
  Profit? profit;

  Data({this.profit});

  Data.fromJson(Map<String, dynamic> json) {
    profit =
    json['profit'] != null ? new Profit.fromJson(json['profit']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profit != null) {
      data['profit'] = this.profit!.toJson();
    }
    return data;
  }
}

class Profit {
  String? box;
  String? name;
  String? civilId;
  String? amount;

  Profit({this.box, this.name, this.civilId, this.amount});

  Profit.fromJson(Map<String, dynamic> json) {
    box = json['box'];
    name = json['name'];
    civilId = json['civil_id'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['box'] = this.box;
    data['name'] = this.name;
    data['civil_id'] = this.civilId;
    data['amount'] = this.amount;
    return data;
  }
}

