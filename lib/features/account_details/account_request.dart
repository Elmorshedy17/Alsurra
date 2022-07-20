class AccountRequest {
  String? phone,password,name,email,box,civilId;

  AccountRequest({this.phone, this.password,this.email,this.name,this.box,this.civilId});

  AccountRequest.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    password = json['password'];
    name = json['name'];
    email = json['email'];
    box = json['box'];
    civilId = json['civil_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['password'] = password;
    data['name'] = name;
    data['email'] = email;
    data['box'] = box;
    data['civil_id'] = civilId;
    return data;
  }
}

