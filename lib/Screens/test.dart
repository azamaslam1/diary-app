import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  TextEditingController goal1Field = TextEditingController();
  TextEditingController goal2Field = TextEditingController();
  TextEditingController goal3Field = TextEditingController();
  TextEditingController pleasure1 = TextEditingController();
  TextEditingController pleasure2 = TextEditingController();
  TextEditingController pleasure3 = TextEditingController();
  DateTime selectedDate = DateTime.now();
  var formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  var counter = 1;

  @override
  void initState() {
    addData(formattedDate);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              InkWell(
                  onTap: () {
                    DateTime? nowFiveDaysAgo =
                        DateTime.now()?.add(Duration(days: -counter));
                    print(nowFiveDaysAgo);
                    formattedDate =
                        DateFormat('dd-MM-yyyy').format(nowFiveDaysAgo!);
                    setState(() {});

                    counter--;
                  },
                  child: Icon(Icons.arrow_back_ios)),
              Text(formattedDate),
              InkWell(
                  onTap: () {
                    DateTime? nowFiveDaysAgo =
                        DateTime.now()?.add(Duration(days: counter));
                    print(nowFiveDaysAgo);
                    formattedDate =
                        DateFormat('dd-MM-yyyy').format(nowFiveDaysAgo!);
                    setState(() {});
                    counter++;
                  },
                  child: Icon(Icons.arrow_forward_ios)),
            ],
          ),
          TextField(
            controller: goal1Field,
            onEditingComplete: () {
              print(goal1Field.text);
              FirebaseFirestore.instance
                  .collection("Test")
                  .doc("FyyzWaocYgdQ2tvLGM4Q20VH4DD3")
                  .update({
                    'weekly': [
                      {'1st': goal1Field.text, '2nd': goal2Field.text}
                    ],
                  })
                  .then((value) => print("done"))
                  .onError((error, stackTrace) => print(stackTrace));
            },
          ),
          TextField(
            controller: goal2Field,
            onEditingComplete: () {
              FirebaseFirestore.instance
                  .collection("Test")
                  .doc("FyyzWaocYgdQ2tvLGM4Q20VH4DD3")
                  .update({
                    'weekly': [
                      {'1st': goal1Field.text, '2nd': goal2Field.text}
                    ],
                  })
                  .then((value) => print("done"))
                  .onError((error, stackTrace) => print(stackTrace));
            },
          ),
          TextField(
            controller: goal3Field,
            onEditingComplete: () {
              FirebaseFirestore.instance
                  .collection("Test")
                  .doc("FyyzWaocYgdQ2tvLGM4Q20VH4DD3")
                  .update({
                    "regular": [
                      {
                        '3rd': goal3Field.text,
                        '4th': pleasure1.text,
                        '5th': pleasure2.text,
                        '6th': pleasure3,
                      }
                    ]
                  })
                  .then((value) => print("done"))
                  .onError((error, stackTrace) => print(stackTrace));
            },
          ),
          TextField(
            controller: pleasure1,
            onEditingComplete: () {
              FirebaseFirestore.instance
                  .collection("Test")
                  .doc("FyyzWaocYgdQ2tvLGM4Q20VH4DD3")
                  .update({
                    "regular": [
                      {
                        '3rd': goal3Field.text,
                        '4th': pleasure1.text,
                        '5th': pleasure2.text,
                        '6th': pleasure3,
                      }
                    ]
                  })
                  .then((value) => print("done"))
                  .onError((error, stackTrace) => print(stackTrace));
            },
          ),
          TextField(
            controller: pleasure2,
            onEditingComplete: () {
              FirebaseFirestore.instance
                  .collection("Test")
                  .doc("FyyzWaocYgdQ2tvLGM4Q20VH4DD3")
                  .update({
                    "regular": [
                      {
                        '3rd': goal3Field.text,
                        '4th': pleasure1.text,
                        '5th': pleasure2.text,
                        '6th': pleasure3,
                      }
                    ]
                  })
                  .then((value) => print("done"))
                  .onError((error, stackTrace) => print(stackTrace));
            },
          ),
          TextField(
            controller: pleasure3,
            onEditingComplete: () {
              FirebaseFirestore.instance
                  .collection("Test")
                  .doc("FyyzWaocYgdQ2tvLGM4Q20VH4DD3")
                  .update({
                    "regular": [
                      {
                        '3rd': goal3Field.text,
                        '4th': pleasure1.text,
                        '5th': pleasure2.text,
                        '6th': pleasure3,
                      }
                    ]
                  })
                  .then((value) => print("done"))
                  .onError((error, stackTrace) => print(stackTrace));
            },
          )
        ],
      ),
    );
  }

  void addData(date) {
    FirebaseFirestore.instance
        .collection("Test")
        .doc("FyyzWaocYgdQ2tvLGM4Q20VH4DD3")
        .set({
      'weekly': [
        {'1st': "", '2nd': ""}
      ],
      date: [
        {
          '3rd': '',
          '4th': '',
          '5th': '',
          '6th': '',
        }
      ]
    });
  }
}
