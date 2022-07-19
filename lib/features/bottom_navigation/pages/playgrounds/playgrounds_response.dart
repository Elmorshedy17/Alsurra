class PlaygroundsResponse {
  int? status;
  String? message;
  Data? data;

  dynamic error;
  String? errorMsg;

  PlaygroundsResponse.makeError({this.error, this.errorMsg});
  PlaygroundsResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  PlaygroundsResponse({this.status, this.message, this.data});

  PlaygroundsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<Playground>? playgrounds;
  Info? info;

  Data({this.playgrounds, this.info});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['playgrounds'] != null) {
      playgrounds = <Playground>[];
      json['playgrounds'].forEach((v) {
        playgrounds!.add(Playground.fromJson(v));
      });
    }
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
  }
}

class Playground {
  int? id;
  String? name;
  String? desc;
  String? price;
  String? image;

  Playground({this.id, this.name, this.desc, this.price, this.image});

  Playground.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    price = json['price'];
    image = json['image'];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Playground &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          desc == other.desc &&
          price == other.price &&
          image == other.image;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      desc.hashCode ^
      price.hashCode ^
      image.hashCode;
}

class Info {
  int? currentPage;
  String? firstPageUrl;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Info(
      {this.currentPage,
      this.firstPageUrl,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Info.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    firstPageUrl = json['first_page_url'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}
