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
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  Playground? playground;

  Data({this.playground});

  Data.fromJson(Map<String, dynamic> json) {
    playground = json['playground'] != null
        ? Playground.fromJson(json['playground'])
        : null;
  }
}

class Playground {
  int? id;
  String? name;
  String? game;
  String? desc;
  String? price;
  String? image;
  StartAndEndTimes? sat;
  StartAndEndTimes? sun;
  StartAndEndTimes? mon;
  StartAndEndTimes? tue;
  StartAndEndTimes? wed;
  StartAndEndTimes? thu;
  StartAndEndTimes? fri;

  Playground(
      {this.id,
      this.name,
      this.game,
      this.desc,
      this.price,
      this.image,
      this.sat,
      this.sun,
      this.mon,
      this.tue,
      this.wed,
      this.thu,
      this.fri});

  Playground.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    game = json['game'];
    desc = json['desc'];
    price = json['price'];
    image = json['image'];
    sat = json['sat'] != null ? StartAndEndTimes.fromJson(json['sat']) : null;
    sun = json['sun'] != null ? StartAndEndTimes.fromJson(json['sun']) : null;
    mon = json['mon'] != null ? StartAndEndTimes.fromJson(json['mon']) : null;
    tue = json['tue'] != null ? StartAndEndTimes.fromJson(json['tue']) : null;
    wed = json['wed'] != null ? StartAndEndTimes.fromJson(json['wed']) : null;
    thu = json['thu'] != null ? StartAndEndTimes.fromJson(json['thu']) : null;
    fri = json['fri'] != null ? StartAndEndTimes.fromJson(json['fri']) : null;
  }
}

class StartAndEndTimes {
  String? start;
  String? end;

  StartAndEndTimes({this.start, this.end});

  StartAndEndTimes.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
  }
}
