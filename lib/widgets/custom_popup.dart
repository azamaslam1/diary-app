import 'package:flutter/material.dart';
import 'package:personal_dairy/utils/constants.dart';

class CustomPopup extends StatefulWidget {
  final list;

  const CustomPopup({this.list});

  @override
  State<CustomPopup> createState() => _CustomPopupState();
}

class _CustomPopupState extends State<CustomPopup> {
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding:
          EdgeInsets.only(left: size.width * 0.35, bottom: size.height * 0.55),
      child: Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)), //this right here
        child: Container(
            height: 140.0,
            width: 300.0,
            child: ListView.builder(
              itemCount: widget.list.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(widget.list[i]),
                );
              },
            )),
      ),
    );
  }

  Widget getRow(icn, text, size) {
    return Row(
      children: [
        Icon(
          icn,
          color: colorHeader,
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          "$text",
          style: TextStyle(color: colorHeader, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
