import 'package:flutter/material.dart';

class Calender extends StatefulWidget {
  var date;
  var day;
  var icon;
  var color;
  var colorCon;

  Calender({
    required this.date,
    required this.day,
    this.colorCon,
    this.icon,
    this.color,
  });

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Card(
        child: Container(
          margin: EdgeInsets.only(right: 5),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                height: size.height * 0.09,
                width: 50,
                decoration: BoxDecoration(
                  color: widget.colorCon,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.day,
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.date,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
