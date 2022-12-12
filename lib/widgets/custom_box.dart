import 'package:flutter/material.dart';
import 'package:personal_dairy/utils/constants.dart';

var isChecked = false;

class CustomBox extends StatefulWidget {
  final title;
  final trailing;
  final lead;
  final color;
  final icon2;

  const CustomBox(
      {Key? key, this.title, this.trailing, this.lead, this.color, this.icon2})
      : super(key: key);

  @override
  State<CustomBox> createState() => _CustomBoxState();
}

class _CustomBoxState extends State<CustomBox> {
  var isChecked = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
          left: size.width * 0.01,
          right: size.width * 0.01,
          top: size.height * 0.005),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Card(
          elevation: 2.0,
          child: Container(
            width: size.width,
            height: size.height * 0.18,
            child: Column(
              children: [
                getTitle("icon", widget.title, size, widget.icon2),
                SizedBox(
                  height: (widget.icon2 == null)
                      ? size.height * 0.031
                      : size.height * 0.036,
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.062,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                      color: colorHeader),
                  child: getTitleCon(
                      Icons.sync, widget.lead, size, widget.trailing),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getTitle(
    icon,
    text,
    size,
    icon2,
  ) {
    return Padding(
      padding: EdgeInsets.only(
          left: size.width * 0.03,
          right: size.width * 0.03,
          top: size.height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              (icon2 == null)
                  ? InkWell(
                      onTap: () {
                        if (isChecked == true) {
                          isChecked = false;
                        } else {
                          isChecked = true;
                        }
                        setState(() {});
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: colorHeader),
                              borderRadius: BorderRadius.circular(10.0),
                              shape: BoxShape.rectangle,
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: isChecked
                                ? Icon(
                                    Icons.check,
                                    size: 30.0,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.check,
                                    size: 30.0,
                                    color: Colors.blue,
                                  ),
                          )),
                    )
                  : Image.asset(
                      icon2,
                      width: size.width * 0.12,
                    ),
              SizedBox(
                width: 15.0,
              ),
              Text(
                '$text',
                style: TextStyle(
                    color: widget.color,
                    fontSize: size.width * 0.045,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Icon(
            Icons.more_horiz,
            color: Colors.grey,
            size: size.width * 0.08,
          ),
        ],
      ),
    );
  }

  getTitleCon(icon, text, size, text2) {
    return Padding(
      padding: EdgeInsets.only(
          left: size.width * 0.03,
          right: size.width * 0.03,
          top: size.height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: bgColor,
                size: size.width * 0.08,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                '$text',
                style: TextStyle(
                    color: bgColor,
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text(
            '$text2',
            style: TextStyle(color: Colors.white, fontSize: size.width * 0.04),
          ),
        ],
      ),
    );
  }
}
