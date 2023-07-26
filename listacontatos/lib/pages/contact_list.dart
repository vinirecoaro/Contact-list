import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:listacontatos/repositories/contact_repository.dart';
import 'package:listacontatos/widgets/card_label.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';

import '../models/contact_model.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  var nameController = TextEditingController(text: "");
  var phoneNumberController = TextEditingController(text: "");
  String photoPathController = "";

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

  XFile? photo;

  cropImage(XFile imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      await GallerySaver.saveImage(croppedFile.path);
      photo = XFile(croppedFile.path);
      setState(() {});
    }
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
          photoPathController = "";
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
                          const Text("Adicionar foto do contato"),
                          const SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            child: const Icon(
                              Icons.camera_alt_sharp,
                              size: 40,
                            ),
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              photo = await picker.pickImage(
                                  source: ImageSource.camera);
                              if (photo != null) {
                                String path = (await path_provider
                                        .getApplicationDocumentsDirectory())
                                    .path;
                                String name = basename(photo!.path);
                                photoPathController = "$path/$name";
                                await photo!.saveTo(photoPathController);
                                await GallerySaver.saveImage(photo!.path);
                                cropImage(photo!);
                                //setState(() {});
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          contactRepository.create(nameController.text,
                              phoneNumberController.text, photoPathController);
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
                    photoPath: contact.photoPath,
                    phoneNumber: contact.phoneNumber,
                    name: contact.name));
          }),
    ));
  }
}
