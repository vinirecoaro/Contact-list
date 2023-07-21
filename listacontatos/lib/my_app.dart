import 'package:flutter/material.dart';
import 'package:listacontatos/pages/contact_list.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            colorSchemeSeed: Colors.black,
            textTheme: Typography.blackCupertino),
        debugShowCheckedModeBanner: false,
        home: const ContactList());
  }
}
