import 'package:flutter/material.dart';
import 'package:listacontatos/repositories/contact_repository.dart';

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
                        },
                        child: const Text("Salvar"))
                  ],
                );
              });
        },
      ),
    ));
  }
}
