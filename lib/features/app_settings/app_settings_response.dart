// class AppSettingsResponse {
//   int? status;
//   String? message;
//   Data? data;
//
//   dynamic error;
//   String? errorMsg;
//
//   AppSettingsResponse.makeError({this.error, this.errorMsg});
//   AppSettingsResponse.fromJsonError({
//     required Map<String, dynamic> json,
//     this.error,
//   }) {
//     status = json['status'];
//     message = json['message'];
//   }
//
//   AppSettingsResponse({this.status, this.message, this.data});
//
//   AppSettingsResponse.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
// }
//
// class Data {
//   Setting? setting;
//   Ads? ads;
//   String? profitsText;
//
//   Data({this.setting, this.ads, this.profitsText});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     setting =
//         json['setting'] != null ? Setting.fromJson(json['setting']) : null;
//     ads = json['ads'] != null ? Ads.fromJson(json['ads']) : null;
//     profitsText = json['profits_text'];
//   }
// }
//
// class Setting {
//   String? fixing;
//   String? version;
//   int? ads;
//
//   Setting({this.fixing, this.version, this.ads});
//
//   Setting.fromJson(Map<String, dynamic> json) {
//     fixing = json['fixing'];
//     version = json['version'];
//     ads = json['ads'];
//   }
// }
//
// class Ads {
//   String? name;
//   String? image;
//   String? link;
//
//   Ads({this.name, this.image, this.link});
//
//   Ads.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     image = json['image'];
//     link = json['link'];
//   }
// }


class AppSettingsResponse {
  int? status;
  String? message;
  Data? data;

    dynamic error;
  String? errorMsg;

  AppSettingsResponse.makeError({this.error, this.errorMsg});
  AppSettingsResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }

  AppSettingsResponse({this.status, this.message, this.data});

  AppSettingsResponse.fromJson(Map<String, dynamic> json) {
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
  Setting? setting;
  Ads? ads;
  String? profitsText;

  Data({this.setting, this.ads, this.profitsText});

  Data.fromJson(Map<String, dynamic> json) {
    setting =
    json['setting'] != null ? new Setting.fromJson(json['setting']) : null;
    ads = json['ads'] != null ? new Ads.fromJson(json['ads']) : null;
    profitsText = json['profits_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.setting != null) {
      data['setting'] = this.setting!.toJson();
    }
    if (this.ads != null) {
      data['ads'] = this.ads!.toJson();
    }
    data['profits_text'] = this.profitsText;
    return data;
  }
}

class Setting {
  String? fixing;
  String? version;
  int? ads;

  Setting({this.fixing, this.version, this.ads});

  Setting.fromJson(Map<String, dynamic> json) {
    fixing = json['fixing'];
    version = json['version'];
    ads = json['ads'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fixing'] = this.fixing;
    data['version'] = this.version;
    data['ads'] = this.ads;
    return data;
  }
}

class Ads {
  String? name;
  String? image;
  String? link;

  Ads({this.name, this.image, this.link});

  Ads.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['link'] = this.link;
    return data;
  }
}
