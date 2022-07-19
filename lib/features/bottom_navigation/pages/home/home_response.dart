class HomeResponse {
  int? status;
  String? message;
  Data? data;

  dynamic error;
  String? errorMsg;

  HomeResponse.makeError({this.error, this.errorMsg});
  HomeResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  HomeResponse({this.status, this.message, this.data});

  HomeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<SliderService>? slider;

  Data({this.slider});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['slider'] != null) {
      slider = <SliderService>[];
      json['slider'].forEach((v) {
        slider!.add(SliderService.fromJson(v));
      });
    }
  }
}

class SliderService {
  int? id;
  String? name;
  String? image;
  String? link;

  SliderService({this.id, this.name, this.image, this.link});

  SliderService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    link = json['link'];
  }
}
