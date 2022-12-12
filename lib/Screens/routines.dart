// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_dairy/Screens/new_main.dart';

import '../main.dart';
import '../utils/constants.dart';
import '../widgets/custom_box.dart';
import '../widgets/expansion_tile.dart';
import '../widgets/header.dart';
import 'Authentication/main_auth.dart';

class Routines extends StatefulWidget {
  const Routines({Key? key}) : super(key: key);

  @override
  State<Routines> createState() => _RoutinesState();
}

class _RoutinesState extends State<Routines> {
  User? user = FirebaseAuth.instance.currentUser;
  SearchService _searchService = SearchService();
  List<Map> search = <Map>[];

  @override
  void initState() {
    getDocs();
    super.initState();
  }

  Future getDocs() async {
    search = (await _searchService.getSearch())
        .map((item) => item.data)
        .cast<Map>()
        .toList();
    setState(() {});
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
            )),
        body: Padding(
          padding: EdgeInsets.only(
              left: size.width * 0.03,
              right: size.width * 0.03,
              top: size.height * 0.01),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: size.height * 0.06,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search...",
                      prefixIcon: Icon(
                        Icons.search,
                        color: colorHeader,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          color: colorHeader,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: colorHeader),
                      ),
                    ),
                  ),
                ),
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
                    Icons.sunny,
                    (language == "English")
                        ? english['Morning']
                        : (language == "Slovak")
                            ? slovak['Morning']
                            : czech['Morning'],
                    size,
                    CustomBox(
                      title: (language == "English")
                          ? english['Work Hard']
                          : (language == "Slovak")
                              ? slovak['Work Hard']
                              : czech['Work Hard'],
                      color: Colors.grey,
                      trailing: '5:05pm',
                      lead: "1 time per day",
                      icon2: "assets/clock.png",
                    ),
                    false,
                    context,
                    ''),
                SizedBox(
                  height: 5.0,
                ),
                Divider(
                  thickness: 2.0,
                ),
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
                    Icons.sunny_snowing,
                    (language == "English")
                        ? english['Afternoon']
                        : (language == "Slovak")
                            ? slovak['Afternoon']
                            : czech['Afternoon'],
                    size,
                    CustomBox(
                      title: "Eat lunch",
                      color: Colors.grey,
                      trailing: 'Afternoon',
                      lead: "1 time per day",
                      icon2: "assets/clock.png",
                    ),
                    true,
                    context,
                    ''),
                SizedBox(
                  height: 5.0,
                ),
                Divider(
                  thickness: 2.0,
                ),
                SizedBox(
                  height: 5.0,
                ),
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
                    Icons.nightlight_round,
                    (language == "English")
                        ? english['Evening']
                        : (language == "Slovak")
                            ? slovak['Evening']
                            : czech['Evening'],
                    size,
                    CustomBox(
                      title: "Date with Spouse",
                      color: Colors.grey,
                      trailing: 'Evening',
                      lead: "2 times a week",
                      icon2: "assets/spouse.png",
                    ),
                    false,
                    context,
                    ''),
                SizedBox(
                  height: 5.0,
                ),
                Divider(
                  thickness: 2.0,
                ),
                SizedBox(
                  height: 5.0,
                ),
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
                    Icons.calendar_today_rounded,
                    (language == "English")
                        ? english['AnyTime']
                        : (language == "Slovak")
                            ? slovak['AnyTime']
                            : czech['AnyTime'],
                    size,
                    CustomBox(
                      title: "Anytime",
                      color: Colors.grey,
                      trailing: 'Evening',
                      lead: "2 times a week",
                      icon2: "assets/food.png",
                    ),
                    false,
                    context,
                    ''),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static getSuggestion(String suggestion) async => FirebaseFirestore.instance
          .collection('userdata')
          .where('feelings', isEqualTo: '2')
          .get()
          .then((val) {
        print('Document data: ${val.docs.length}');

        return val.docs;
      });
}

class SearchService {
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = 'userdata';

  Future<List<DocumentSnapshot>> getSearch() async =>
      await _firestore.collection(ref).get().then((snaps) {
        return snaps.docs;
      });

  Future<List<DocumentSnapshot>> getuserSearch() async =>
      await _firestore.collection('userdata').get().then((snaps) {
        return snaps.docs;
      });

  Future<List<DocumentSnapshot>> getSuggestion(String suggestion) async =>
      await _firestore
          .collection(ref)
          .where('uid', isEqualTo: user?.uid)
          .where('feelings', isEqualTo: suggestion)
          .get()
          .then((snap) {
        print('dw');
        print(snap.docs.length);
        return snap.docs;
      });
}
