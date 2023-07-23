class ContactModel {
  List<Results>? results;

  ContactModel({this.results});

  ContactModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? objectId;
  String? name;
  String? phoneNumber;
  String? photoPath;
  String? createdAt;
  String? updatedAt;

  Results(
      {this.objectId,
      this.name,
      this.phoneNumber,
      this.photoPath,
      this.createdAt,
      this.updatedAt});

  Results.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    photoPath = json['photo_path'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['objectId'] = this.objectId;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['photo_path'] = this.photoPath;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
