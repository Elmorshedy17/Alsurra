

class BranchesResponse {
  int? status;
  String? message;
  Data? data;
  dynamic error;
  String? errorMsg;

  BranchesResponse.makeError({this.error, this.errorMsg});
  BranchesResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }
  BranchesResponse({this.status, this.message, this.data});

  BranchesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Branches>? branches;

  Data({this.branches});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['branches'] != null) {
      branches = <Branches>[];
      json['branches'].forEach((v) {
        branches!.add(Branches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (branches != null) {
      data['branches'] = branches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Branches {
  String? name;
  String? address;
  String? work;
  String? phone;
  String? fax;
  String? lat;
  String? lng;

  Branches(
      {this.name,
        this.address,
        this.work,
        this.phone,
        this.fax,
        this.lat,
        this.lng});

  Branches.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    work = json['work'];
    phone = json['phone'];
    fax = json['fax'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['address'] = address;
    data['work'] = work;
    data['phone'] = phone;
    data['fax'] = fax;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Branches &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          address == other.address &&
          work == other.work &&
          phone == other.phone &&
          fax == other.fax &&
          lat == other.lat &&
          lng == other.lng;

  @override
  int get hashCode =>
      name.hashCode ^
      address.hashCode ^
      work.hashCode ^
      phone.hashCode ^
      fax.hashCode ^
      lat.hashCode ^
      lng.hashCode;
}
