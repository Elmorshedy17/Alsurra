class PlaygroundDetailsResponse {
  int? status;
  String? message;
  Data? data;
  dynamic error;
  String? errorMsg;

  PlaygroundDetailsResponse.makeError({this.error, this.errorMsg});
  PlaygroundDetailsResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  PlaygroundDetailsResponse({this.status, this.message, this.data});

  PlaygroundDetailsResponse.fromJson(Map<String, dynamic> json) {
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
  Playground? playground;

  Data({this.playground});

  Data.fromJson(Map<String, dynamic> json) {
    playground = json['playground'] != null
        ? new Playground.fromJson(json['playground'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.playground != null) {
      data['playground'] = this.playground!.toJson();
    }
    return data;
  }
}

class Playground {
  int? id;
  String? name;
  String? game;
  String? desc;
  String? price;
  String? image;
  List<String>? fri;
  List<String>? thu;
  List<String>? wed;
  List<String>? tue;
  List<String>? mon;
  List<String>? sun;
  List<String>? sat;

  Playground(
      {this.id,
        this.name,
        this.game,
        this.desc,
        this.price,
        this.image,
        this.fri,
        this.thu,
        this.wed,
        this.tue,
        this.mon,
        this.sun,
        this.sat});

  Playground.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    game = json['game'];
    desc = json['desc'];
    price = json['price'];
    image = json['image'];
    fri = json['fri'].cast<String>();
    thu = json['thu'].cast<String>();
    wed = json['wed'].cast<String>();
    tue = json['tue'].cast<String>();
    mon = json['mon'].cast<String>();
    sun = json['sun'].cast<String>();
    sat = json['sat'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['game'] = this.game;
    data['desc'] = this.desc;
    data['price'] = this.price;
    data['image'] = this.image;
    data['fri'] = this.fri;
    data['thu'] = this.thu;
    data['wed'] = this.wed;
    data['tue'] = this.tue;
    data['mon'] = this.mon;
    data['sun'] = this.sun;
    data['sat'] = this.sat;
    return data;
  }
}

