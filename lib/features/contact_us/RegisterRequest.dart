class ContactUsRequest {
  String? message,name,email,phone;

  ContactUsRequest({this.message,this.name,this.email,this.phone});

  ContactUsRequest.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['message'] = message;
    return data;
  }
}

