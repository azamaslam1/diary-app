import 'package:flutter/material.dart';
import 'package:personal_dairy/main.dart';
import 'package:personal_dairy/utils/constants.dart';

var languageSelected = "English";

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({Key? key}) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  List languages = [
    Item(
        'English',
        Image.asset(
          'assets/english.png',
          width: 40.0,
        )),
    Item(
        'Slovak',
        Image.asset(
          'assets/english.png',
          width: 40.0,
        )),
    Item(
        'Czech',
        Image.asset(
          'assets/english.png',
          width: 40.0,
        )),
  ];

  @override
  Widget build(BuildContext context) {
    var selectedLanguage = languages[0];

    var size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(
          left: size.width * 0.03,
          right: size.width * 0.03,
          top: size.height * 0.015,
          bottom: size.height * 0.015),
      padding: EdgeInsets.only(
          left: size.width * 0.03,
          right: size.width * 0.03,
          top: size.height * 0.015,
          bottom: size.height * 0.015),
      decoration: BoxDecoration(
          border: Border.all(color: colorHeader),
          borderRadius: BorderRadius.circular(10.0)),
      width: size.width,
      height: size.height * 0.075,
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          icon: Icon(Icons.keyboard_arrow_down_outlined),
          iconSize: 24,
          elevation: 16,
          value: selectedLanguage,
          isExpanded: true,
          items: languages.map((languages) {
            return DropdownMenuItem(
              value: languages,
              child: Row(
                children: [
                  languages.icon,
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    languages.name,
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (languages.indexOf(value) == 0) {
              print(language);
              language = "English";
              setState(() {});
            } else if (languages.indexOf(value) == 1) {
              language = "Slovak";
              setState(() {});
            } else if (languages.indexOf(value) == 2) {
              language = "Czech";
              setState(() {});
            }
            setState(() {});
            setState(() {
              selectedLanguage = value;
            });
          },
        ),
      ),
    );
  }
}

class Item {
  Item(this.name, this.icon);

  final String name;
  var icon;
}
