import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:personal_dairy/Screens/Authentication/main_auth.dart';
import 'package:personal_dairy/Screens/bottom.dart';
import 'package:personal_dairy/utils/constants.dart';
import 'package:personal_dairy/widgets/customtextfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_scroll/text_scroll.dart';

var language = "English";
var status;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configLoading();

  runApp(MyApp());
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  prefs.setString("date", "$formattedDate");
  status = prefs.getBool("isloggedin");
  print(status);

  runApp(MyApp());
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 3000)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = colorHeader
    ..backgroundColor = Colors.transparent
    ..indicatorColor = colorHeader
    ..textColor = Colors.blue
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = true;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Diary',
      builder: EasyLoading.init(),

      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(),
      home: status == null ? MainAuth() : BottomBar(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DatePickerController _controller = DatePickerController();
  TextEditingController goalofweek = TextEditingController();
  TextEditingController pleasureofweek = TextEditingController();

  TextEditingController Graditude = TextEditingController();

  TextEditingController priority = TextEditingController();

  TextEditingController todays = TextEditingController();

  TextEditingController function = TextEditingController();
  String? goal, pleas;

  DateTime _selectedValue = DateTime.now();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool? datacheck;

  @override
  void initState() {
    getdata2(Date: _selectedValue.toString().substring(0, 10)).then((value) {
      goal = goalofweek.text.toString();
      pleas = pleasureofweek.text.toString();
      print("inits");
      print(goal);
      print(pleas);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[100],
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.replay),
          onPressed: () {
            _controller.animateToSelection();
          },
        ),
        appBar: AppBar(
          title: const Text("Daily task"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // const Text("You Selected:"),
                // const Padding(
                //   padding: EdgeInsets.all(10),
                // ),
                // Text(_selectedValue.toString().substring(0, 10)),

                const Padding(
                  padding: EdgeInsets.all(20),
                ),
                Container(
                  child: DatePicker(
                    DateTime.now(),
                    width: 80,
                    height: 120,
                    controller: _controller,
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Colors.blueAccent,
                    selectedTextColor: Colors.white,
                    inactiveDates: const [
                      // DateTime.now().add(const Duration(days: 3)),
                      // DateTime.now().add(const Duration(days: 4)),
                      // DateTime.now().add(const Duration(days: 7))
                    ],
                    onDateChange: (date) {
                      // New date selected

                      setState(() {
                        FocusScope.of(context).unfocus();

                        _selectedValue = date;
                        print(
                            " _selectedValue.day.toString()${_selectedValue.weekday}");
                        getdata2(
                            Date: _selectedValue.toString().substring(0, 10));
                      });
                    },
                  ),
                ),
                SizedBox(
                    // height: 100.h,
                    width: 380,
                    child: CustomTextField(
                      textEditingController: goalofweek,
                      height: 800,
                      maxlines: 1,
                      hintTitle: "Goal of the week",
                    )),
                SizedBox(
                    // height: 100.h,
                    width: 380,
                    child: CustomTextField(
                      textEditingController: pleasureofweek,
                      height: 800,
                      maxlines: 1,
                      hintTitle: "Pleasure of Week",
                    )),
                SizedBox(
                    // height: 100R.h,
                    width: 380,
                    child: CustomTextField(
                      textEditingController: Graditude,
                      height: 800,
                      maxlines: 1,
                      hintTitle: "Gratitudes",
                    )),
                SizedBox(
                    // height: 100.h,
                    width: 380,
                    child: CustomTextField(
                      textEditingController: priority,
                      height: 800,
                      maxlines: 1,
                      hintTitle: "Priority",
                    )),
                SizedBox(
                    // height: 100.h,
                    width: 380,
                    child: CustomTextField(
                      textEditingController: todays,
                      height: 800,
                      maxlines: 1,
                      hintTitle: "Todays Programs",
                    )),
                SizedBox(
                    // height: 100.h,
                    width: 380,
                    child: CustomTextField(
                      textEditingController: function,
                      height: 800,
                      maxlines: 1,
                      hintTitle: "Function",
                    )),
                const SizedBox(
                  height: 30,
                ),
                // field(
                //     title: goalofweek.text.toString() != ""
                //         ? goalofweek.text.toString()
                //         : "goal of week"),
                // field(
                //     title: pleasureofweek.text.toString() != ""
                //         ? pleasureofweek.text.toString()
                //         : "Pleasure of Week"),
                // field(
                //     title: Graditude.text.toString() != ""
                //         ? Graditude.text.toString()
                //         : "Gratitudes"),
                // field(
                //     title: priority.text.toString() != ""
                //         ? priority.text.toString()
                //         : "Priority"),
                // field(
                //     title: todays.text.toString() != ""
                //         ? todays.text.toString()
                //         : "Todays Programs"),
                // field(
                //     title: function.text.toString() != ""
                //         ? function.text.toString()
                //         : "Function"),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () async {
                    print(datacheck);
                    FocusScope.of(context).unfocus();
                    if (datacheck == false) {
                      List dates = [];
                      var newdate = _selectedValue;

                      for (int i = 1; i <= 7; ++i) {
                        print(i);
                        if (i == 1) {
                          newdate = DateTime(
                              newdate.year, newdate.month, newdate.day);
                          dates.add(
                            newdate.toString().substring(0, 10),
                          );

                          continue;
                        }
                        newdate = DateTime(
                            newdate.year, newdate.month, newdate.day + 1);

                        dates.add(
                          newdate.toString().substring(0, 10),
                        );
                      }

                      for (int i = 0; i < 7; i++) {
                        print(dates[i]);
                        if (i == 0) {
                          Map<String, dynamic> data = {
                            "goalofweek": goalofweek.text.toString(),
                            "pleasureofweek": pleasureofweek.text.toString(),
                            "Gratitiude": Graditude.text.toString(),
                            "Priority": priority.text.toString(),
                            "Todays_program": todays.text.toString(),
                            "Function": function.text.toString(),
                            "dates": FieldValue.arrayUnion(dates)
                          };
                          adddata(Date: dates[i], data: data).then((value) {});
                        } else {
                          Map<String, dynamic> data = {
                            "goalofweek": goalofweek.text.toString(),
                            "pleasureofweek": pleasureofweek.text.toString(),
                            "Gratitiude": "",
                            "Priority": "",
                            "Todays_program": "",
                            "Function": "",
                            "dates": FieldValue.arrayUnion(dates)
                          };

                          adddata(Date: dates[i], data: data).then((value) {
                            print("add$i");

                            if (i == 6) {
                              print("closs$i");

                              EasyLoading.dismiss();
                              setState(() {});
                            }
                          });
                        }
                      }
                    } else if (datacheck == true) {
                      EasyLoading.show();
                      final List dates = [];
                      print("tap");
                      await _firestore
                          .collection("user")
                          .doc(
                            _selectedValue.toString().substring(0, 10),
                          )
                          .get()
                          .then((value) {
                        DocumentSnapshot data = value;
                        print(data["dates"]);
                        dates.addAll(data["dates"]);
                        print(dates);
                      });

                      print(dates.length);
                      Map<String, dynamic> data = {
                        "goalofweek": goalofweek.text.toString(),
                        "pleasureofweek": pleasureofweek.text.toString(),
                      };
                      if (goal != goalofweek.text.toString() ||
                          pleas != pleasureofweek.text.toString()) {
                        for (int i = 0; i < dates.length; ++i) {
                          print(i);

                          print(dates[i]);
                          update(Date: dates[i], data: data);
                          print("clossssss$i");

                          if (i == 6) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Updated Successfully"),
                            ));
                            EasyLoading.dismiss();
                            setState(() {});
                          }
                        }
                      } else {
                        Map<String, dynamic> data = {
                          "Gratitiude": Graditude.text.toString(),
                          "Priority": priority.text.toString(),
                          "Todays_program": todays.text.toString(),
                          "Function": function.text.toString(),
                        };
                        update(
                                Date:
                                    _selectedValue.toString().substring(0, 10),
                                data: data)
                            .then((value) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Updated Successfully"),
                          ));
                          EasyLoading.dismiss();

                          setState(() {});
                        });
                      }
                    }
                  },
                  child: Container(
                      height: 50,
                      width: 100,
                      color: Colors.blue,
                      child: const Center(
                        child: Text(
                          "Add",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     datacheck == false
                //         ? InkWell(
                //             onTap: () {
                //               Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) => Update(
                //                         _selectedValue,
                //                         _selectedValue
                //                             .toString()
                //                             .substring(0, 10),
                //                         false,
                //                         goalofweek.text,
                //                         pleasureofweek.text,
                //                         Graditude.text,
                //                         priority.text,
                //                         todays.text,
                //                         function.text)),
                //               );
                //             },
                //             child: Container(
                //                 height: 50,
                //                 width: 100,
                //                 color: Colors.blue,
                //                 child: const Center(
                //                   child: Text(
                //                     "Add",
                //                     style: TextStyle(
                //                         color: Colors.white,
                //                         fontWeight: FontWeight.bold,
                //                         fontSize: 15),
                //                   ),
                //                 )),
                //           )
                //         : InkWell(
                //             onTap: () {
                //               Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) => Update(
                //                         _selectedValue,
                //                         _selectedValue
                //                             .toString()
                //                             .substring(0, 10),
                //                         true,
                //                         goalofweek.text,
                //                         pleasureofweek.text,
                //                         Graditude.text,
                //                         priority.text,
                //                         todays.text,
                //                         function.text)),
                //               );
                //             },
                //             child: Container(
                //                 height: 50,
                //                 width: 100,
                //                 color: Colors.blue,
                //                 child: const Center(
                //                   child: Text(
                //                     "Update",
                //                     style: TextStyle(
                //                         color: Colors.white,
                //                         fontWeight: FontWeight.bold,
                //                         fontSize: 15),
                //                   ),
                //                 )),
                //           ),
                //   ],
                // ),
              ],
            ),
          ),
        ));
  }

  Future<void> getdata2({
    required String Date,
  }) async {
    EasyLoading.show();
    await _firestore.collection("user").doc(Date).get().then((value) {
      print(value);

      print("dataaa${value.exists}");
      if (value.exists == false) {
        print("Empty");
        datacheck = false;
        goalofweek.clear();
        pleasureofweek.clear();
        Graditude.clear();
        priority.clear();
        todays.clear();
        function.clear();
        setState(() {});
        EasyLoading.dismiss();
      } else {
        DocumentSnapshot data = value;
        datacheck = true;

        print(data);
        print(data["Function"]);
        goalofweek.text = data["goalofweek"];
        pleasureofweek.text = data["pleasureofweek"];
        Graditude.text = data["Gratitiude"];

        priority.text = data["Priority"];

        todays.text = data["Todays_program"];

        function.text = data["Function"];
        setState(() {});
        EasyLoading.dismiss();
      }
      // print(data["goalofweek"]);
    });
  }

  Future<void> adddata(
      {required String Date, required Map<String, dynamic> data}) async {
    EasyLoading.show();
    print(Date);

    await _firestore.collection("user").doc(Date).set(data).then((value) {
      print("added");
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text("Add Successfully"),
      // ));
    });
  }

  Future<void> update(
      {required String Date, required Map<String, dynamic> data}) async {
    // EasyLoading.show();
    await _firestore.collection("user").doc(Date).update(data).then((value) {
      print("updated");
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text("Update Successfully"),
      // ));
      // EasyLoading.dismiss();
    });
  }
}

class field extends StatelessWidget {
  const field({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 55,
        // width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: TextScroll(
                        title,
                        // mode: TextScrollMode.bouncing,
                        velocity:
                            const Velocity(pixelsPerSecond: Offset(50, 0)),
                        delayBefore: const Duration(milliseconds: 500),
                        numberOfReps: 5,
                        pauseBetween: const Duration(milliseconds: 50),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                        selectable: true,
                        intervalSpaces: 10,
                      ),
                    ),

                    // text(
                    //   title: title,
                    //   size: 14,
                    //   maxline: 1,
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
