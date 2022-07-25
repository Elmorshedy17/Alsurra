class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  // String? card;
  String? authorization;
  String? box;
  String? civilId;

  User(
      {this.id,
        this.name,
        this.email,
        this.phone,
        // this.card,
        this.box,
        this.civilId,
        this.authorization});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    // card = json['card'];
    box = json['box'];
    authorization = json['authorization'];
    civilId = json['civil_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    // data['card'] = card;
    data['box'] = box;
    data['authorization'] = authorization;
    data['civil_id'] = civilId;
    return data;
  }
}
