import 'package:flutter/material.dart';
import 'package:listacontatos/repositories/contact_repository.dart';
import 'package:listacontatos/widgets/card_label.dart';

import '../models/contact_model.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  var nameController = TextEditingController(text: "");
  var phoneNumberController = TextEditingController(text: "");
  var photoPathController = TextEditingController(text: "");

  var contactRepository = ContactRepository();

  var _contacts = ContactsModel([]);

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    _contacts = await contactRepository.obtainContacts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Contatos"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          nameController.text = "";
          phoneNumberController.text = "";
          photoPathController.text = "";
          showDialog(
              context: context,
              builder: (BuildContext bc) {
                return AlertDialog(
                  title: const Text("Adicionar Contato"),
                  content: Wrap(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Nome"),
                          TextField(
                            controller: nameController,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text("Número"),
                          TextField(
                            controller: phoneNumberController,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text("Photo Path"),
                          TextField(
                            controller: photoPathController,
                          ),
                        ],
                      )
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          contactRepository.create(
                              nameController.text,
                              phoneNumberController.text,
                              photoPathController.text);
                          Navigator.pop(context);
                          loadData();
                        },
                        child: const Text("Salvar"))
                  ],
                );
              });
        },
      ),
      body: ListView.builder(
          itemCount: _contacts.contacts.length,
          itemBuilder: (BuildContext bc, int index) {
            var contact = _contacts.contacts[index];
            return Dismissible(
                onDismissed: (DismissDirection dismissDirection) async {
                  await contactRepository.delete(contact.objectId);
                  loadData();
                },
                key: Key(contact.objectId),
                child: CardLabel(
                    image: contact.photoPath,
                    phoneNumber: contact.phoneNumber,
                    name: contact.name));
          }),
    ));
  }
}
