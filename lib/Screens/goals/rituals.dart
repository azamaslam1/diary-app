import 'package:flutter/material.dart';

import '../../main.dart';
import '../../utils/constants.dart';
import '../../widgets/bottom_sheet.dart';
import '../../widgets/goal_field.dart';
import '../Authentication/main_auth.dart';

class MyRituals extends StatefulWidget {
  const MyRituals({Key? key}) : super(key: key);

  @override
  State<MyRituals> createState() => _MyRitualsState();
}

class _MyRitualsState extends State<MyRituals> with TickerProviderStateMixin {
  late TabController _tabControllerRituals;
  var myFieldsEve = [];
  var myFields = [];
  var myControllers = [];
  var textController = TextEditingController();

  var myControllersEve = [];

  createControllers() {
    myControllers = [];
    for (var i = 0; i < myFields.length; i++) {
      myControllers.add(TextEditingController());
    }
  }

  initializeField() {
    myControllers.add(TextEditingController());
    myFields.add(GoalField(
        iconbin: SizedBox,
        status: "Rituals",
        onTap: () {
          print("fedwfwe");
          print(myControllers[0].text);
        },
        hint: (language == "English")
            ? english['Morning']
            : (language == "Slovak")
                ? slovak['Morning']
                : czech['Morning'],
        numb: 5,
        controller: myControllers[myControllers.length - 1]));
  }

  @override
  void initState() {
    super.initState();
    initializeField();
    // myControllers.add(textController);
    // myControllersEve.add(TextEditingController());
    // myFields.add(GoalField(hint: (language=="English")? english['Morning']:(language=="Slovak")?slovak['Morning']:czech['Morning'],numb: 5,controller: textController,));
    myFieldsEve.add(GoalField(
      hint: (language == "English")
          ? english['Evening']
          : (language == "Slovak")
              ? slovak['Evening']
              : czech['Evening'],
      numb: 5,
      controller: textController,
    ));
    _tabControllerRituals = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorHeader,
        onPressed: () {
          if (_tabControllerRituals.index == 0) {
            myFields.add(GoalField(
              hint: (language == "English")
                  ? english['Morning']
                  : (language == "Slovak")
                      ? slovak['Morning']
                      : czech['Morning'],
              numb: 5,
              iconbin: Icons.delete,
              controller: textController,
            ));
            myControllers.add(textController);
          } else {
            myFieldsEve.add(GoalField(
              hint: (language == "English")
                  ? english['Evening']
                  : (language == "Slovak")
                      ? slovak['Evening']
                      : czech['Evening'],
              numb: 5,
              iconbin: Icons.delete,
            ));
          }
          setState(() {});
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: colorHeader,
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: Text(
          (language == "English")
              ? english['My Rituals']
              : (language == "Slovak")
                  ? slovak['My Rituals']
                  : czech['My Rituals'],
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              getText(
                  (language == "English")
                      ? english['Rituals']
                      : (language == "Slovak")
                          ? slovak['Rituals']
                          : czech['Rituals'],
                  size),
              Container(
                  height: size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TabBar(
                        indicatorColor: colorHeader,
                        unselectedLabelColor: Colors.black,
                        labelColor: Colors.red,
                        labelStyle: TextStyle(
                            color: colorHeader, fontSize: size.width * 0.03),
                        tabs: [
                          Tab(
                            text: (language == "English")
                                ? english['Morning Rituals']
                                : (language == "Slovak")
                                    ? slovak['Morning Rituals']
                                    : czech['Morning Rituals'],
                          ),
                          Tab(
                            text: (language == "English")
                                ? english['Evening Rituals']
                                : (language == "Slovak")
                                    ? slovak['Evening Rituals']
                                    : czech['Evening Rituals'],
                          ),
                        ],
                        controller: _tabControllerRituals,
                        indicatorSize: TabBarIndicatorSize.tab,
                      ),
                      Expanded(
                        child: Container(
                          child: TabBarView(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: myFields.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return myFields[index];
                                  },
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: myFieldsEve.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return myFieldsEve[index];
                                  },
                                ),
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
        ),
      ),
    );
  }

  Widget getText(txt, size) {
    return Padding(
      padding: EdgeInsets.only(
          left: size.width * 0.036,
          right: size.width * 0.036,
          bottom: size.height * 0.02,
          top: size.height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$txt",
            style: TextStyle(
                color: Colors.black,
                fontSize: size.width * 0.06,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0),
          ),
          InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (builder) {
                      return ModelSheetCustom();
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
