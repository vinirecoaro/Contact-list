import 'package:flutter/material.dart';

class CardLabel extends StatefulWidget {
  final String image;
  final String phoneNumber;
  final String name;
  const CardLabel(
      {super.key,
      required this.image,
      required this.phoneNumber,
      required this.name});

  @override
  State<CardLabel> createState() => _CardLabelState();
}

class _CardLabelState extends State<CardLabel> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.people,
                  size: 75,
                )
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.name),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(widget.phoneNumber),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
