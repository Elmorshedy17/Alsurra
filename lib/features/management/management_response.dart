

class ManagementResponse {
  int? status;
  String? message;
  Data? data;
  dynamic error;
  String? errorMsg;

  ManagementResponse.makeError({this.error, this.errorMsg});
  ManagementResponse.fromJsonError({
    required Map<String, dynamic> json,
    this.error,
  }) {
    status = json['status'];
    message = json['message'];
  }
  ManagementResponse({this.status, this.message, this.data});

  ManagementResponse.fromJson(Map<String, dynamic> json) {
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
  List<Members>? members;

  Data({this.members});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(new Members.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.members != null) {
      data['members'] = this.members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Members {
  int? id;
  String? name;
  String? job;
  String? special;
  String? image;

  Members({this.id, this.name, this.job, this.special, this.image});

  Members.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    job = json['job'];
    special = json['special'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['job'] = this.job;
    data['special'] = this.special;
    data['image'] = this.image;
    return data;
  }
}
