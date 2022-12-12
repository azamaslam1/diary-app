import 'dart:convert';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_dairy/Screens/journal_screen.dart';
import 'package:personal_dairy/Screens/new_main.dart';
import 'package:personal_dairy/Screens/routines.dart';
import 'package:personal_dairy/utils/constants.dart';

import '../main.dart';
import 'Authentication/main_auth.dart';
import 'goal_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;
  late PageController _pageController;

  load() async {
    String data = await rootBundle.loadString('assets/jsons/en.json');
    Map<String, dynamic> _resultEn = json.decode(data);
    String dataCZ = await rootBundle.loadString('assets/jsons/czech.json');
    Map<String, dynamic> _resultCZ = json.decode(dataCZ);
    String dataSL = await rootBundle.loadString('assets/jsons/slovak.json');
    Map<String, dynamic> _resultSL = json.decode(dataSL);
    english = _resultEn;
    czech = _resultCZ;
    slovak = _resultSL;
    setState(() {});
    loader = true;
    print(english);
  }

  @override
  void initState() {
    load();
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  static const List<Widget> _widgetOptions = [
    MainScreenNew(),

    GoalScreen(),

    Routines(),
    JournalScreen(),
    // Text('Search Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    // Text('Profile Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: _widgetOptions),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        child: BottomNavyBar(
          selectedIndex: _currentIndex,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          onItemSelected: (index) => setState(() {
            _currentIndex = index;
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.ease);
          }),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: Icon(
                Icons.calendar_today,
                color: colorHeader,
              ),
              title: Text(
                (language == "English")
                    ? english['Action']
                    : (language == "Slovak")
                        ? slovak['Action']
                        : czech['Action'],
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
              ),
              activeColor: colorHeader,
            ),
            BottomNavyBarItem(
              icon: Image.asset(
                'assets/goal.png',
                color: colorHeader,
                width: 30.0,
              ),
              title: Text(
                (language == "English")
                    ? english['Growth']
                    : (language == "Slovak")
                        ? slovak['Growth']
                        : czech['Growth'],
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
              ),
              activeColor: colorHeader,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Image.asset(
                'assets/todo.png',
                color: colorHeader,
                width: 30.0,
              ),
              title: Text(
                (language == "English")
                    ? english['Completion']
                    : (language == "Slovak")
                        ? slovak['Completion']
                        : czech['Completion'],
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
              ),
              activeColor: colorHeader,
            ),
            BottomNavyBarItem(
              icon: Image.asset(
                'assets/journal.png',
                color: colorHeader,
                width: 25.0,
              ),
              title: Text(
                (language == "English")
                    ? english['Journal']
                    : (language == "Slovak")
                        ? slovak['Journal']
                        : czech['Journal'],
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
              ),
              activeColor: colorHeader,
            ),
          ],
        ),
      ),
    );
  }
}
