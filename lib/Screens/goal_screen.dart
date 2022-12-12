import 'package:flutter/material.dart';
import 'package:personal_dairy/Screens/goals/goal_boards.dart';
import 'package:personal_dairy/Screens/goals/rituals.dart';
import 'package:personal_dairy/Screens/goals/who_i_am.dart';
import 'package:suggestion_textfield/suggestion_textfield.dart';

import '../main.dart';
import '../utils/constants.dart';
import '../widgets/header.dart';
import 'Authentication/main_auth.dart';
import 'new_main.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({Key? key}) : super(key: key);

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late TabController _tabControllerPhone;
  late TabController _tabControllerGoal;
  late TabController _tabControllerRituals;
  late TabController _tabControllerPleasure;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
    _tabControllerPhone = new TabController(length: 2, vsync: this);
    _tabControllerGoal = new TabController(length: 3, vsync: this);
    _tabControllerRituals = new TabController(length: 2, vsync: this);
    _tabControllerPleasure = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.2),
        child: CustomHeader(
          percent: percent,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: size.width * 0.03,
            right: size.width * 0.03,
            top: size.height * 0.01),
        child: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WhoIAm()));
                },
                child: Card(
                  elevation: 5.0,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0)),
                    width: size.width,
                    height: size.height * 0.08,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          (language == "English")
                              ? english['Who Am I?']
                              : (language == "Slovak")
                                  ? slovak['Who Am I?']
                                  : czech['Who Am I?'],
                          style: TextStyle(
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              color: colorHeader),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GoalBords()));
                },
                child: Card(
                  elevation: 5.0,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0)),
                    width: size.width,
                    height: size.height * 0.08,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          (language == "English")
                              ? english['Goal boards']
                              : (language == "Slovak")
                                  ? slovak['Goal boards']
                                  : czech['Goal boards'],
                          style: TextStyle(
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              color: colorHeader),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyRituals()));
                },
                child: Card(
                  elevation: 5.0,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0)),
                    width: size.width,
                    height: size.height * 0.08,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          (language == "English")
                              ? english['My Rituals']
                              : (language == "Slovak")
                                  ? slovak['My Rituals']
                                  : czech['My Rituals'],
                          style: TextStyle(
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              color: colorHeader),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Card(
                elevation: 5.0,
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                  width: size.width,
                  height: size.height * 0.08,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        (language == "English")
                            ? english['My Fitness data']
                            : (language == "Slovak")
                                ? slovak['My Fitness data']
                                : czech['My Fitness data'],
                        style: TextStyle(
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                            color: colorHeader),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class NewGoalField extends StatefulWidget {
  final suggestedString;
  final controller;
  final onTap;
  final hint;

  const NewGoalField(
      {Key? key, this.suggestedString, this.controller, this.hint, this.onTap})
      : super(key: key);

  @override
  State<NewGoalField> createState() => _NewGoalFieldState();
}

class _NewGoalFieldState extends State<NewGoalField> {
  @override
  Widget build(BuildContext context) {
    return AutoSuggestionTextField(
        textFieldInputDecoration: InputDecoration(
          prefixIcon: InkWell(onTap: widget.onTap, child: Icon(Icons.add)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorHeader),
              borderRadius: BorderRadius.circular(14.0)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorHeader),
              borderRadius: BorderRadius.circular(14.0)),
          contentPadding: EdgeInsets.all(60.0),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: colorHeader),
              borderRadius: BorderRadius.circular(14.0)),
          hintText: widget.hint,
        ),
        textController: widget.controller,
        suggestionStrings: widget.suggestedString,
        onValueChanged: (val) {});
  }
}
