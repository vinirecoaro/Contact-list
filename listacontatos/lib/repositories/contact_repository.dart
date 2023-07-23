import 'package:listacontatos/repositories/custon_back4app_dio.dart';

import '../models/contact_model.dart';

class ContactRepository {
  Future<ContactsModel> obtainContacts() async {
    var custonDio = CustonDio();
    var result = await custonDio.dio
        .get("https://parseapi.back4app.com/classes/contats");
    return ContactsModel.fromJson(result.data);
  }

  Future<void> create(String name, String phoneNumber, String photoPath) async {
    var custonDIo = CustonDio();
    var contactModel = ContactModel.create(name, phoneNumber, photoPath);
    try {
      await custonDIo.dio.post("https://parseapi.back4app.com/classes/contats",
          data: contactModel.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(String objectId) async {
    var custonDio = CustonDio();
    try {
      await custonDio.dio
          .delete("https://parseapi.back4app.com/classes/contats/$objectId");
    } catch (e) {
      rethrow;
    }
  }
}
