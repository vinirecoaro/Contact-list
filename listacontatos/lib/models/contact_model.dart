class ContactsModel {
  List<ContactModel>? contacts;

  ContactsModel({this.contacts});

  ContactsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      contacts = <ContactModel>[];
      json['results'].forEach((v) {
        contacts!.add(ContactModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (contacts != null) {
      data['results'] = contacts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContactModel {
  String objectId = "";
  String name = "";
  String phoneNumber = "";
  String photoPath = "";
  String createdAt = "";
  String updatedAt = "";

  ContactModel(this.objectId, this.name, this.phoneNumber, this.photoPath,
      this.createdAt, this.updatedAt);

  ContactModel.empty();

  ContactModel.create(this.name, this.phoneNumber, this.photoPath);

  ContactModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    photoPath = json['photo_path'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['photo_path'] = photoPath;
    return data;
  }
}
