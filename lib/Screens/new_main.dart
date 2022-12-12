// ignore_for_file: avoid_print, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:personal_dairy/widgets/expansion_tile.dart';
import 'package:personal_dairy/widgets/header.dart';
import 'package:reviews_slider/reviews_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../utils/constants.dart';
import '../widgets/bottom_sheet.dart';
import '../widgets/custom_smiley_picker.dart';
import '../widgets/goal_field.dart';
import 'Authentication/main_auth.dart';

var stat = false;
var percent = 0.0;
var datee;
bool? datacheck;

var dateSel = DateTime.now();

class MainScreenNew extends StatefulWidget {
  const MainScreenNew({Key? key}) : super(key: key);

  @override
  State<MainScreenNew> createState() => _MainScreenNewState();
}

class _MainScreenNewState extends State<MainScreenNew>
    with TickerProviderStateMixin {
  int isSelected = 2;
  final ScrollController scrollcontroller = ScrollController();
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
  bool scroll_visibility = true;
  late TabController _tabController;
  late TabController _tabControllerPhone;
  late TabController _tabControllerGoal;
  late TabController _tabControllerRituals;
  late TabController _tabControllerPleasure;
  var dataUser = [];
  var show = true;
  User? user = FirebaseAuth.instance.currentUser;
  DateTime selectedDate = DateTime.now();
  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  getPercent() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var date = sharedPreferences.getString('date');

    formattedDate = date!;

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

  User? userr = FirebaseAuth.instance.currentUser;
  List<SuggestionObject> suggestions = <SuggestionObject>[];
  List<String> suggestionStringsGoals = [];
  List<String> suggestionStringsGrat = [];
  List<String> suggestionStringsPleasur = [];
  List<String> suggestionStringsPrograms = [];
  List<String> suggestionStringsSuccess = [];
  List<String> suggestionStringFinance = [];
  List<String> suggestionStringLearning = [];
  List<String> suggestionStringRituals = [];
  List<String> suggestionStringPriority = [];
  List<String> suggestionStringHabit = [];

  final TextEditingController _nameTextController = TextEditingController();

  // var goal1, goal2, goal3, pleas1, pleas2, pleas3, habit;
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
          print("Saddddddddd");
          print("goal1 $goal1");
          print("goal1 ${goal1Field.text.toString()}");

          print("goal2$goal2");
          print("goal2f${goal2Field.text.toString()}");
          print("goal3$goal3");
          print("goal3f${goal3Field.text.toString()}");
          print("pleas1 $pleas1");
          print("pleas1f ${pleasure1.text.toString()}");
          print("pleas2$pleas2");
          print("pleas2f${pleasure2.text.toString()}");
          print("pleas3$pleas3");
          print("pleas3f${pleasure3.text.toString()}");
          print("habit$habit");
          print("habitf${habitController.text.toString()}");
          EasyLoading.dismiss();
        }
        // print(data["goalofweek"]);
      });
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  Future<void> adddata(
      {required String Date, required Map<String, dynamic> data}) async {
    EasyLoading.show();
    print(Date);

    await FirebaseFirestore.instance
        .collection("${userr?.uid}")
        .doc(Date)
        .set(data)
        .then((value) {
      print("added");
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text("Add Successfully"),
      // ));
    });
  }

  Future<void> update(
      {required String Date, required Map<String, dynamic> data}) async {
    // EasyLoading.show();
    await FirebaseFirestore.instance
        .collection("${userr?.uid}")
        .doc(Date)
        .update(data)
        .then((value) {
      print("object updated");
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text("Update Successfully"),
      // ));
      // EasyLoading.dismiss();
    });
  }

  Future<void> addbutton() async {
    print("object$datacheck");
    print("object ${selecteddate.toString()}");

    if (datacheck == false) {
      List dates = [];
      var newdate = selecteddate;

      for (int i = 1; i <= 7; ++i) {
        print(i);
        if (i == 1) {
          newdate = DateTime(newdate!.year, newdate.month, newdate.day);
          dates.add(
            newdate.toString().substring(0, 10),
          );

          continue;
        }
        newdate = DateTime(newdate!.year, newdate.month, newdate.day + 1);

        dates.add(
          newdate.toString().substring(0, 10),
        );
      }

      for (int i = 0; i < 7; i++) {
        print(dates[i]);
        if (i == 0) {
          Map<String, dynamic> data = {
            "goalofweek1": goal1Field.text.toString(),
            "goalofweek2": goal2Field.text.toString(),
            "goalofweek3": goal3Field.text.toString(),
            "pleasureofweek1": pleasure1.text.toString(),
            "pleasureofweek2": pleasure2.text.toString(),
            "pleasureofweek3": pleasure3.text.toString(),
            "Gratitiude1": gratitude1.text.toString(),
            "Gratitiude2": gratitude2.text.toString(),
            "Gratitiude3": gratitude3.text.toString(),
            "Priority": priorityController.text.toString(),
            "Todays_program1": program1.text.toString(),
            "Todays_program2": program2.text.toString(),
            "Todays_program3": program3.text.toString(),
            "ritualmorning": morningRitual.text.toString(),
            "ritualevening": eveRitual.text.toString(),
            "success1": success1.text.toString(),
            "success2": success2.text.toString(),
            "success3": success3.text.toString(),
            "learning1": howwasmyday.text.toString(),
            "learning2": whatwouldido.text.toString(),
            "financenumber": personalNumber.text.toString(),
            "financebusiness": businessNumber.text.toString(),
            "habitofweek": habitController.text.toString(),
            "dates": FieldValue.arrayUnion(dates)
          };
          adddata(Date: dates[i], data: data).then((value) {});
        } else {
          Map<String, dynamic> data = {
            "goalofweek1": goal1Field.text.toString(),
            "goalofweek2": goal2Field.text.toString(),
            "goalofweek3": goal3Field.text.toString(),
            "pleasureofweek1": pleasure1.text.toString(),
            "pleasureofweek2": pleasure2.text.toString(),
            "pleasureofweek3": pleasure3.text.toString(),
            "Gratitiude1": gratitude1.text.toString(),
            "Gratitiude2": gratitude2.text.toString(),
            "Gratitiude3": gratitude3.text.toString(),
            "Priority": priorityController.text.toString(),
            "Todays_program1": program1.text.toString(),
            "Todays_program2": program2.text.toString(),
            "Todays_program3": program3.text.toString(),
            "ritualmorning": morningRitual.text.toString(),
            "ritualevening": eveRitual.text.toString(),
            "success1": success1.text.toString(),
            "success2": success2.text.toString(),
            "success3": success3.text.toString(),
            "learning1": howwasmyday.text.toString(),
            "learning2": whatwouldido.text.toString(),
            "financenumber": personalNumber.text.toString(),
            "financebusiness": businessNumber.text.toString(),
            "habitofweek": habitController.text.toString(),
            "dates": FieldValue.arrayUnion(dates)
          };

          adddata(Date: dates[i], data: data).then((value) {
            print("add$i");

            if (i == 6) {
              print("closs$i");
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Added Successfully"),
              ));
              EasyLoading.dismiss();
              setState(() {});
            }
          });
        }
      }
    } else if (datacheck == true) {
      print("objectaaaa ${selecteddate.toString()}");

      EasyLoading.show();

      final List dates = [];
      print("object tap");
      print(selecteddate);
      await _firestore
          .collection("${userr?.uid}")
          .doc(
            selecteddate.toString().substring(0, 10),
          )
          .get()
          .then((value) {
        DocumentSnapshot data = value;
        print(data["dates"]);
        dates.addAll(data["dates"]);
        print("object $dates");
      });

      print(dates.length);
      Map<String, dynamic> data = {
        "goalofweek1": goal1Field.text.toString(),
        "goalofweek2": goal2Field.text.toString(),
        "goalofweek3": goal3Field.text.toString(),
        "pleasureofweek1": pleasure1.text.toString(),
        "pleasureofweek2": pleasure2.text.toString(),
        "pleasureofweek3": pleasure3.text.toString(),
        "habitofweek": habitController.text.toString(),
      };
      print("goal1 $goal1");
      print("goal1f ${goal1Field.text.toString()}");

      print("goal2$goal2");
      print("goal2f${goal2Field.text.toString()}");
      print("goal3$goal3");
      print("goal3f${goal3Field.text.toString()}");
      print("pleas1 $pleas1");
      print("pleas1f ${pleasure1.text.toString()}");
      print("pleas2$pleas2");
      print("pleas2f${pleasure2.text.toString()}");
      print("pleas3$pleas3");
      print("pleas3f${pleasure3.text.toString()}");
      print("habit$habit");
      print("habitf${habitController.text.toString()}");

      if (goal1 != goal1Field.text.toString() ||
          goal2 != goal2Field.text.toString() ||
          goal3 != goal3Field.text.toString() ||
          pleas1 != pleasure1.text.toString() ||
          pleas2 != pleasure2.text.toString() ||
          pleas3 != pleasure3.text.toString() ||
          habit != habitController.text.toString()) {
        print("object change");

        for (int i = 0; i < dates.length; ++i) {
          print(i);

          print(dates[i]);
          update(Date: dates[i], data: data).then((value) {
            if (i == 6) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Updated Successfully"),
              ));
              EasyLoading.dismiss();
              print("after call 6 date $selecteddate");

              // getdata2(Date: selecteddate.toString().substring(0, 10));
              setState(() {});
            }
          });
          print("clossssss$i");
        }
      } else {
        print("object true and else");
        Map<String, dynamic> data = {
          "Gratitiude1": gratitude1.text.toString(),
          "Gratitiude2": gratitude2.text.toString(),
          "Gratitiude3": gratitude3.text.toString(),
          "Priority": priorityController.text.toString(),
          "Todays_program1": program1.text.toString(),
          "Todays_program2": program2.text.toString(),
          "Todays_program3": program3.text.toString(),
          "ritualmorning": morningRitual.text.toString(),
          "ritualevening": eveRitual.text.toString(),
          "success1": success1.text.toString(),
          "success2": success2.text.toString(),
          "success3": success3.text.toString(),
          "learning1": howwasmyday.text.toString(),
          "learning2": whatwouldido.text.toString(),
          "financenumber": personalNumber.text.toString(),
          "financebusiness": businessNumber.text.toString(),
        };
        update(Date: selecteddate.toString().substring(0, 10), data: data)
            .then((value) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("object Successfully"),
          ));
          EasyLoading.dismiss();

          setState(() {});
        });
      }
    }
  }

  var datas = [];
  var datasFilter = [];

  getDataaa() async {
    suggestionStringsGoals = [];
    suggestionStringHabit = [];
    suggestionStringsPleasur = [];

    suggestionStringFinance = [];
    suggestionStringHabit = [];
    suggestionStringsSuccess = [];
    suggestionStringPriority = [];
    suggestionStringRituals = [];
    print("user if ");
    print(userr?.uid);
    var catList = [
      'goal',
      'pleasure',
      'gratitudes',
      "priority",
      "programs",
      'rituals',
      'success',
      'learnings',
      'finance',
      'habit'
    ];
    var suggestList = [
      suggestionStringsGoals,
      suggestionStringsPleasur,
      suggestionStringsGrat,
      suggestionStringPriority,
      suggestionStringsPrograms,
      suggestionStringRituals,
      suggestionStringsSuccess,
      suggestionStringLearning,
      suggestionStringFinance,
      suggestionStringHabit
    ];

    for (int i = 0; i < catList.length; i++) {
      datas = [];
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection("filterData")
          .where('uid', isEqualTo: userr?.uid)
          .where('category', isEqualTo: catList[i])
          .get();
      setState(() {
        datas.addAll(snap.docs);
      });
      for (int j = 0; j < datas.length; j++) {
        print(suggestionStringsGoals);
        suggestList[i].add(datas[j]["data"]);
      }
    }
    setState(() {});
    print("set");
    print(suggestList); // QuerySnapshot snap =
    //   await FirebaseFirestore.instance.collection("filterData").where('uid',isEqualTo: userr?.uid).where('category',isEqualTo: 'goal').get();
    //   setState(() {
    //     datas.addAll(snap.docs);
    //   });
    //
    // for(int i=0;i<datas.length;i++){
    //   suggestionStringsGoals.add(datas[0]["data"]);
    // }
    print("thhji sis Data $suggestionStringsGoals");
  }

  Future<void> addfeel(
      String year, String month, int val, String day, var uid) async {
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

  @override
  void initState() {
    print("initmain");
    getDataaa();
    selecteddate = selectedDate;
    print("object ${selecteddate.toString()}");
    getdatainit();
    getPercent();
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabControllerPhone = TabController(length: 2, vsync: this);
    _tabControllerGoal = TabController(length: 3, vsync: this);
    _tabControllerRituals = TabController(length: 2, vsync: this);
    _tabControllerPleasure = TabController(length: 3, vsync: this);
  }

  Future<void> addDate(data, category) async {
    await FirebaseFirestore.instance
        .collection("filterData")
        .add({'data': data, 'uid': userr?.uid, 'category': category});
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

  var status = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
              (status == false) ? size.height * 0.2 : size.height * 0.2),
          child: (status == false)
              ? CustomHeader(
                  percent: percent,
                  screen: 'day',
                )
              : CustomHeader(
                  percent: percent,
                  screen: 'day',
                ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: NotificationListener(
            onNotification: (ScrollNotification notification) {
              if (notification.metrics.atEdge) {
                if (scrollcontroller.position.userScrollDirection ==
                    ScrollDirection.reverse) {
                  status = true;
                  stat = true;
                  setState(() {}); //the setState function
                } else if (scrollcontroller.position.userScrollDirection ==
                    ScrollDirection.forward) {
                  status = false;
                  stat = false;

                  setState(() {});
                  //setState function
                }
                setState(() {});
              }

              return true;
            },
            child: SingleChildScrollView(
              controller: scrollcontroller,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.03,
                        right: size.width * 0.03,
                        top: size.height * 0.01),
                    child: Container(
                      height: size.height * 0.22,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Card(
                          color: Colors.white,
                          elevation: 5.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.17),
                                      child: Text(
                                        (language == "English")
                                            ? english['How was you feeling?']
                                            : (language == "Slovak")
                                                ? slovak['How was you feeling?']
                                                : czech['How was you feeling?'],
                                        style: TextStyle(
                                            color: colorHeader,
                                            fontSize: size.width * 0.05,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.0),
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  CustomSmileyPicker());
                                        },
                                        child: Icon(
                                          Icons.add_chart,
                                          color: colorHeader,
                                          size: size.width * 0.08,
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              ReviewSlider(
                                optionStyle:
                                    TextStyle(fontSize: size.width * 0.029),
                                initialValue: 0,
                                circleDiameter: 40.0,
                                onChange: (val) async {
                                  // formattedDate = DateFormat('dd-MM-yyyy').format(selecteddate!);
                                  DateTime date = DateTime.now();
                                  var year =
                                      selecteddate.toString().substring(0, 4);
                                  var month =
                                      selecteddate.toString().substring(5, 7);
                                  var day =
                                      selecteddate.toString().substring(8, 10);

                                  print(selectedDate);

                                  print(day);
                                  print(year);
                                  print(month);
                                  date.add(const Duration(days: -1));
                                  // day = "12";
                                  addfeel("$year", "$month", val, "$day",
                                      userr?.uid);

                                  setState(() {
                                    // getDataUser();
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Padding(
                  //     padding: EdgeInsets.only(
                  //         left: size.width * 0.03,
                  //         right: size.width * 0.03,
                  //         top: size.height * 0.01),
                  //     child: Visibility(
                  //       visible: (status == true) ? false : true,
                  //       child: Container(
                  //         height: size.height * 0.09,
                  //         child: ListView.builder(
                  //             scrollDirection: Axis.horizontal,
                  //             itemCount: 30,
                  //             itemBuilder: (context, i) {
                  //               return InkWell(
                  //                   onTap: () {
                  //                     isSelected = i;
                  //                     setState(() {});
                  //                   },
                  //                   child: Calender(
                  //                       colorCon: (i == isSelected)
                  //                           ? colorHeader
                  //                           : bgColor,
                  //                       date: "${i + 1}",
                  //                       day: 'Mon'));
                  //             }),
                  //       ),
                  //     )),

                  expansionTile(
                      Icons.gamepad_outlined,
                      (language == "English")
                          ? english['Goals of week']
                          : (language == "Slovak")
                              ? slovak['Goals of week']
                              : czech['Goals of week'],
                      size,
                      Column(
                        children: [
                          Container(
                              height: (statusSuggestion == true)
                                  ? size.height * 0.5
                                  : size.height * 0.24,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TabBar(
                                    indicatorColor: colorHeader,
                                    isScrollable: true,
                                    labelPadding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.1),
                                    unselectedLabelColor: Colors.black,
                                    labelColor: Colors.red,
                                    labelStyle: TextStyle(
                                        color: colorHeader,
                                        fontSize: size.width * 0.03),
                                    tabs: [
                                      Tab(
                                        text: (_tabControllerGoal.index == 0)
                                            ? (language == "English")
                                                ? english[
                                                    '1st Goal of the week']
                                                : (language == "Slovak")
                                                    ? slovak[
                                                        '1st Goal of the week']
                                                    : czech[
                                                        '1st Goal of the week']
                                            : '1st',
                                      ),
                                      Tab(
                                        text: (_tabControllerGoal.index == 1)
                                            ? (language == "English")
                                                ? english[
                                                    '2nd Goal of the week']
                                                : (language == "Slovak")
                                                    ? slovak[
                                                        '2nd Goal of the week']
                                                    : czech[
                                                        '2nd Goal of the week']
                                            : '2nd',
                                      ),
                                      Tab(
                                        text: (_tabControllerGoal.index == 2)
                                            ? (language == "English")
                                                ? english[
                                                    '3rd Goal of the week']
                                                : (language == "Slovak")
                                                    ? slovak[
                                                        '3rd Goal of the week']
                                                    : czech[
                                                        '3rd Goal of the week']
                                            : '3rd',
                                      ),
                                    ],
                                    controller: _tabControllerGoal,
                                    indicatorSize: TabBarIndicatorSize.tab,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: TabBarView(
                                        controller: _tabControllerGoal,
                                        children: [
                                          GoalField(
                                            onTap: () async {
                                              print("3");
                                              addbutton().then((value) {
                                                getdatainit();
                                                addDate(
                                                    goal1Field.text, "goal");
                                                getPercent();
                                                getDataaa();
                                              });
                                            },
                                            status: "Goals",
                                            controller: goal1Field,
                                            numb: 3,
                                            suggestions: suggestionStringsGoals,
                                            hint: (language == "English")
                                                ? english['1st Goal of week']
                                                : (language == "Slovak")
                                                    ? slovak['1st Goal of week']
                                                    : czech['1st Goal of week'],
                                          ),
                                          GoalField(
                                            onTap: () async {
                                              print("3");
                                              addbutton().then((value) {
                                                getdatainit();
                                                addDate(
                                                    goal2Field.text, "goal");

                                                getPercent();
                                                getDataaa();
                                              });
                                            },
                                            status: "Goals",
                                            suggestions: suggestionStringsGoals,

                                            controller: goal2Field,
                                            hint: (language == "English")
                                                ? english['2nd Goal of week']
                                                : (language == "Slovak")
                                                    ? slovak['2nd Goal of week']
                                                    : czech['2nd Goal of week'],

                                            // hint: "2nd Goal of week",
                                            numb: 3,
                                          ),
                                          GoalField(
                                            onTap: () async {
                                              print("3");
                                              addbutton().then((value) {
                                                getdatainit();
                                                addDate(
                                                    goal3Field.text, "goal");

                                                getPercent();
                                                getDataaa();
                                              });
                                            },
                                            status: "Goals",
                                            suggestions: suggestionStringsGoals,

                                            controller: goal3Field,
                                            hint: (language == "English")
                                                ? english['3rd Goal of week']
                                                : (language == "Slovak")
                                                    ? slovak['3rd Goal of week']
                                                    : czech['3rd Goal of week'],

                                            // hint: "3rd Goal of week",
                                            numb: 3,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      status,
                      context,
                      'goals'),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    thickness: 3.0,
                  ),

                  SizedBox(
                    height: 5,
                  ),
                  expansionTile(
                      Icons.gamepad_outlined,
                      (language == "English")
                          ? english['Pleasures of week']
                          : (language == "Slovak")
                              ? slovak['Pleasures of week']
                              : czech['Pleasures of week'],
                      size,
                      Column(
                        children: [
                          Container(
                              height: (statusSuggestion == true)
                                  ? size.height * 0.5
                                  : size.height * 0.3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TabBar(
                                    isScrollable: true,
                                    labelPadding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.1),
                                    indicatorColor: colorHeader,
                                    unselectedLabelColor: Colors.black,
                                    labelColor: Colors.red,
                                    labelStyle: TextStyle(
                                        color: colorHeader,
                                        fontSize: size.width * 0.03),
                                    tabs: [
                                      Tab(
                                        text: (_tabControllerPleasure.index ==
                                                0)
                                            ? (language == "English")
                                                ? english[
                                                    '1st Pleaure of the week']
                                                : (language == "Slovak")
                                                    ? slovak[
                                                        '1st Pleaure of the week']
                                                    : czech[
                                                        '1st Pleaure of the week']
                                            : '1st',

                                        // text: '1st Pleaure of the week',
                                      ),
                                      Tab(
                                        text: (_tabControllerPleasure.index ==
                                                1)
                                            ? (language == "English")
                                                ? english[
                                                    '2nd Pleaure of the week']
                                                : (language == "Slovak")
                                                    ? slovak[
                                                        '2nd Pleaure of the week']
                                                    : czech[
                                                        '2nd Pleaure of the week']
                                            : '2nd',

                                        // text: '2nd Pleaure of the week',
                                      ),
                                      Tab(
                                        text: (_tabControllerPleasure.index ==
                                                2)
                                            ? (language == "English")
                                                ? english[
                                                    '3rd Pleaure of the week']
                                                : (language == "Slovak")
                                                    ? slovak[
                                                        '3rd Pleaure of the week']
                                                    : czech[
                                                        '3rd Pleaure of the week']
                                            : '3rd',

                                        // text: '3rd Pleaure of the week',
                                      ),
                                    ],
                                    controller: _tabControllerPleasure,
                                    indicatorSize: TabBarIndicatorSize.tab,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: TabBarView(
                                        children: [
                                          GoalField(
                                            onTap: () async {
                                              print("3");
                                              addbutton().then((value) {
                                                getdatainit();
                                                addDate(
                                                    pleasure1.text, "pleasure");
                                                getPercent();
                                                getDataaa();
                                              });
                                            },
                                            status: "Pleasure",
                                            suggestions:
                                                suggestionStringsPleasur,

                                            controller: pleasure1,
                                            hint: (language == "English")
                                                ? english['1st Pleaure of week']
                                                : (language == "Slovak")
                                                    ? slovak[
                                                        '1st Pleaure of week']
                                                    : czech[
                                                        '1st Pleaure of week'],

                                            numb: 3,
                                            // hint: "1st Pleaure of week",
                                          ),
                                          GoalField(
                                            onTap: () async {
                                              print("3");
                                              addbutton().then((value) {
                                                getdatainit();
                                                addDate(
                                                    pleasure2.text, "pleasure");

                                                getPercent();
                                                getDataaa();
                                              });
                                            },
                                            status: "Pleasure",
                                            suggestions:
                                                suggestionStringsPleasur,

                                            controller: pleasure2,
                                            hint: (language == "English")
                                                ? english['2nd Pleaure of week']
                                                : (language == "Slovak")
                                                    ? slovak[
                                                        '2nd Pleaure of week']
                                                    : czech[
                                                        '2nd Pleaure of week'],

                                            // hint: "2nd Pleaure of week",
                                            numb: 3,
                                          ),
                                          GoalField(
                                            onTap: () async {
                                              print("3");
                                              addbutton().then((value) {
                                                getdatainit();
                                                addDate(
                                                    pleasure3.text, "pleasure");

                                                getPercent();
                                                getDataaa();
                                              });
                                            },
                                            status: "Pleasure",
                                            suggestions:
                                                suggestionStringsPleasur,

                                            controller: pleasure3,
                                            hint: (language == "English")
                                                ? english['3rd Pleaure of week']
                                                : (language == "Slovak")
                                                    ? slovak[
                                                        '3rd Pleaure of week']
                                                    : czech[
                                                        '3rd Pleaure of week'],

                                            // hint: "3rd Pleaure of week",
                                            numb: 3,
                                          ),
                                        ],
                                        controller: _tabControllerPleasure,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      status,
                      context,
                      'pleasure'),

                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    thickness: 3.0,
                  ),

                  SizedBox(
                    height: 5,
                  ),
                  expansionTile(
                      Icons.grading_outlined,
                      (language == "English")
                          ? english['Gratitudes']
                          : (language == "Slovak")
                              ? slovak['Gratitudes']
                              : czech['Gratitudes'],
                      size,
                      Column(
                        children: [
                          //    NewGoalField(controller: gratitude1,hint: "",suggestedString: suggestionStringsGrat,onTap:()async{
                          // print(goal1Field);
                          // var msg=await updateGoals(gratitude1.text,gratitude2.text,gratitude3.text,'gratitude1',priorityController.text,habitController.text).whenComplete(() {
                          //   Fluttertoast.showToast(
                          //       msg: "Added");
                          //   getDataUser();
                          //
                          // }).onError((error, stackTrace) => Fluttertoast.showToast(msg: "$error"));
                          //
                          //    } ,),
                          GoalField(
                            onTap: () async {
                              print("3");
                              addbutton().then((value) {
                                getdatainit();
                                addDate(gratitude1.text, "gratitudes");

                                getPercent();
                                getDataaa();
                              });
                            },
                            status: "Gratitude",
                            suggestions: suggestionStringsGrat,

                            controller: gratitude1,

                            hint: (language == "English")
                                ? english['1st Gratitude']
                                : (language == "Slovak")
                                    ? slovak['1st Gratitude']
                                    : czech['1st Gratitude'],

                            numb: 3,
                            // hint: "1st Gratitude",
                          ),
                          GoalField(
                            onTap: () async {
                              print("3");
                              addbutton().then((value) {
                                getdatainit();
                                addDate(gratitude2.text, "gratitudes");

                                getPercent();
                                getDataaa();
                              });
                            },
                            status: "Gratitude",
                            controller: gratitude2,
                            suggestions: suggestionStringsGrat,

                            hint: (language == "English")
                                ? english['2nd Gratitude']
                                : (language == "Slovak")
                                    ? slovak['2nd Gratitude']
                                    : czech['2nd Gratitude'],

                            // hint: "2nd Gratitude",
                            numb: 3,
                          ),
                          GoalField(
                            onTap: () async {
                              print("3");
                              addbutton().then((value) {
                                getdatainit();
                                addDate(gratitude3.text, "gratitudes");

                                getPercent();
                                getDataaa();
                              });
                            },
                            status: "Gratitude",
                            controller: gratitude3,
                            suggestions: suggestionStringsGrat,

                            hint: (language == "English")
                                ? english['3rd Gratitude']
                                : (language == "Slovak")
                                    ? slovak['3rd Gratitude']
                                    : czech['3rd Gratitude'],

                            // hint: "/ Gratitude",
                            numb: 3,
                          ),
                        ],
                      ),
                      status,
                      context,
                      'gratitude'),

                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    thickness: 3.0,
                  ),

                  SizedBox(
                    height: 5,
                  ),
                  expansionTile(
                      Icons.wb_sunny,
                      (language == "English")
                          ? english['Priority of the day']
                          : (language == "Slovak")
                              ? slovak['Priority of the day']
                              : czech['Priority of the day'],
                      size,
                      Column(
                        children: [
                          GoalField(
                            onTap: () async {
                              print("3");
                              addbutton().then((value) {
                                getdatainit();
                                addDate(priorityController.text, "priority");

                                getPercent();
                                getDataaa();
                              });
                            },
                            status: "Priority",
                            suggestions: suggestionStringPriority,
                            controller: priorityController,
                            hint: (language == "English")
                                ? english['Priority of day']
                                : (language == "Slovak")
                                    ? slovak['Priority of day']
                                    : czech['Priority of day'],
                            numb: 3,
                          ),
                        ],
                      ),
                      status,
                      context,
                      'priority'),

                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    thickness: 3.0,
                  ),

                  SizedBox(
                    height: 5,
                  ),
                  expansionTile(
                      Icons.wb_sunny,
                      (language == "English")
                          ? english['Todays Programs']
                          : (language == "Slovak")
                              ? slovak['Todays Programs']
                              : czech['Todays Programs'],
                      size,
                      Column(
                        children: [
                          GoalField(
                            onTap: () async {
                              print("3");
                              addbutton().then((value) {
                                getdatainit();
                                addDate(program1.text, "programs");

                                getPercent();
                                getDataaa();
                              });
                            },
                            status: "Programs",
                            suggestions: suggestionStringsPrograms,

                            controller: program1,
                            hint: (language == "English")
                                ? english['1st Program']
                                : (language == "Slovak")
                                    ? slovak['1st Program']
                                    : czech['1st Program'],

                            numb: 3,
                            // hint: "1st Program",
                          ),
                          GoalField(
                            onTap: () async {
                              print("3");
                              addbutton().then((value) {
                                getdatainit();
                                addDate(program2.text, "programs");

                                getPercent();
                                getDataaa();
                              });
                            },
                            status: "Programs",
                            suggestions: suggestionStringsPrograms,

                            controller: program2,
                            hint: (language == "English")
                                ? english['2nd Program']
                                : (language == "Slovak")
                                    ? slovak['2nd Program']
                                    : czech['2nd Program'],

                            // hint: "2nd Program",
                            numb: 3,
                          ),
                          GoalField(
                            onTap: () async {
                              print("3");
                              addbutton().then((value) {
                                getdatainit();
                                addDate(program3.text, "programs");

                                getPercent();
                                getDataaa();
                              });
                            },
                            status: "Programs",
                            suggestions: suggestionStringsPrograms,

                            controller: program3,
                            // hint: "3rd Program",
                            hint: (language == "English")
                                ? english['3rd Program']
                                : (language == "Slovak")
                                    ? slovak['3rd Program']
                                    : czech['3rd Program'],

                            numb: 3,
                          ),
                        ],
                      ),
                      status,
                      context,
                      'programs'),

                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    thickness: 3.0,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  expansionTile(
                      Icons.wb_sunny,
                      (language == "English")
                          ? english['Rituals']
                          : (language == "Slovak")
                              ? slovak['Rituals']
                              : czech['Rituals'],
                      size,
                      Column(
                        children: [
                          Container(
                              height: (statusSuggestion == true)
                                  ? size.height * 0.5
                                  : size.height * 0.3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TabBar(
                                    isScrollable: true,
                                    labelPadding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.2),
                                    indicatorColor: colorHeader,
                                    unselectedLabelColor: Colors.black,
                                    labelColor: Colors.red,
                                    labelStyle: TextStyle(
                                        color: colorHeader,
                                        fontSize: size.width * 0.03),
                                    tabs: [
                                      Tab(
                                        text: (_tabControllerRituals.index == 0)
                                            ? (language == "English")
                                                ? english['Morning Rituals']
                                                : (language == "Slovak")
                                                    ? slovak['Morning Rituals']
                                                    : czech['Morning Rituals']
                                            : '1st',

                                        // text: 'Morning Rituals',
                                      ),
                                      Tab(
                                        text: (_tabControllerRituals.index == 1)
                                            ? (language == "English")
                                                ? english['Evening Rituals']
                                                : (language == "Slovak")
                                                    ? slovak['Evening Rituals']
                                                    : czech['Evening Rituals']
                                            : '2nd',

                                        // text: 'Evening Rituals',
                                      ),
                                    ],
                                    controller: _tabControllerRituals,
                                    indicatorSize: TabBarIndicatorSize.tab,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: TabBarView(
                                        children: [
                                          GoalField(
                                            onTap: () async {
                                              print("3");
                                              addbutton().then((value) {
                                                getdatainit();
                                                addDate(morningRitual.text,
                                                    "rituals");
                                                getPercent();
                                                getDataaa();
                                              });
                                            },
                                            status: "Rituals",
                                            suggestions:
                                                suggestionStringRituals,

                                            controller: morningRitual,
                                            hint: (language == "English")
                                                ? english['Morning']
                                                : (language == "Slovak")
                                                    ? slovak['Morning']
                                                    : czech['Morning'],

                                            // hint: "Morning",
                                            numb: 3,
                                          ),
                                          GoalField(
                                            onTap: () async {
                                              print("3");
                                              addbutton().then((value) {
                                                getdatainit();
                                                addDate(
                                                    eveRitual.text, "rituals");
                                                getPercent();
                                                getDataaa();
                                              });
                                            },
                                            status: "Ritual",
                                            suggestions:
                                                suggestionStringRituals,

                                            controller: eveRitual,
                                            hint: (language == "English")
                                                ? english['Evening']
                                                : (language == "Slovak")
                                                    ? slovak['Evening']
                                                    : czech['Evening'],

                                            // hint: "Evening",
                                            numb: 3,
                                          ),
                                        ],
                                        controller: _tabControllerRituals,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      status,
                      context,
                      'rituals'),

                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    thickness: 3.0,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  //gr
                  expansionTile(
                      Icons.grading_outlined,
                      (language == "English")
                          ? english['Successes']
                          : (language == "Slovak")
                              ? slovak['Successes']
                              : czech['Successes'],
                      size,
                      Column(
                        children: [
                          GoalField(
                            onTap: () async {
                              print("3");
                              addbutton().then((value) {
                                getdatainit();
                                addDate(success1.text, "success");
                                getPercent();
                                getDataaa();
                              });
                            },
                            status: "Success",
                            controller: success1,
                            suggestions: suggestionStringsSuccess,

                            numb: 3,
                            hint: (language == "English")
                                ? english['First']
                                : (language == "Slovak")
                                    ? slovak['First']
                                    : czech['First'],

                            // hint: "First ",
                          ),
                          GoalField(
                            onTap: () async {
                              print("3");
                              addbutton().then((value) {
                                getdatainit();
                                addDate(success2.text, "success");
                                getPercent();
                                getDataaa();
                              });
                            },
                            status: "Success",
                            controller: success2,
                            suggestions: suggestionStringsSuccess,

                            hint: (language == "English")
                                ? english['Second']
                                : (language == "Slovak")
                                    ? slovak['Second']
                                    : czech['Second'],

                            // hint: "Second",
                            numb: 3,
                          ),
                          GoalField(
                            onTap: () async {
                              print("3");
                              addbutton().then((value) {
                                getdatainit();
                                addDate(success3.text, "success");
                                getPercent();
                                getDataaa();
                              });
                            },
                            status: "Success",
                            suggestions: suggestionStringsSuccess,

                            controller: success3,
                            hint: (language == "English")
                                ? english['Third']
                                : (language == "Slovak")
                                    ? slovak['Third']
                                    : czech['Third'],

                            // hint: "Third",
                            numb: 3,
                          ),
                        ],
                      ),
                      status,
                      context,
                      'Success'),

                  Divider(
                    thickness: 2.0,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),

                  expansionTile(
                      Icons.grading_outlined,
                      (language == "English")
                          ? english['Learnings']
                          : (language == "Slovak")
                              ? slovak['Learnings']
                              : czech['Learnings'],
                      size,
                      Column(
                        children: [
                          Container(
                              height: (statusSuggestion == true)
                                  ? size.height * 0.5
                                  : size.height * 0.3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TabBar(
                                    isScrollable: true,
                                    labelPadding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.2),
                                    indicatorColor: colorHeader,
                                    unselectedLabelColor: Colors.black,
                                    labelColor: Colors.red,
                                    labelStyle: TextStyle(
                                        color: colorHeader,
                                        fontSize: size.width * 0.03),
                                    tabs: [
                                      Tab(
                                        text: (_tabController.index == 0)
                                            ? (language == "English")
                                                ? english['How was my day?']
                                                : (language == "Slovak")
                                                    ? slovak['How was my day?']
                                                    : czech['How was my day?']
                                            : '1st',

                                        // text: 'How was my day?',
                                      ),
                                      Tab(
                                        text: (_tabController.index == 1)
                                            ? (language == "English")
                                                ? english[
                                                    'What would I do differently?']
                                                : (language == "Slovak")
                                                    ? slovak[
                                                        'What would I do differently?']
                                                    : czech[
                                                        'What would I do differently?']
                                            : '2nd',

                                        // text: 'What would I do differently?',
                                      ),
                                    ],
                                    controller: _tabController,
                                    indicatorSize: TabBarIndicatorSize.tab,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: TabBarView(
                                        children: [
                                          GoalField(
                                            onTap: () async {
                                              print("3");
                                              addbutton().then((value) {
                                                getdatainit();
                                                addDate(howwasmyday.text,
                                                    "learnings");
                                                getPercent();
                                                getDataaa();
                                              });
                                            },
                                            status: "Learning",
                                            controller: howwasmyday,
                                            suggestions:
                                                suggestionStringLearning,

                                            hint: (language == "English")
                                                ? english['Enter your learning']
                                                : (language == "Slovak")
                                                    ? slovak[
                                                        'Enter your learning']
                                                    : czech[
                                                        'Enter your learning'],

                                            // hint: "Enter your learning",
                                            numb: 3,
                                          ),
                                          GoalField(
                                            onTap: () async {
                                              print("3");
                                              addbutton().then((value) {
                                                getdatainit();
                                                addDate(whatwouldido.text,
                                                    "learnings");
                                                getPercent();
                                                getDataaa();
                                              });
                                            },
                                            status: "Learning",
                                            suggestions:
                                                suggestionStringLearning,

                                            controller: whatwouldido,
                                            hint: (language == "English")
                                                ? english[
                                                    'Enter you would do differently']
                                                : (language == "Slovak")
                                                    ? slovak[
                                                        'Enter you would do differently']
                                                    : czech[
                                                        'Enter you would do differently'],

                                            // hint:
                                            //     "Enter you would do differently",
                                            numb: 3,
                                          ),
                                        ],
                                        controller: _tabController,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      status,
                      context,
                      'Learning'),

                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    thickness: 2.0,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  expansionTile(
                      Icons.grading_outlined,
                      (language == "English")
                          ? english['Finance']
                          : (language == "Slovak")
                              ? slovak['Finance']
                              : czech['Finance'],
                      size,
                      Column(
                        children: [
                          Container(
                              height: (statusSuggestion == true)
                                  ? size.height * 0.5
                                  : size.height * 0.3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TabBar(
                                    isScrollable: true,
                                    labelPadding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.1),
                                    indicatorColor: colorHeader,
                                    unselectedLabelColor: Colors.black,
                                    labelColor: Colors.red,
                                    labelStyle: TextStyle(
                                        color: colorHeader,
                                        fontSize: size.width * 0.03),
                                    tabs: [
                                      Tab(
                                        text: (_tabControllerPhone.index == 0)
                                            ? (language == "English")
                                                ? english[
                                                    'Personal Number(Income Expense)']
                                                : (language == "Slovak")
                                                    ? slovak[
                                                        'Personal Number(Income Expense)']
                                                    : czech[
                                                        'Personal Number(Income Expense)']
                                            : '1st',

                                        // text: 'Personal Number(Income Expense)',
                                      ),
                                      Tab(
                                        text: (_tabControllerPhone.index == 1)
                                            ? (language == "English")
                                                ? english['Business Number']
                                                : (language == "Slovak")
                                                    ? slovak['Business Number']
                                                    : czech['Business Number']
                                            : '2nd',

                                        // text: 'Business Number',
                                      ),
                                    ],
                                    controller: _tabControllerPhone,
                                    indicatorSize: TabBarIndicatorSize.tab,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: TabBarView(
                                        children: [
                                          GoalField(
                                            onTap: () async {
                                              print("3");
                                              addbutton().then((value) {
                                                getdatainit();
                                                addDate(personalNumber.text,
                                                    "finance");
                                                getPercent();
                                                getDataaa();
                                              });
                                            },
                                            status: "Finance",
                                            suggestions:
                                                suggestionStringFinance,

                                            controller: personalNumber,
                                            hint: (language == "English")
                                                ? english['Enter Personal']
                                                : (language == "Slovak")
                                                    ? slovak['Enter Personal']
                                                    : czech['Enter Personal'],

                                            keyBoardType: TextInputType
                                                .numberWithOptions(),
                                            // hint: "Enter Personal",
                                            numb: 3,
                                          ),
                                          GoalField(
                                            onTap: () async {
                                              print("3");
                                              addbutton().then((value) {
                                                getdatainit();
                                                addDate(businessNumber.text,
                                                    "finance");
                                                getPercent();
                                                getDataaa();
                                              });
                                            },
                                            status: "Finance",
                                            controller: businessNumber,
                                            suggestions:
                                                suggestionStringFinance,

                                            keyBoardType: TextInputType
                                                .numberWithOptions(),
                                            hint: (language == "English")
                                                ? english['Enter Business']
                                                : (language == "Slovak")
                                                    ? slovak['Enter Business']
                                                    : czech['Enter Business'],

                                            // hint: "Enter Business",
                                            numb: 3,
                                          ),
                                        ],
                                        controller: _tabControllerPhone,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      status,
                      context,
                      'finance'),

                  SizedBox(
                    height: 5,
                  ),
                  //dasa
                  Divider(
                    thickness: 2.0,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  expansionTile(
                      Icons.grading_outlined,
                      (language == "English")
                          ? english['Habit of a week']
                          : (language == "Slovak")
                              ? slovak['Habit of a week']
                              : czech['Habit of a week'],
                      size,
                      Column(
                        children: [
                          GoalField(
                            onTap: () async {
                              print("3");
                              addbutton().then((value) {
                                getdatainit();
                                addDate(habitController.text, "habit");
                                getPercent();
                                getDataaa();
                              });
                            },
                            status: "Habit",
                            suggestions: suggestionStringHabit,

                            controller: habitController,

                            hint: (language == "English")
                                ? english['Habit of week']
                                : (language == "Slovak")
                                    ? slovak['Habit of week']
                                    : czech['Habit of week'],

                            // hint: "Habit of week",
                            numb: 3.0,
                          )
                        ],
                      ),
                      status,
                      context,
                      'habit'),

                  Divider(
                    thickness: 2.0,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getTitle(icon, text, size, status) {
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
              Icon(
                icon,
                color: colorHeader,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                '$text',
                style: TextStyle(
                    color: colorHeader,
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
              ),
            ],
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (builder) {
                        return ModelSheetCustom(
                          status: status,
                        );
                      });
                },
                child: Icon(
                  Icons.info_outline,
                  color: colorHeader,
                  size: size.width * 0.07,
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Icon(
                Icons.add,
                color: colorHeader,
                size: size.width * 0.08,
              ),
              SizedBox(
                width: 5.0,
              ),
              Icon(
                Icons.keyboard_arrow_down_outlined,
                color: colorHeader,
                size: size.width * 0.08,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getText(txt, size, status) {
    return Padding(
      padding: EdgeInsets.only(
          left: size.width * 0.036,
          right: size.width * 0.036,
          bottom: size.height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$txt",
            style: TextStyle(
                color: colorHeader,
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0),
          ),
          InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (builder) {
                      return ModelSheetCustom(
                        status: status,
                      );
                    });
              },
              child: Icon(
                Icons.info_outline,
                color: colorHeader,
              ))
        ],
      ),
    );
  }
}
