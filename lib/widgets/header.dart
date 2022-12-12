import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:reviews_slider/reviews_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/Authentication/profile_screen.dart';
import '../Screens/new_main.dart';
import '../utils/constants.dart';

late String formattedDateHeader;

class CustomHeader extends StatefulWidget {
  final percent;
  final screen;

  const CustomHeader({Key? key, this.screen, this.percent}) : super(key: key);

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  int isSelected = 2;

  DateTime selectedDate = DateTime.now();
  late String formattedDate;

  void initializeDate() async {
    DateTime selectedDate = DateTime.now();
    formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    formattedDateHeader = DateFormat('dd-MM-yyyy').format(DateTime.now());
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('date', "$selectedDate");
  }

  User? user = FirebaseAuth.instance.currentUser;
  var dataUser = [];

  Future<void> getdata2({
    required String Date,
  }) async {
    EasyLoading.show();
    print("Date $Date");
    try {
      await FirebaseFirestore.instance
          .collection("${user?.uid}")
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

  var days = [
    'Mon',
    'Tue',
    "Wed",
    "Thur",
    "Fri",
    "Sat",
    "Sun",
    'Mon',
    'Tue',
    "Wed",
    "Thur",
    "Fri",
    "Sat",
    "Sun",
    'Mon',
    'Tue',
    "Wed",
    "Thur",
    "Fri",
    "Sat",
    "Sun",
    'Mon',
    'Tue',
    "Wed",
    "Thur",
    "Fri",
    "Sat",
    "Sun",
    'Mon',
    'Tue',
    "Wed",
    "Thur",
    "Fri",
    "Sat",
    "Sun",
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: colorHeader, // header background color
                onPrimary: Colors.white, // header text color
                onSurface: Colors.green, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(),
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2018, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selecteddate = picked;
        formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
        formattedDateHeader = DateFormat('dd-MM-yyyy').format(picked);
        setState(() {});

        getdata2(Date: selecteddate.toString().substring(0, 10)).then((value) {
          getdatainit();

          getPercent();
        });
        setState(() {});
      });
    }
  }

  var counter = 1;
  var counterNext = 0;

  int? selectedValue1;

  void onChange1(int value) {
    setState(() {
      selectedValue1 = value;
    });
  }

  DateTime now = DateTime.now();
  late DateTime datWeek;
  var formattedDateHeaderName;

  /// e.g Thursday

  late DateTime lastDayOfMonth;

  @override
  void initState() {
    print("initheader");

    datWeek = DateTime.now();
    formattedDateHeaderName = DateFormat('EEEE').format(DateTime.now());

    /// e.g Thursday

    initializeDate();
    getPercent();
    // TODO: implement initState
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        height: size.height * 0.33,
        color: colorHeader,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.settings_outlined,
                    color: Colors.white,
                    size: size.width * 0.085,
                  ),
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Text(
                      '$formattedDateHeaderName',
                      style: TextStyle(
                          color: bgColor,
                          fontSize: size.width * 0.06,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: () async {
                            counterNext = 1;
                            counter = 1;
                            SharedPreferences sp =
                                await SharedPreferences.getInstance();
                            var date = sp.getString('date');
                            DateTime dateTime = DateTime.parse(date!);

                            print(counter);
                            FocusScope.of(context).unfocus();

                            DateTime? nowFiveDaysAgo =
                                dateTime.add(Duration(days: -counter));
                            print(nowFiveDaysAgo);
                            formattedDate =
                                DateFormat('yyyy-MM-dd').format(nowFiveDaysAgo);
                            formattedDateHeader =
                                DateFormat('dd-MM-yyyy').format(nowFiveDaysAgo);
                            formattedDateHeaderName =
                                DateFormat('EEEE').format(nowFiveDaysAgo);

                            /// e.g Thursday

                            datee = formattedDate;
                            dateSel = nowFiveDaysAgo;
                            print("it is updatd $formattedDate");
                            setState(() {});

                            sp.setString("date", "$nowFiveDaysAgo");
                            selecteddate = dateSel;
                            getdata2(
                                    Date: selecteddate
                                        .toString()
                                        .substring(0, 10))
                                .then((value) {
                              getdatainit();

                              getPercent();
                            });
                            // getdata2(Date: formattedDate);

                            // await getDataUser();
                            // await getPercent();

                            setState(() {});
                            // final yesterdaxy =DateTime.now() - 1;
                            // final tomorrow = DateTime(now.year, now.month, now.day + 1);
                          },
                          child: CircleAvatar(
                            backgroundColor: bgColor,
                            child: Center(
                                child: Icon(
                              Icons.arrow_back_ios,
                              color: colorHeader,
                              size: 20.0,
                            )),
                          )),
                      SizedBox(
                        width: size.width * 0.03,
                      ),
                      InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Text(
                          formattedDateHeader,
                          style: TextStyle(
                              color: bgColor, fontSize: size.width * 0.045),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.03,
                      ),
                      InkWell(
                          onTap: () async {
                            counterNext = 1;
                            counter = 1;
                            SharedPreferences sp =
                                await SharedPreferences.getInstance();
                            var date = sp.getString('date');
                            DateTime dateTime = DateTime.parse(date!);

                            print(counter);
                            DateTime? nowFiveDaysAgo =
                                dateTime.add(Duration(days: counter));
                            print(nowFiveDaysAgo);

                            formattedDate =
                                DateFormat('yyyy-MM-dd').format(nowFiveDaysAgo);
                            formattedDateHeader =
                                DateFormat('dd-MM-yyyy').format(nowFiveDaysAgo);
                            formattedDateHeaderName =
                                DateFormat('EEEE').format(nowFiveDaysAgo);

                            /// e.g Thursday

                            datee = formattedDate;
                            dateSel = nowFiveDaysAgo;
                            print("date     $dateSel");
                            selecteddate = dateSel;
                            setState(() {});
                            FocusScope.of(context).unfocus();

                            // getdata2(Date: formattedDate);
                            getdata2(
                                    Date: selecteddate
                                        .toString()
                                        .substring(0, 10))
                                .then((value) {
                              getdatainit();

                              getPercent();
                            });

                            sp.setString("date", "$nowFiveDaysAgo");

                            setState(() {});
                            // final yesterday =DateTime.now() - 1;
                            // final tomorrow = DateTime(now.year, now.month, now.day + 1);
                          },
                          child: InkWell(
                              child: CircleAvatar(
                            backgroundColor: bgColor,
                            child: Center(
                                child: Icon(
                              Icons.arrow_forward_ios,
                              color: colorHeader,
                              size: 20.0,
                            )),
                          ))),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreen()));
                      },
                      child: Icon(Icons.person,
                          color: bgColor, size: size.width * 0.08)),
                  //             InkWell(
                  //                 onTap: (){
                  //
                  //
                  //
                  //                 child: Icon(Icons.add,color: Colors.white,size: size.width*0.08,)),
                ],
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LinearPercentIndicator(
                barRadius: const Radius.circular(10.0),
                center: const Text(
                  'Daily Performance',
                  style: TextStyle(color: Colors.blueGrey),
                ),
                backgroundColor: Colors.grey,
                width: size.width * 0.7,
                lineHeight: size.height * 0.035,
                percent: percent,
                progressColor: Colors.white,
              ),
              Icon(Icons.alarm, color: bgColor, size: size.width * 0.09),
              Icon(Icons.warning_amber_rounded,
                  color: bgColor, size: size.width * 0.09),
            ],
          )
        ]));
  }
}
