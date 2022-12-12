import 'package:flutter/material.dart';
import 'package:personal_dairy/utils/constants.dart';

class ImageCustom extends StatefulWidget {
  final link;

  const ImageCustom({Key? key, this.link}) : super(key: key);

  @override
  State<ImageCustom> createState() => _ImageCustomState();
}

class _ImageCustomState extends State<ImageCustom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorHeader,
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          centerTitle: true,
          title: Text("Image"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.link,
          ],
        ));
  }
}
