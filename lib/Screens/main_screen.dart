import 'package:flutter/material.dart';
import 'package:personal_dairy/utils/constants.dart';
import 'package:personal_dairy/widgets/custom_field.dart';
import 'package:personal_dairy/widgets/goal_field.dart';
import 'package:personal_dairy/widgets/header.dart';

import '../widgets/bottom_sheet.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: bgColor,
        drawer: Drawer(),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60), child: CustomHeader()),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: size.height * 0.4,
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
                            text: '1st Goal of the week',
                          ),
                          Tab(
                            text: '2nd Goal of the week',
                          ),
                          Tab(
                            text: '3rd Goal of the week',
                          ),
                        ],
                        controller: _tabController,
                        indicatorSize: TabBarIndicatorSize.tab,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: size.width * 0.03,
                              right: size.width * 0.03,
                              top: size.height * 0.01),
                          child: Container(
                            child: TabBarView(
                              children: [
                                GoalField(
                                  numb: 'first',
                                ),
                                GoalField(
                                  numb: 'second',
                                ),
                                GoalField(
                                  numb: 'third',
                                ),
                              ],
                              controller: _tabController,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              getText("Gratitudes", size),
              CustomFields(
                hint: "Gratitude - 1",
                icon: Icons.star,
              ),
              CustomFields(
                hint: "Gratitude - 2",
                icon: Icons.star,
              ),
              CustomFields(
                hint: "Gratitude - 3",
                icon: Icons.star,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              getText("Morning Rituals", size),
              CustomFields(
                hint: "Morning Rituals",
                icon: Icons.sunny,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              getText("Evening Rituals", size),
              CustomFields(
                hint: "Evening Rituals",
                icon: Icons.nightlight_round,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              getText("Bottom Priority", size),
              CustomFields(
                hint: "Bottom Priority",
                icon: Icons.low_priority_rounded,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              getText("3 Successes", size),
              CustomFields(
                hint: "3 Successes",
                icon: Icons.mediation,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              getText("How was my day", size),
              CustomFields(
                hint: "Type...",
                icon: Icons.mediation,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              getText("What he taught me today", size),
              CustomFields(
                hint: "Type...",
                icon: Icons.mediation,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              getText("What would i do differently", size),
              CustomFields(
                hint: "Type...",
                icon: Icons.mediation,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              getText("Personal number", size),
              CustomFields(
                hint: "Type...",
                icon: Icons.mediation,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              getText("Business number", size),
              CustomFields(
                hint: "Type...",
                icon: Icons.mediation,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              getText("Habit of the week", size),
              CustomFields(
                hint: "Type...",
                icon: Icons.mediation,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              getText("Motivation quotes", size),
              CustomFields(
                hint: "Type...",
                icon: Icons.mediation,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              getText("How I felt today", size),
              CustomFields(
                hint: "Type...",
                icon: Icons.mediation,
              ),
            ],
          ),
        ));
  }

  Widget getText(txt, size) {
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
                color: Colors.black,
                fontSize: size.width * 0.05,
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
