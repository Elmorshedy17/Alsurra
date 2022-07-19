class ReportProductRequest {
  String? name,phone,product,branch,message;

  ReportProductRequest({this.phone, this.name,this.product,this.message,this.branch});

  ReportProductRequest.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    name = json['name'];
    product = json['product'];
    branch = json['branch'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['name'] = name;
    data['product'] = product;
    data['branch'] = branch;
    data['message'] = message;
    return data;
  }
}

