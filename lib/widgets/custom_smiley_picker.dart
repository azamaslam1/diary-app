// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/new_main.dart';
import '../utils/constants.dart';
import 'header.dart';

var lengthIndex = 0;

class CustomSmileyPicker extends StatefulWidget {
  const CustomSmileyPicker({Key? key}) : super(key: key);

  @override
  State<CustomSmileyPicker> createState() => _CustomSmileyPickerState();
}

class _CustomSmileyPickerState extends State<CustomSmileyPicker> {
  var days = ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'];
  var icons = ['Terrible', 'Bad', 'Okay', 'Good', 'Great'];
  List feeling = [];
  int feel0 = 0, feel1 = 0, feel2 = 0, feel3 = 0, feel4 = 0;
  List<String> dayslist = [
    "00",
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09"
  ];
  var months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  var monthDays = [
    '31',
    '28',
    '31',
    '30',
    '31',
    '30',
    '31',
    '31',
    '30',
    '31',
    '30',
    '31'
  ];
  var month;

  void initializeDate() async {
    DateTime selectedDate = DateTime.now();
    // formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    // formattedDateHeader = DateFormat('dd-MM-yyyy').format(DateTime.now());
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('dateMonth', "$selectedDate");
    // month=DateFormat.MMMM().format(DateTime.now());
    setState(() {});
  }

  var monthSele;
  var counter = 0;
  var counterNext = 1;
  User? userr = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    initializeDate();
    formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

    monthSele = selecteddate.toString().substring(5, 7);

    month = months[11];
    getdata(userr?.uid, monthSele);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Card(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0), color: bgColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: size.width * 0.03, right: size.width * 0.1),
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.arrow_back)),
                          Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20))),
                            child: InkWell(
                              onTap: () async {
                                if (counter > 11 || counter == -1) {
                                  print("ind");
                                  counter = 12;
                                }
                                month = months[counter];
                                lengthIndex = months.indexOf(month);

                                setState(() {});

                                counter--;

                                print(month);
                                getdata(userr?.uid, month);

                                setState(() {});
                              },
                              child: CircleAvatar(
                                radius: size.width * 0.05,
                                backgroundColor: bgColor,
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: colorHeader,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: size.height * 0.0),
                            child: Text(
                              "$month",
                              style: TextStyle(
                                  fontSize: size.width * 0.06,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0),
                            ),
                          ),
                          Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20))),
                            child: InkWell(
                              onTap: () async {
                                if (counter > 11 || counter == -1) {
                                  print("ind");
                                  counter = 0;
                                }
                                print(counter);
                                month = months[counter];
                                lengthIndex = months.indexOf(month);
                                setState(() {});
                                print(counter);

                                counter++;

                                print("thi sis month $month");
                                setState(() {});
                                print(int.parse(monthDays[lengthIndex]));
                                getdata(userr?.uid, month);
                              },
                              child: CircleAvatar(
                                radius: size.width * 0.05,
                                backgroundColor: bgColor,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: colorHeader,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Card(
                        elevation: 3.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: size.height * 0.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                getCircleButton(
                                    Image.asset("assets/emoji/terribel.png"),
                                    size,
                                    feel0.toString(),
                                    "rate"),
                                getCircleButton(
                                    Image.asset("assets/emoji/sad.png"),
                                    size,
                                    feel1.toString(),
                                    "rate"),
                                getCircleButton(
                                    Image.asset("assets/emoji/okay.png"),
                                    size,
                                    feel2.toString(),
                                    "rate"),
                                getCircleButton(
                                    Image.asset("assets/emoji/good.png"),
                                    size,
                                    feel3.toString(),
                                    "rate"),
                                getCircleButton(
                                    Image.asset("assets/emoji/great.png"),
                                    size,
                                    feel4.toString(),
                                    "rate"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    getSmileysContainer(size, int.parse(monthDays[lengthIndex]))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  late String formattedDate;

  Future<void> addfeel(
      String year, String month, int val, String day, String uid) async {
    // EasyLoading.show();

    try {
      await FirebaseFirestore.instance
          .collection("feelings")
          .doc(uid)
          .collection(year)
          .doc(month)
          // .doc("1")

          .update({day: val});
      setState(() {});
    } on FirebaseException catch (e) {
      print(e);
      await FirebaseFirestore.instance
          .collection("feelings")
          .doc(uid)
          .collection(year)
          .doc(month)
          .set({day: val}).then((value) async {
        print(int.parse(monthDays[lengthIndex]));
        for (int i = 1; i <= int.parse(monthDays[lengthIndex]); i++) {
          print("object day and i$day==$i");

          if (day.toString() == i.toString()) {
            print("object same");
            continue;
          } else if (i <= 9) {
            print("object day and daylist$day==${dayslist[i]}");
            // print(dayslist[i]);
            if (day == dayslist[i]) {
              continue;
            }
            print("dayslist$i fff${dayslist[i]}");
            print("i$i");
            print("addss $i");

            await FirebaseFirestore.instance
                .collection("feelings")
                .doc(uid)
                .collection(year)
                .doc(month)
                .update({
              dayslist[i]: -1,
              // "skip":day == dayslist[i]?val:"-1"
            });
          } else {
            print("add $i");
            await FirebaseFirestore.instance
                .collection("feelings")
                .doc(uid)
                .collection(year)
                .doc(month)
                .update({i.toString(): -1});
          }
          EasyLoading.dismiss();
          setState(() {});
        }
      });
    }
  }

  getdata(var uid, String monthh) async {
    print("object $monthh");
    feeling = [];
    int days;
    List<String> dayslist = [
      "01",
      "02",
      "03",
      "04",
      "05",
      "06",
      "07",
      "08",
      "09"
    ];
    switch (monthh) {
      case "January":
        {
          monthh = "01";
          days = 31;
        }
        break;

      case "February":
        {
          monthh = "02";
          days = 28;
        }
        break;

      case "March":
        {
          monthh = "03";
          days = 31;
        }
        break;

      case "April":
        {
          monthh = "04";
          days = 30;
        }
        break;
      case "May":
        {
          monthh = "05";
          days = 31;
        }
        break;
      case "June":
        {
          monthh = "06";
          days = 30;
        }
        break;
      case "July":
        {
          monthh = "07";
          days = 31;
        }
        break;
      case "August":
        {
          monthh = "08";
          days = 31;
        }
        break;
      case "September":
        {
          monthh = "09";
          days = 30;
        }
        break;
      case "October":
        {
          monthh = "10";
          days = 31;
        }
        break;
      case "November":
        {
          monthh = "11";
          days = 30;
        }
        break;

      default:
        {
          monthh = "12";
          days = 31;
          print("Invalid choice");
        }
        break;
    }
    User? userr = FirebaseAuth.instance.currentUser;

    print("object month$monthh");

    var year = selecteddate.toString().substring(0, 4);
    // var month = selecteddate.toString().substring(5, 7);
    var day = selecteddate.toString().substring(8, 10);

    await FirebaseFirestore.instance
        .collection("feelings")
        .doc(userr?.uid)
        .collection("$year")
        .doc(monthh)
        .get()
        .then((value) {
      print("object $value");

      DocumentSnapshot data = value;
      print("object ${data.exists}");
      feeling.clear();
      if (value.exists == true) {
        print("objectdataa${data[dayslist[1 - 1]]}");
        feeling.clear();
        for (int i = 1; i <= days; i++) {
          if (i <= 9) {
            print("object i and daylist$i==${dayslist[i - 1]}");
            print("objectdataa${data[dayslist[i - 1]]}");

            feeling.add(data[dayslist[i - 1]]);
          } else {
            print("objecttt $i ");
            print(data[i.toString()]);
            feeling.add(data[i.toString()]);
          }
        }
        setState(() {});
      } else {
        for (int i = 1; i <= days; i++) {
          feeling.add(-1);
        }
        setState(() {});
      }
      feel0 = 0;
      feel1 = 0;
      feel2 = 0;
      feel3 = 0;
      feel4 = 0;
      for (int i = 0; i < feeling.length; i++) {
        if (feeling[i] == 0) {
          feel0++;
        } else if (feeling[i] == 1) {
          feel1++;
        } else if (feeling[i] == 2) {
          feel2++;
        } else if (feeling[i] == 3) {
          feel3++;
        } else if (feeling[i] == 4) {
          feel4++;
        }
      }

      setState(() {});
      print("object1 list $feeling");
      // print("object1 ${data["01"]}");
    });
  }

  Future<void> getdata2({
    required String Date,
  }) async {
    EasyLoading.show();
    print("Date $Date");
    try {
      await FirebaseFirestore.instance
          .collection("${userr?.uid}")
          .doc(Date.toString())
          .get()
          .then((value) {
        print(value);

        print("dataaa${value.exists}");
        if (value.exists == false) {
          print("Empty");
          print("Empty");
          datacheck = false;
          goal1Field.clear();
          goal2Field.clear();
          goal3Field.clear();
          pleasure1.clear();
          pleasure2.clear();
          pleasure3.clear();
          gratitude1.clear();
          gratitude2.clear();
          gratitude3.clear();
          morningRitual.clear();
          eveRitual.clear();
          priorityController.clear();

          success1.clear();
          success2.clear();
          success3.clear();
          howwasmyday.clear();
          whatwouldido.clear();
          personalNumber.clear();
          businessNumber.clear();

          priorityController.clear();
          program1.clear();
          program2.clear();
          program3.clear();

          habitController.clear();
          datee = formattedDate;

          EasyLoading.dismiss();
        } else {
          DocumentSnapshot data = value;
          datacheck = true;
          datee = formattedDate;
          dateSel = DateTime.now();

          print(data);

          goal1Field.text = data["goalofweek1"];
          goal2Field.text = data["goalofweek2"];
          goal3Field.text = data["goalofweek3"];
          pleasure1.text = data["pleasureofweek1"];
          pleasure2.text = data["pleasureofweek2"];
          pleasure3.text = data["pleasureofweek3"];
          gratitude1.text = data["Gratitiude1"];
          gratitude2.text = data["Gratitiude2"];
          gratitude3.text = data["Gratitiude3"];
          morningRitual.text = data["ritualmorning"];
          eveRitual.text = data["ritualevening"];
          priorityController.text = data["Priority"];
          success1.text = data["success1"];
          success2.text = data["success2"];
          success3.text = data["success3"];
          howwasmyday.text = data["learning1"];
          whatwouldido.text = data["learning2"];
          personalNumber.text = data["financenumber"];
          businessNumber.text = data["financebusiness"];
          habitController.text = data["habitofweek"];

          program1.text = data["Todays_program1"];
          program2.text = data["Todays_program2"];
          program3.text = data["Todays_program3"];

          EasyLoading.dismiss();
        }
        // print(data["goalofweek"]);
      });
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  getPercent() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var date = sharedPreferences.getString('date');

    var result = [];
    var data = [
      goal1Field.text,
      goal2Field.text,
      goal3Field.text,
      pleasure1.text,
      pleasure2.text,
      pleasure3.text,
      gratitude1.text,
      gratitude2.text,
      gratitude3.text,
      morningRitual.text,
      eveRitual.text,
      priorityController.text,
      success1.text,
      success2.text,
      success3.text,
      howwasmyday.text,
      whatwouldido.text,
      personalNumber.text,
      businessNumber.text,
      priorityController.text,
      program1.text,
      program2.text,
      program3.text,
      habitController.text
    ];

    var counter = 0;
    print("this si permof$data");
    for (int i = 0; i < 23; i++) {
      if (data[i].isEmpty) {
        print("nadra");
        counter++;
      }
      setState(() {});
    }
    print(counter);
    if (counter == 0) {
      percent = 1.0;
    }
    if (counter == 1 || counter == 2) {
      percent = 0.9;
    }
    if (counter == 3 || counter == 4) {
      percent = 0.8;
    }
    if (counter == 5 || counter == 6) {
      percent = 0.7;
    }
    if (counter == 7 || counter == 8) {
      percent = 0.6;
    }
    if (counter == 9 || counter == 10) {
      percent = 0.5;
    }
    if (counter == 11 || counter == 12) {
      percent = 0.55;
    }
    if (counter == 13 || counter == 14) {
      percent = 0.5;
    }
    if (counter == 15 || counter == 16) {
      percent = 0.4;
    }
    if (counter == 17 || counter == 18) {
      percent = 0.35;
    }
    if (counter == 19 || counter == 20) {
      percent = 0.2;
    }
    if (counter == 21 || counter == 22) {
      percent = 0.1;
    }
    if (counter == 23 || counter == 24) {
      print("ithe");
      percent = 0.0;
    }

    setState(() {});
  }

  Widget getCircleButton(icon, size, index, statuss) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20))),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: icon,
            radius: size.width * 0.039,
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        (statuss == 'rate')
            ? Text(
                "$index xTimes",
                style:
                    TextStyle(color: colorHeader, fontSize: size.width * 0.03),
              )
            : Text(index,
                style:
                    TextStyle(color: colorHeader, fontSize: size.width * 0.03)),
      ],
    );
  }

  Widget getSmileysContainer(size, length) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Card(
        elevation: 2.0,
        child: Container(
          height: size.height * 0.6,
          width: size.width,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width,
                  height: size.height * 0.07,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 7,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: EdgeInsets.only(
                            left: size.width * 0.026, right: size.width * 0.03),
                        child: Text(
                          days[i],
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: size.width * 0.045),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.55,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 0,
                            childAspectRatio: 7.5 / 10),
                    itemCount: feeling.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              print(index);
                              print(month);
                              var dater = "${index}-12-2022";
                              DateTime tempDate =
                                  new DateFormat("dd-MM-yyyy").parse(dater);
                              selecteddate = tempDate;
                              formattedDateHeader =
                                  DateFormat('dd-MM-yyyy').format(tempDate);

                              getdata2(
                                      Date: selecteddate
                                          .toString()
                                          .substring(0, 10))
                                  .then((value) {
                                getdatainit();

                                getPercent();
                              });
                              SharedPreferences sp =
                                  await SharedPreferences.getInstance();
                              sp.setString("date", "$tempDate");

                              setState(() {});
                              Navigator.of(context).pop();
                              print(tempDate);
                            },
                            child: getCircleButton(
                                feeling[index] == 0
                                    ? Image.asset("assets/emoji/terribel.png")
                                    : feeling[index] == 1
                                        ? Image.asset("assets/emoji/sad.png")
                                        : feeling[index] == 2
                                            ? Image.asset(
                                                "assets/emoji/okay.png")
                                            : feeling[index] == 3
                                                ? Image.asset(
                                                    "assets/emoji/good.png")
                                                : feeling[index] == 4
                                                    ? Image.asset(
                                                        "assets/emoji/great.png")
                                                    : Icon(
                                                        Icons.pending_outlined,
                                                        color: bgColor,
                                                      ),
                                size,
                                "${index + 1}",
                                ""),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getdatainit() async {
    await getdata2(Date: selecteddate.toString().substring(0, 10))
        .then((value) {
      goal1 = goal1Field.text.toString();
      goal2 = goal2Field.text.toString();
      goal3 = goal3Field.text.toString();

      pleas1 = pleasure1.text.toString();
      pleas2 = pleasure2.text.toString();
      pleas3 = pleasure3.text.toString();
      habit = habitController.text.toString();
      print("gatedate2 success");
      print("goal1 $goal1");
      print("goal2$goal2");
      print("goal3$goal3");

      print(pleas1);
      print(pleas2);
      print(pleas3);
      print(habit);
    });
  }
}
