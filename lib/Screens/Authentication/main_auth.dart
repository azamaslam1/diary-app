// ignore_for_file: prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_dairy/Screens/Authentication/Login_screen.dart';
import 'package:personal_dairy/Screens/Authentication/signup_screen.dart';
import 'package:personal_dairy/main.dart';
import 'package:personal_dairy/utils/constants.dart';

import '../../widgets/custom_loading_indicator.dart';

var english;
var czech;
var slovak;
var loader = false;

class MainAuth extends StatefulWidget {
  const MainAuth({Key? key}) : super(key: key);

  @override
  State<MainAuth> createState() => _MainAuthState();
}

class _MainAuthState extends State<MainAuth> with TickerProviderStateMixin {
  late TabController _tabController;

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
    print(english);
    print("dfdf");
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return (loader == true)
        ? Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: colorHeader,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(size.height * 0.1),
                child: TabBar(
                  indicatorColor: colorHeader,
                  unselectedLabelColor: Colors.white.withOpacity(0.4),
                  labelColor: Colors.white,
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                      color: colorHeader,
                      fontSize: size.width * 0.05),
                  tabs: [
                    Tab(
                      text: (language == "English")
                          ? english['Login']
                          : (language == "Slovak")
                              ? slovak['Login']
                              : czech['Login'],
                    ),
                    Tab(
                      text: (language == "English")
                          ? english['Create Account']
                          : (language == "Slovak")
                              ? slovak['Create Account']
                              : czech['Create Account'],
                    ),
                  ],
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
              ),
            ),
            backgroundColor: bgColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      height: size.height * 0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: size.width * 0.03,
                                  right: size.width * 0.03,
                                  top: size.height * 0.01),
                              child: Container(
                                child: TabBarView(
                                  children: [
                                    LoginScreen(),
                                    Signup(),
                                  ],
                                  controller: _tabController,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          )
        : Scaffold(
            body: Container(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: bgColor,
                ),
                width: 32,
                height: 32),
          );
  }

  void showLoadingIndicator(String text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              backgroundColor: colorHeader,
              content: LoadingIndicator(text: text),
            ));
      },
    );
  }
}
