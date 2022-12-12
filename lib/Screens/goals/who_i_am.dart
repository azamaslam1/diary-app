// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:personal_dairy/Screens/Controllers/services_storage.dart';
import 'package:personal_dairy/widgets/expansion_tile.dart';
import 'package:personal_dairy/widgets/goal_field.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../main.dart';
import '../../utils/constants.dart';
import '../../widgets/bottom_sheet.dart';
import '../../widgets/custom_loading_indicator.dart';
import '../Authentication/main_auth.dart';
import '../new_main.dart';

class WhoIAm extends StatefulWidget {
  const WhoIAm({Key? key}) : super(key: key);

  @override
  State<WhoIAm> createState() => _WhoIAmState();
}

class _WhoIAmState extends State<WhoIAm> with TickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController whyIamHere = TextEditingController();
  TextEditingController whoami = TextEditingController();
  TextEditingController whatismylife = TextEditingController();
  TextEditingController whatidesire = TextEditingController();
  TextEditingController whatwouldireally = TextEditingController();
  TextEditingController whatwouldidoif = TextEditingController();
  TextEditingController whyisitreally = TextEditingController();
  TextEditingController whodoispend = TextEditingController();
  TextEditingController whodoiwant = TextEditingController();
  TextEditingController whodoiwanto = TextEditingController();
  TextEditingController whatquality = TextEditingController();
  TextEditingController whatdoicare = TextEditingController();
  TextEditingController whatdoesmyday = TextEditingController();
  TextEditingController amonth = TextEditingController();
  TextEditingController ayear = TextEditingController();
  TextEditingController doesthisexpress = TextEditingController();
  TextEditingController doesthisexpresso = TextEditingController();
  TextEditingController whatiseasy = TextEditingController();
  TextEditingController whatdoilove = TextEditingController();
  TextEditingController whatsholding = TextEditingController();
  TextEditingController whatdoinot = TextEditingController();
  TextEditingController whichactivity = TextEditingController();
  TextEditingController whatcanidelegate = TextEditingController();
  TextEditingController whatvalues = TextEditingController();
  TextEditingController whenandhow = TextEditingController();
  var whyIamHerestatus = false;
  var whoamistatus = false;
  var whatismylifestatus = false;
  var whatidesirestatus = false;
  var whatwouldireallystatus = false;
  var whatwouldidoifstatus = false;
  var whyisitreallystatus = false;
  var whodoispendstatus = false;
  var whodoiwantstatus = false;
  var whodoiwantostatus = false;
  final ScrollController scrollcontroller = ScrollController();

  var whatqualitystatus = false;
  var whatdoicarestatus = false;
  var whatdoesmydaystatus = false;
  var amonthstatus = false;
  var ayearstatus = false;
  var doesthisexpressstatus = false;
  var doesthisexpressostatus = false;
  var whatiseasystatus = false;
  var whatdoilovestatus = false;
  var whatsholdingstatus = false;
  var whatdoinotstatus = false;
  var whichactivitystatus = false;
  var whatcanidelegatestatus = false;
  var whatvaluesstatus = false;
  var whenandhowstatus = false;

  void getData() async {
    var whoiamtext = (language == "English")
        ? english['Who Am I?']
        : (language == "Slovak")
            ? slovak['Who Am I?']
            : czech['Who Am I?'];
    var whenandhowtext = (language == "English")
        ? english['When and how will I know that they are filled?']
        : (language == "Slovak")
            ? slovak['When and how will I know that they are filled?']
            : czech['When and how will I know that they are filled?'];
    var whatvaluestext = (language == "English")
        ? english['What values are important to me in my life?']
        : (language == "Slovak")
            ? slovak['What values are important to me in my life?']
            : czech['What values are important to me in my life?'];
    var whatcanidelegatetext = (language == "English")
        ? english['What can I delegate/sell/ask someone for help with?']
        : (language == "Slovak")
            ? slovak['What can I delegate/sell/ask someone for help with?']
            : czech['What can I delegate/sell/ask someone for help with?'];
    var whichactivtext = (language == "English")
        ? english[
            'Which activities/habits are taking me away from my dreams and goals?']
        : (language == "Slovak")
            ? slovak[
                'Which activities/habits are taking me away from my dreams and goals?']
            : czech[
                'Which activities/habits are taking me away from my dreams and goals?'];
    var whatdoinottext = (language == "English")
        ? english['What do I not want to do?']
        : (language == "Slovak")
            ? slovak['What do I not want to do?']
            : czech['What do I not want to do?'];
    var whatisholdintext = (language == "English")
        ? english['What is holding me back? What is wrong with me?']
        : (language == "Slovak")
            ? slovak['What is holding me back? What is wrong with me?']
            : czech['What is holding me back? What is wrong with me?'];
    var whatdoilovetext = (language == "English")
        ? english[
            'What do I love, what is my passion? Why do I forget the time?']
        : (language == "Slovak")
            ? slovak[
                'What do I love, what is my passion? Why do I forget the time?']
            : czech[
                'What do I love, what is my passion? Why do I forget the time?'];
    var whatiseasytext = (language == "English")
        ? english['What is easy for me?']
        : (language == "Slovak")
            ? slovak['What is easy for me?']
            : czech['What is easy for me?'];
    var doesthisexpresstexto = (language == "English")
        ? english['Does this express my house, apraca friends?']
        : (language == "Slovak")
            ? slovak['Does this express my house, apraca friends?']
            : czech['Does this express my house, apraca friends?'];
    var doesthisexpresstext = (language == "English")
        ? english['Does this express my house, apraca friends?']
        : (language == "Slovak")
            ? slovak['Does this express my house, apraca friends?']
            : czech['Does this express my house, apraca friends?'];
    var yeartext = (language == "English")
        ? english['A Year']
        : (language == "Slovak")
            ? slovak['A Year']
            : czech['A Year'];
    var amonthtext = (language == "English")
        ? english['A month']
        : (language == "Slovak")
            ? slovak['A month']
            : czech['A month'];
    var whatdoesmytext = (language == "English")
        ? english['What does my day look like?']
        : (language == "Slovak")
            ? slovak['What does my day look like?']
            : czech['What does my day look like?'];
    var whatdoicaretext = (language == "English")
        ? english['What do I care about?']
        : (language == "Slovak")
            ? slovak['What do I care about?']
            : czech['What do I care about?'];
    var whatqualityoftext = (language == "English")
        ? english['What quality of life do I want?']
        : (language == "Slovak")
            ? slovak['What quality of life do I want?']
            : czech['What quality of life do I want?'];
    var whodoitext = (language == "English")
        ? english['Who do I want to spend time with and why?']
        : (language == "Slovak")
            ? slovak['Who do I want to spend time with and why?']
            : czech['Who do I want to spend time with and why?'];
    var whatdoiwantotext = (language == "English")
        ? english['Who do I want to spend time with and why?']
        : (language == "Slovak")
            ? slovak['Who do I want to spend time with and why?']
            : czech['Who do I want to spend time with and why?'];
    var whatdoispendtext = (language == "English")
        ? english['Who do I spend time with now and why?']
        : (language == "Slovak")
            ? slovak['Who do I spend time with now and why?']
            : czech['Who do I spend time with now and why?'];

    var whyiitistext = (language == "English")
        ? english['Why is it really important to me?']
        : (language == "Slovak")
            ? slovak['Why is it really important to me?']
            : czech['Why is it really important to me?'];
    var whatwouldiftext = (language == "English")
        ? english['What would i do if money did not play a role?']
        : (language == "Slovak")
            ? slovak['What would i do if money did not play a role?']
            : czech['What would i do if money did not play a role?'];
    var whatwoulditext = (language == "English")
        ? english['What would I Really Want?']
        : (language == "Slovak")
            ? slovak['What would I Really Want?']
            : czech['What would I Really Want?'];
    var whatidesiretext = (language == "English")
        ? english['What I Desire']
        : (language == "Slovak")
            ? slovak['What I Desire']
            : czech['What I Desire'];
    var whyiamheretext = (language == "English")
        ? english['Why I Am here?']
        : (language == "Slovak")
            ? slovak['Why I Am here?']
            : czech['Why I Am here?'];
    var whatismylifetext = (language == "English")
        ? english['What is my life about?']
        : (language == "Slovak")
            ? slovak['What is my life about?']
            : czech['What is my life about?'];

    var items = [];
    User? user = FirebaseAuth.instance.currentUser;
    var data = await FirebaseFirestore.instance
        .collection("WhoAmI")
        .where('uid', isEqualTo: user?.uid)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach(
        (f) => items.add(f.data()),
      );
    });
    for (int i = 0; i < items.length; i++) {
      if (items[i]['category'] == whoiamtext) {
        whoami.text = items[i]['text'];
      }
      if (items[i]['category'] == whyiamheretext) {
        whyIamHere.text = items[i]['text'];
      }
      if (items[i]['category'] == whatismylifetext) {
        whatismylife.text = items[i]['text'];
      }
      if (items[i]['category'] == whatidesiretext) {
        whatidesire.text = items[i]['text'];
      }
      if (items[i]['category'] == whatwoulditext) {
        whatwouldireally.text = items[i]['text'];
      }
      if (items[i]['category'] == whatwouldiftext) {
        whatwouldidoif.text = items[i]['text'];
      }
      if (items[i]['category'] == whenandhowtext) {
        whenandhow.text = items[i]['text'];
      }
      if (items[i]['category'] == whatvaluestext) {
        whatvalues.text = items[i]['text'];
      }
      if (items[i]['category'] == whatcanidelegatetext) {
        whatcanidelegate.text = items[i]['text'];
      }
      if (items[i]['category'] == whichactivtext) {
        whichactivity.text = items[i]['text'];
      }
      if (items[i]['category'] == whatdoinottext) {
        whatdoinot.text = items[i]['text'];
      }
      if (items[i]['category'] == whatisholdintext) {
        whatsholding.text = items[i]['text'];
      }
      if (items[i]['category'] == whatdoilovetext) {
        whatdoilove.text = items[i]['text'];
      }
      if (items[i]['category'] == whatiseasytext) {
        whatiseasy.text = items[i]['text'];
      }

      if (items[i]['category'] == doesthisexpresstexto) {
        doesthisexpresso.text = items[i]['text'];
      }

      if (items[i]['category'] == doesthisexpresstext) {
        doesthisexpress.text = items[i]['text'];
      }

      if (items[i]['category'] == yeartext) {
        yeartext.text = items[i]['text'];
      }
      if (items[i]['category'] == amonthtext) {
        amonth.text = items[i]['text'];
      }
      if (items[i]['category'] == whatdoesmytext) {
        whatdoesmyday.text = items[i]['text'];
      }

      if (items[i]['category'] == whatdoicaretext) {
        whatdoicare.text = items[i]['text'];
      }
      if (items[i]['category'] == whatqualityoftext) {
        whatquality.text = items[i]['text'];
      }
      if (items[i]['category'] == whodoitext) {
        whodoiwant.text = items[i]['text'];
      }
      if (items[i]['category'] == whatdoiwantotext) {
        whodoiwanto.text = items[i]['text'];
      }

      if (items[i]['category'] == whatdoispendtext) {
        whodoispend.text = items[i]['text'];
      }

      if (items[i]['category'] == whyiitistext) {
        whyisitreally.text = items[i]['text'];
      }
    }
  }

  Widget getTextt(size, text, index) {
    return InkWell(
      onTap: () {
        print('dsa');
        _nextCounter(index);
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          text,
          style: TextStyle(
              decoration: TextDecoration.underline,
              color: colorHeader,
              fontSize: size.width * 0.045,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0),
        ),
      ),
    );
  }

  late AutoScrollController controller;

  @override
  void initState() {
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical);
    getData();
    super.initState();
    _tabController = new TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            (status == false) ? size.height * 0.2 : size.height * 0.15),
        child: (status == false)
            ? AppBar(
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
                      ? english['Who I Am?']
                      : (language == "Slovak")
                          ? slovak['Who I Am?']
                          : czech['Who I Am?'],
                  style: TextStyle(color: Colors.white),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              builder: (builder) {
                                return ModelSheetCustom(
                                  status: 'whoami',
                                );
                              },
                              context: context);
                        },
                        child: Icon(
                          Icons.info_outline,
                          color: bgColor,
                        )),
                  )
                ],
              )
            : Column(
                children: [
                  AppBar(
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
                          ? english['Who I Am?']
                          : (language == "Slovak")
                              ? slovak['Who I Am?']
                              : czech['Who I Am?'],
                      style: TextStyle(color: Colors.white),
                    ),
                    actions: [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  builder: (builder) {
                                    return ModelSheetCustom(
                                      status: 'whoami',
                                    );
                                  },
                                  context: context);
                            },
                            child: Icon(
                              Icons.info_outline,
                              color: bgColor,
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        getTextt(
                            size,
                            (language == "English")
                                ? english['Me']
                                : (language == "Slovak")
                                    ? slovak['Me']
                                    : czech['Me'],
                            0),
                        getTextt(
                            size,
                            (language == "English")
                                ? english['My Relationships']
                                : (language == "Slovak")
                                    ? slovak['My Relationships']
                                    : czech['My Relationships'],
                            1),
                        getTextt(
                            size,
                            (language == "English")
                                ? english['My Lifestyles']
                                : (language == "Slovak")
                                    ? slovak['My Lifestyles']
                                    : czech['My Lifestyles'],
                            2),
                        getTextt(
                            size,
                            (language == "English")
                                ? english['My strengths']
                                : (language == "Slovak")
                                    ? slovak['My strengths']
                                    : czech['My strengths'],
                            3),
                        getTextt(
                            size,
                            (language == "English")
                                ? english['My weaknesses']
                                : (language == "Slovak")
                                    ? slovak['My weaknesses']
                                    : czech['My weaknesses'],
                            4),
                        getTextt(
                            size,
                            (language == "English")
                                ? english['My Values']
                                : (language == "Slovak")
                                    ? slovak['My Values']
                                    : czech['My Values'],
                            5),
                      ],
                    ),
                  ),
                ],
              ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
            controller: controller,
            child: Column(
              children: [
                SizedBox(
                  height: 5.0,
                ),
                Divider(
                  thickness: 3.0,
                ),
                _wrapScrollTag(
                  index: 0,
                  child: getText(
                    (language == "English")
                        ? english['Me']
                        : (language == "Slovak")
                            ? slovak['Me']
                            : czech['Me'],
                    size,
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      expansionTile(
                          Icons.person,
                          (language == "English")
                              ? english['Who Am I?']
                              : (language == "Slovak")
                                  ? slovak['Who Am I?']
                                  : czech['Who Am I?'],
                          size,
                          Column(
                            children: [
                              GoalField(
                                iconbin: SizedBox,
                                enable:
                                    (whoami.text.isEmpty) ? true : whoamistatus,
                                prefix: InkWell(
                                    onTap: () {
                                      whoamistatus = true;
                                      print('l');
                                      setState(() {});
                                    },
                                    child: Icon(Icons.edit_outlined)),
                                keyBoardType: TextInputType.text,
                                controller: whoami,
                                onTap: () async {
                                  showLoadingIndicator("text");

                                  var msg = addGoalsWho(
                                          (language == "English")
                                              ? english['Who Am I?']
                                              : (language == "Slovak")
                                                  ? slovak['Who Am I?']
                                                  : czech['Who Am I?'],
                                          whoami.text,
                                          DateTime.now())
                                      .whenComplete(() =>
                                          Fluttertoast.showToast(
                                              msg: "Success"))
                                      .onError((error, stackTrace) =>
                                          Fluttertoast.showToast(
                                              msg: "Something went wrong"));

                                  Navigator.pop(context);
                                  print(whoami.text);
                                },
                                hint: (language == "English")
                                    ? english['Type..']
                                    : (language == "Slovak")
                                        ? slovak['Type..']
                                        : czech['Type..'],
                                numb: 3,
                              )
                            ],
                          ),
                          false,
                          context,
                          'who'),
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
                          Icons.person,
                          (language == "English")
                              ? english['Why I Am here?']
                              : (language == "Slovak")
                                  ? slovak['Why I Am here?']
                                  : czech['Why I Am here?'],
                          size,
                          Column(
                            children: [
                              GoalField(
                                iconbin: SizedBox,

                                enable: (whyIamHere.text.isEmpty)
                                    ? true
                                    : whyIamHerestatus,

                                onTap: () async {
                                  showLoadingIndicator("text");
                                  var msg = addGoalsWho(
                                          (language == "English")
                                              ? english['Why I Am here?']
                                              : (language == "Slovak")
                                                  ? slovak['Why I Am here?']
                                                  : czech['Why I Am here?'],
                                          whyIamHere.text,
                                          DateTime.now())
                                      .whenComplete(() =>
                                          Fluttertoast.showToast(
                                              msg: "Success"))
                                      .onError((error, stackTrace) =>
                                          Fluttertoast.showToast(
                                              msg: "Something went wrong"));

                                  Navigator.pop(context);
                                  print(whoami.text);
                                },
                                controller: whyIamHere,

                                hint: (language == "English")
                                    ? english['Type..']
                                    : (language == "Slovak")
                                        ? slovak['Type..']
                                        : czech['Type..'],

                                // hint: "Type..",
                                numb: 3,
                              )
                            ],
                          ),
                          false,
                          context,
                          ''),
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
                          Icons.person,
                          (language == "English")
                              ? english['What is my life about?']
                              : (language == "Slovak")
                                  ? slovak['What is my life about?']
                                  : czech['What is my life about?'],
                          size,
                          Column(
                            children: [
                              GoalField(
                                iconbin: SizedBox,

                                // prefix: InkWell(
                                //
                                //     onTap: (){
                                //       whatismylifestatus=true;
                                //       setState(() {
                                //
                                //       });
                                //     },
                                //     child: Icon(Icons.edit_outlined)),
                                enable: (whatismylife.text.isEmpty)
                                    ? true
                                    : whatismylifestatus,

                                onTap: () async {
                                  showLoadingIndicator("text");
                                  var msg = addGoalsWho(
                                          (language == "English")
                                              ? english[
                                                  'What is my life about?']
                                              : (language == "Slovak")
                                                  ? slovak[
                                                      'What is my life about?']
                                                  : czech[
                                                      'What is my life about?'],
                                          whatismylife.text,
                                          DateTime.now())
                                      .whenComplete(() =>
                                          Fluttertoast.showToast(
                                              msg: "Success"))
                                      .onError((error, stackTrace) =>
                                          Fluttertoast.showToast(
                                              msg: "Something went wrong"));

                                  Navigator.pop(context);
                                  print(whoami.text);
                                },
                                controller: whatismylife,
                                hint: (language == "English")
                                    ? english['Type..']
                                    : (language == "Slovak")
                                        ? slovak['Type..']
                                        : czech['Type..'],
                                numb: 3,
                              )
                            ],
                          ),
                          false,
                          context,
                          ''),
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
                          Icons.person,
                          (language == "English")
                              ? english['What I Desire']
                              : (language == "Slovak")
                                  ? slovak['What I Desire']
                                  : czech['What I Desire'],

                          // "What I Desire",
                          size,
                          Column(
                            children: [
                              GoalField(
                                iconbin: SizedBox,

                                // prefix: InkWell(
                                //
                                //     onTap: (){
                                //       whatidesirestatus=true;
                                //       setState(() {
                                //
                                //       });
                                //     },
                                //     child: Icon(Icons.edit_outlined)),
                                enable: (whatidesire.text.isEmpty)
                                    ? true
                                    : whatidesirestatus,

                                onTap: () async {
                                  showLoadingIndicator("text");
                                  var msg = addGoalsWho(
                                          (language == "English")
                                              ? english['What I Desire']
                                              : (language == "Slovak")
                                                  ? slovak['What I Desire']
                                                  : czech['What I Desire'],
                                          whatidesire.text,
                                          DateTime.now())
                                      .whenComplete(() =>
                                          Fluttertoast.showToast(
                                              msg: "Success"))
                                      .onError((error, stackTrace) =>
                                          Fluttertoast.showToast(
                                              msg: "Something went wrong"));

                                  Navigator.pop(context);
                                  print(whoami.text);
                                },
                                controller: whatidesire,
                                hint: (language == "English")
                                    ? english['Type..']
                                    : (language == "Slovak")
                                        ? slovak['Type..']
                                        : czech['Type..'],
                                numb: 3,
                              )
                            ],
                          ),
                          false,
                          context,
                          ''),
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
                          Icons.person,
                          (language == "English")
                              ? english['What would I Really Want?']
                              : (language == "Slovak")
                                  ? slovak['What would I Really Want?']
                                  : czech['What would I Really Want?'],

                          // "What would I Really Want?",
                          size,
                          Column(
                            children: [
                              GoalField(
                                iconbin: SizedBox,

                                // prefix: InkWell(
                                //
                                //     onTap: (){
                                //       whatwouldireallystatus=true;
                                //       setState(() {
                                //
                                //       });
                                //     },
                                //     child: Icon(Icons.edit_outlined)),
                                enable: (whatwouldireally.text.isEmpty)
                                    ? true
                                    : whatwouldireallystatus,

                                onTap: () async {
                                  showLoadingIndicator("text");
                                  var msg = addGoalsWho(
                                          (language == "English")
                                              ? english[
                                                  'What would I Really Want?']
                                              : (language == "Slovak")
                                                  ? slovak[
                                                      'What would I Really Want?']
                                                  : czech[
                                                      'What would I Really Want?'],
                                          whatwouldireally.text,
                                          DateTime.now())
                                      .whenComplete(() =>
                                          Fluttertoast.showToast(
                                              msg: "Success"))
                                      .onError((error, stackTrace) =>
                                          Fluttertoast.showToast(
                                              msg: "Something went wrong"));

                                  Navigator.pop(context);
                                  print(whoami.text);
                                },
                                controller: whatwouldireally,
                                hint: (language == "English")
                                    ? english['Type..']
                                    : (language == "Slovak")
                                        ? slovak['Type..']
                                        : czech['Type..'],
                                numb: 3,
                              )
                            ],
                          ),
                          false,
                          context,
                          ''),
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
                          Icons.person,
                          (language == "English")
                              ? english[
                                  'What would i do if money did not play a role?']
                              : (language == "Slovak")
                                  ? slovak[
                                      'What would i do if money did not play a role?']
                                  : czech[
                                      'What would i do if money did not play a role?'],

                          // "What would i do if money did not play a role?",
                          size,
                          Column(
                            children: [
                              GoalField(
                                iconbin: SizedBox,

                                // prefix: InkWell(
                                //
                                //     onTap: (){
                                //       whatwouldidoifstatus=true;
                                //       setState(() {
                                //
                                //       });
                                //     },
                                //     child: Icon(Icons.edit_outlined)),
                                enable: (whatwouldidoif.text.isEmpty)
                                    ? true
                                    : whatwouldidoifstatus,

                                onTap: () async {
                                  showLoadingIndicator("text");
                                  var msg = addGoalsWho(
                                          (language == "English")
                                              ? english[
                                                  'What would i do if money did not play a role?']
                                              : (language == "Slovak")
                                                  ? slovak[
                                                      'What would i do if money did not play a role?']
                                                  : czech[
                                                      'What would i do if money did not play a role?'],
                                          whatwouldidoif.text,
                                          DateTime.now())
                                      .whenComplete(() =>
                                          Fluttertoast.showToast(
                                              msg: "Success"))
                                      .onError((error, stackTrace) =>
                                          Fluttertoast.showToast(
                                              msg: "Something went wrong"));

                                  Navigator.pop(context);
                                  print(whoami.text);
                                },
                                controller: whatwouldidoif,
                                hint: (language == "English")
                                    ? english['Type..']
                                    : (language == "Slovak")
                                        ? slovak['Type..']
                                        : czech['Type..'],
                                numb: 3,
                              )
                            ],
                          ),
                          false,
                          context,
                          ''),
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
                          Icons.person,
                          (language == "English")
                              ? english['Why is it really important to me?']
                              : (language == "Slovak")
                                  ? slovak['Why is it really important to me?']
                                  : czech['Why is it really important to me?'],

                          // "Why is it really important to me?",
                          size,
                          Column(
                            children: [
                              GoalField(
                                iconbin: SizedBox,

                                // prefix: InkWell(
                                //
                                //     onTap: (){
                                //       whyisitreallystatus=true;
                                //       setState(() {
                                //
                                //       });
                                //     },
                                //     child: Icon(Icons.edit_outlined)),
                                enable: (whyisitreally.text.isEmpty)
                                    ? true
                                    : whyisitreallystatus,

                                onTap: () async {
                                  showLoadingIndicator("text");
                                  var msg = addGoalsWho(
                                          (language == "English")
                                              ? english[
                                                  'Why is it really important to me?']
                                              : (language == "Slovak")
                                                  ? slovak[
                                                      'Why is it really important to me?']
                                                  : czech[
                                                      'Why is it really important to me?'],
                                          whyisitreally.text,
                                          DateTime.now())
                                      .whenComplete(() =>
                                          Fluttertoast.showToast(
                                              msg: "Success"))
                                      .onError((error, stackTrace) =>
                                          Fluttertoast.showToast(
                                              msg: "Something went wrong"));

                                  Navigator.pop(context);
                                },
                                controller: whyisitreally,
                                hint: (language == "English")
                                    ? english['Type..']
                                    : (language == "Slovak")
                                        ? slovak['Type..']
                                        : czech['Type..'],
                                numb: 3,
                              )
                            ],
                          ),
                          false,
                          context,
                          ''),
                      SizedBox(
                        height: 5.0,
                      ),
                      Divider(
                        thickness: 3.0,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                    ],
                  ),
                ),
                _wrapScrollTag(
                  index: 1,
                  child: getText(
                    (language == "English")
                        ? english['My Relationships']
                        : (language == "Slovak")
                            ? slovak['My Relationships']
                            : czech['My Relationships'],
                    size,
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      expansionTile(
                          Icons.person,
                          (language == "English")
                              ? english['Who do I spend time with now and why?']
                              : (language == "Slovak")
                                  ? slovak[
                                      'Who do I spend time with now and why?']
                                  : czech[
                                      'Who do I spend time with now and why?'],

                          // "Who do I spend time with now and why?",
                          size,
                          Column(
                            children: [
                              GoalField(
                                iconbin: SizedBox,

                                // prefix: InkWell(
                                //
                                //     onTap: (){
                                //       whodoispendstatus=true;
                                //       setState(() {
                                //
                                //       });
                                //     },
                                //     child: Icon(Icons.edit_outlined)),
                                enable: (whodoispend.text.isEmpty)
                                    ? true
                                    : whodoispendstatus,

                                onTap: () async {
                                  showLoadingIndicator("text");
                                  var msg = addGoalsWho(
                                          (language == "English")
                                              ? english[
                                                  'Who do I spend time with now and why?']
                                              : (language == "Slovak")
                                                  ? slovak[
                                                      'Who do I spend time with now and why?']
                                                  : czech[
                                                      'Who do I spend time with now and why?'],
                                          whodoispend.text,
                                          DateTime.now())
                                      .whenComplete(() =>
                                          Fluttertoast.showToast(
                                              msg: "Success"))
                                      .onError((error, stackTrace) =>
                                          Fluttertoast.showToast(
                                              msg: "Something went wrong"));

                                  Navigator.pop(context);
                                },
                                controller: whodoispend,
                                hint: (language == "English")
                                    ? english['Type..']
                                    : (language == "Slovak")
                                        ? slovak['Type..']
                                        : czech['Type..'],
                                numb: 3,
                              )
                            ],
                          ),
                          false,
                          context,
                          ''),
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
                          Icons.person,
                          (language == "English")
                              ? english[
                                  'Who do I want to spend time with and why?']
                              : (language == "Slovak")
                                  ? slovak[
                                      'Who do I want to spend time with and why?']
                                  : czech[
                                      'Who do I want to spend time with and why?'],

                          // "Who do I want to spend time with and why?",
                          size,
                          Column(
                            children: [
                              GoalField(
                                iconbin: SizedBox,

                                // prefix: InkWell(
                                //
                                //     onTap: (){
                                //       whodoiwantstatus=true;
                                //       setState(() {
                                //
                                //       });
                                //     },
                                //     child: Icon(Icons.edit_outlined)),
                                enable: (whodoiwant.text.isEmpty)
                                    ? true
                                    : whodoiwantstatus,

                                onTap: () async {
                                  showLoadingIndicator("text");
                                  var msg = addGoalsWho(
                                          (language == "English")
                                              ? english[
                                                  'Who do I want to spend time with and why?']
                                              : (language == "Slovak")
                                                  ? slovak[
                                                      'Who do I want to spend time with and why?']
                                                  : czech[
                                                      'Who do I want to spend time with and why?'],
                                          whodoiwant.text,
                                          DateTime.now())
                                      .whenComplete(() =>
                                          Fluttertoast.showToast(
                                              msg: "Success"))
                                      .onError((error, stackTrace) =>
                                          Fluttertoast.showToast(
                                              msg: "Something went wrong"));

                                  Navigator.pop(context);
                                },
                                controller: whodoiwant,
                                hint: (language == "English")
                                    ? english['Type..']
                                    : (language == "Slovak")
                                        ? slovak['Type..']
                                        : czech['Type..'],
                                numb: 3,
                              )
                            ],
                          ),
                          false,
                          context,
                          ''),
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
                          Icons.person,
                          (language == "English")
                              ? english[
                                  'Who do I want to spend time with and why?']
                              : (language == "Slovak")
                                  ? slovak[
                                      'Who do I want to spend time with and why?']
                                  : czech[
                                      'Who do I want to spend time with and why?'],

                          // "Who do I want to spend time with and why?",
                          size,
                          Column(
                            children: [
                              GoalField(
                                iconbin: SizedBox,

                                // prefix: InkWell(
                                //
                                //     onTap: (){
                                //       whodoiwantostatus=true;
                                //       setState(() {
                                //
                                //       });
                                //     },
                                //     child: Icon(Icons.edit_outlined)),
                                enable: (whodoiwanto.text.isEmpty)
                                    ? true
                                    : whodoiwantostatus,

                                onTap: () async {
                                  showLoadingIndicator("text");
                                  var msg = addGoalsWho(
                                          (language == "English")
                                              ? english[
                                                  'Who do I want to spend time with and why?']
                                              : (language == "Slovak")
                                                  ? slovak[
                                                      'Who do I want to spend time with and why?']
                                                  : czech[
                                                      'Who do I want to spend time with and why?'],
                                          whodoiwanto.text,
                                          DateTime.now())
                                      .whenComplete(() =>
                                          Fluttertoast.showToast(
                                              msg: "Success"))
                                      .onError((error, stackTrace) =>
                                          Fluttertoast.showToast(
                                              msg: "Something went wrong"));

                                  Navigator.pop(context);
                                },
                                controller: whodoiwanto,

                                hint: (language == "English")
                                    ? english['Type..']
                                    : (language == "Slovak")
                                        ? slovak['Type..']
                                        : czech['Type..'],
                                numb: 3,
                              )
                            ],
                          ),
                          false,
                          context,
                          ''),
                      SizedBox(
                        height: 5.0,
                      ),
                      Divider(
                        thickness: 3.0,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                    ],
                  ),
                ),
                _wrapScrollTag(
                  index: 2,
                  child: getText(
                    (language == "English")
                        ? english['My Lifestyles']
                        : (language == "Slovak")
                            ? slovak['My Lifestyles']
                            : czech['My Lifestyles'],
                    size,
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      expansionTile(
                          Icons.person,
                          (language == "English")
                              ? english['What quality of life do I want?']
                              : (language == "Slovak")
                                  ? slovak['What quality of life do I want?']
                                  : czech['What quality of life do I want?'],

                          // "What quality of life do I want?",
                          size,
                          Column(
                            children: [
                              GoalField(
                                iconbin: SizedBox,

                                // prefix: InkWell(
                                //
                                //     onTap: (){
                                //       whatqualitystatus=true;
                                //       setState(() {
                                //
                                //       });
                                //     },
                                //     child: Icon(Icons.edit_outlined)),
                                enable: (whatquality.text.isEmpty)
                                    ? true
                                    : whatqualitystatus,

                                onTap: () async {
                                  showLoadingIndicator("text");
                                  var msg = addGoalsWho(
                                          (language == "English")
                                              ? english[
                                                  'What quality of life do I want?']
                                              : (language == "Slovak")
                                                  ? slovak[
                                                      'What quality of life do I want?']
                                                  : czech[
                                                      'What quality of life do I want?'],
                                          whatquality.text,
                                          DateTime.now())
                                      .whenComplete(() =>
                                          Fluttertoast.showToast(
                                              msg: "Success"))
                                      .onError((error, stackTrace) =>
                                          Fluttertoast.showToast(
                                              msg: "Something went wrong"));

                                  Navigator.pop(context);
                                },
                                controller: whatquality,
                                hint: (language == "English")
                                    ? english['Type..']
                                    : (language == "Slovak")
                                        ? slovak['Type..']
                                        : czech['Type..'],

                                numb: 3,
                              )
                            ],
                          ),
                          false,
                          context,
                          ''),
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
                          Icons.person,
                          (language == "English")
                              ? english['What do I care about?']
                              : (language == "Slovak")
                                  ? slovak['What do I care about?']
                                  : czech['What do I care about?'],

                          // "What do I care about?",
                          size,
                          Column(
                            children: [
                              GoalField(
                                iconbin: SizedBox,

                                // prefix: InkWell(
                                //
                                //     onTap: (){
                                //       whatdoicarestatus=true;
                                //       setState(() {
                                //
                                //       });
                                //     },
                                //     child: Icon(Icons.edit_outlined)),
                                enable: (whatdoicare.text.isEmpty)
                                    ? true
                                    : whatdoicarestatus,

                                onTap: () async {
                                  showLoadingIndicator("text");
                                  var msg = addGoalsWho(
                                          (language == "English")
                                              ? english['What do I care about?']
                                              : (language == "Slovak")
                                                  ? slovak[
                                                      'What do I care about?']
                                                  : czech[
                                                      'What do I care about?'],
                                          whatdoicare.text,
                                          DateTime.now())
                                      .whenComplete(() =>
                                          Fluttertoast.showToast(
                                              msg: "Success"))
                                      .onError((error, stackTrace) =>
                                          Fluttertoast.showToast(
                                              msg: "Something went wrong"));

                                  Navigator.pop(context);
                                },
                                controller: whatdoicare,

                                hint: (language == "English")
                                    ? english['Type..']
                                    : (language == "Slovak")
                                        ? slovak['Type..']
                                        : czech['Type..'],
                                numb: 3,
                              )
                            ],
                          ),
                          false,
                          context,
                          ''),
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
                          Icons.person,
                          (language == "English")
                              ? english['What does my day look like?']
                              : (language == "Slovak")
                                  ? slovak['What does my day look like?']
                                  : czech['What does my day look like?'],

                          // "What does my day look like?",
                          size,
                          Column(
                            children: [
                              GoalField(
                                iconbin: SizedBox,

                                // prefix: InkWell(
                                //
                                //     onTap: (){
                                //       whatdoesmydaystatus=true;
                                //       setState(() {
                                //
                                //       });
                                //     },
                                //     child: Icon(Icons.edit_outlined)),
                                enable: (whatdoesmyday.text.isEmpty)
                                    ? true
                                    : whatdoesmydaystatus,

                                onTap: () async {
                                  showLoadingIndicator("text");
                                  var msg = addGoalsWho(
                                          (language == "English")
                                              ? english[
                                                  'What does my day look like?']
                                              : (language == "Slovak")
                                                  ? slovak[
                                                      'What does my day look like?']
                                                  : czech[
                                                      'What does my day look like?'],
                                          whatdoesmyday.text,
                                          DateTime.now())
                                      .whenComplete(() =>
                                          Fluttertoast.showToast(
                                              msg: "Success"))
                                      .onError((error, stackTrace) =>
                                          Fluttertoast.showToast(
                                              msg: "Something went wrong"));

                                  Navigator.pop(context);
                                },
                                controller: whatdoesmyday,

                                hint: (language == "English")
                                    ? english['Type..']
                                    : (language == "Slovak")
                                        ? slovak['Type..']
                                        : czech['Type..'],
                                numb: 3,
                              )
                            ],
                          ),
                          false,
                          context,
                          ''),
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
                          Icons.person,
                          (language == "English")
                              ? english['A month']
                              : (language == "Slovak")
                                  ? slovak['A month']
                                  : czech['A month'],

                          // "A month",
                          size,
                          Column(
                            children: [
                              GoalField(
                                iconbin: SizedBox,

                                // prefix: InkWell(
                                //
                                //     onTap: (){
                                //       amonthstatus=true;
                                //       setState(() {
                                //
                                //       });
                                //     },
                                //     child: Icon(Icons.edit_outlined)),
                                enable:
                                    (amonth.text.isEmpty) ? true : amonthstatus,

                                onTap: () async {
                                  showLoadingIndicator("text");
                                  var msg = addGoalsWho(
                                          (language == "English")
                                              ? english['A month']
                                              : (language == "Slovak")
                                                  ? slovak['A month']
                                                  : czech['A month'],
                                          amonth.text,
                                          DateTime.now())
                                      .whenComplete(() =>
                                          Fluttertoast.showToast(
                                              msg: "Success"))
                                      .onError((error, stackTrace) =>
                                          Fluttertoast.showToast(
                                              msg: "Something went wrong"));

                                  Navigator.pop(context);
                                },
                                controller: amonth,

                                hint: (language == "English")
                                    ? english['Type..']
                                    : (language == "Slovak")
                                        ? slovak['Type..']
                                        : czech['Type..'],
                                numb: 3,
                              )
                            ],
                          ),
                          false,
                          context,
                          ''),
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
                          Icons.person,
                          (language == "English")
                              ? english['A Year']
                              : (language == "Slovak")
                                  ? slovak['A Year']
                                  : czech['A Year'],

                          // "A Year",
                          size,
                          Column(
                            children: [
                              GoalField(
                                iconbin: SizedBox,

                                // prefix: InkWell(
                                //
                                //     onTap: (){
                                //       ayearstatus=true;
                                //       setState(() {
                                //
                                //       });
                                //     },
                                //     child: Icon(Icons.edit_outlined)),
                                enable:
                                    (ayear.text.isEmpty) ? true : ayearstatus,

                                controller: ayear,
                                onTap: () async {
                                  showLoadingIndicator("text");
                                  var msg = addGoalsWho(
                                          (language == "English")
                                              ? english['A Year']
                                              : (language == "Slovak")
                                                  ? slovak['A Year']
                                                  : czech['A Year'],
                                          ayear.text,
                                          DateTime.now())
                                      .whenComplete(() =>
                                          Fluttertoast.showToast(
                                              msg: "Success"))
                                      .onError((error, stackTrace) =>
                                          Fluttertoast.showToast(
                                              msg: "Something went wrong"));

                                  Navigator.pop(context);
                                },

                                hint: (language == "English")
                                    ? english['Type..']
                                    : (language == "Slovak")
                                        ? slovak['Type..']
                                        : czech['Type..'],
                                numb: 3,
                              )
                            ],
                          ),
                          false,
                          context,
                          ''),
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
                          Icons.person,
                          (language == "English")
                              ? english[
                                  'Does this express my house, apraca friends?']
                              : (language == "Slovak")
                                  ? slovak[
                                      'Does this express my house, apraca friends?']
                                  : czech[
                                      'Does this express my house, apraca friends?'],

                          // "Does this express my house, apraca friends?",
                          size,
                          Column(
                            children: [
                              GoalField(
                                iconbin: SizedBox,

                                // prefix: InkWell(
                                //
                                //     onTap: (){
                                //       doesthisexpressstatus=true;
                                //       setState(() {
                                //
                                //       });
                                //     },
                                //     child: Icon(Icons.edit_outlined)),
                                enable: (doesthisexpress.text.isEmpty)
                                    ? true
                                    : doesthisexpressstatus,

                                onTap: () async {
                                  showLoadingIndicator("text");
                                  var msg = addGoalsWho(
                                          (language == "English")
                                              ? english[
                                                  'Does this express my house, apraca friends?']
                                              : (language == "Slovak")
                                                  ? slovak[
                                                      'Does this express my house, apraca friends?']
                                                  : czech[
                                                      'Does this express my house, apraca friends?'],
                                          doesthisexpress.text,
                                          DateTime.now())
                                      .whenComplete(() =>
                                          Fluttertoast.showToast(
                                              msg: "Success"))
                                      .onError((error, stackTrace) =>
                                          Fluttertoast.showToast(
                                              msg: "Something went wrong"));

                                  Navigator.pop(context);
                                },
                                controller: doesthisexpress,

                                hint: (language == "English")
                                    ? english['Type..']
                                    : (language == "Slovak")
                                        ? slovak['Type..']
                                        : czech['Type..'],
                                numb: 3,
                              )
                            ],
                          ),
                          false,
                          context,
                          ''),
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
                          Icons.person,
                          (language == "English")
                              ? english[
                                  'Does this express my house, apraca friends?']
                              : (language == "Slovak")
                                  ? slovak[
                                      'Does this express my house, apraca friends?']
                                  : czech[
                                      'Does this express my house, apraca friends?'],

                          // "Does this express my house, apraca friends?",
                          size,
                          Column(
                            children: [
                              GoalField(
                                iconbin: SizedBox,
                                prefix: InkWell(
                                    onTap: () {
                                      doesthisexpressostatus = true;
                                      setState(() {});
                                    },
                                    child: Icon(Icons.edit_outlined)),
                                enable: (doesthisexpresso.text.isEmpty)
                                    ? true
                                    : doesthisexpressostatus,
                                onTap: () async {
                                  showLoadingIndicator("text");
                                  var msg = addGoalsWho(
                                          (language == "English")
                                              ? english[
                                                  'Does this express my house, apraca friends?']
                                              : (language == "Slovak")
                                                  ? slovak[
                                                      'Does this express my house, apraca friends?']
                                                  : czech[
                                                      'Does this express my house, apraca friends?'],
                                          doesthisexpresso.text,
                                          DateTime.now())
                                      .whenComplete(() =>
                                          Fluttertoast.showToast(
                                              msg: "Success"))
                                      .onError((error, stackTrace) =>
                                          Fluttertoast.showToast(
                                              msg: "Something went wrong"));

                                  Navigator.pop(context);
                                },
                                controller: doesthisexpresso,
                                hint: (language == "English")
                                    ? english['Type..']
                                    : (language == "Slovak")
                                        ? slovak['Type..']
                                        : czech['Type..'],
                                numb: 3,
                              )
                            ],
                          ),
                          false,
                          context,
                          ''),
                      SizedBox(
                        height: 5.0,
                      ),
                      Divider(
                        thickness: 3.0,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                    ],
                  ),
                ),
                _wrapScrollTag(
                  index: 3,
                  child: getText(
                    (language == "English")
                        ? english['My strengths']
                        : (language == "Slovak")
                            ? slovak['My strengths']
                            : czech['My strengths'],
                    size,
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      expansionTile(
                          Icons.person,
                          (language == "English")
                              ? english['What is easy for me?']
                              : (language == "Slovak")
                                  ? slovak['What is easy for me?']
                                  : czech['What is easy for me?'],

                          // "What is easy for me?",
                          size,
                          Column(
                            children: [
                              GoalField(
                                iconbin: SizedBox,
                                prefix: InkWell(
                                    onTap: () {
                                      whatiseasystatus = true;
                                      setState(() {});
                                    },
                                    child: Icon(Icons.edit_outlined)),
                                enable: (whatiseasy.text.isEmpty)
                                    ? true
                                    : whatiseasystatus,
                                onTap: () async {
                                  showLoadingIndicator("text");
                                  var msg = addGoalsWho(
                                          (language == "English")
                                              ? english['What is easy for me?']
                                              : (language == "Slovak")
                                                  ? slovak[
                                                      'What is easy for me?']
                                                  : czech[
                                                      'What is easy for me?'],
                                          whatiseasy.text,
                                          DateTime.now())
                                      .whenComplete(() =>
                                          Fluttertoast.showToast(
                                              msg: "Success"))
                                      .onError((error, stackTrace) =>
                                          Fluttertoast.showToast(
                                              msg: "Something went wrong"));

                                  Navigator.pop(context);
                                },
                                controller: whatiseasy,
                                hint: (language == "English")
                                    ? english['Type..']
                                    : (language == "Slovak")
                                        ? slovak['Type..']
                                        : czech['Type..'],
                                numb: 3,
                              )
                            ],
                          ),
                          false,
                          context,
                          ''),
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
                          Icons.person,
                          (language == "English")
                              ? english[
                                  'What do I love, what is my passion? Why do I forget the time?']
                              : (language == "Slovak")
                                  ? slovak[
                                      'What do I love, what is my passion? Why do I forget the time?']
                                  : czech[
                                      'What do I love, what is my passion? Why do I forget the time?'],

                          // "What do I love, what is my passion? Why do I forget the time?",
                          size,
                          Column(
                            children: [
                              GoalField(
                                iconbin: SizedBox,
                                prefix: InkWell(
                                    onTap: () {
                                      whatdoilovestatus = true;
                                      setState(() {});
                                    },
                                    child: Icon(Icons.edit_outlined)),
                                enable: (whatdoilove.text.isEmpty)
                                    ? true
                                    : whatdoilovestatus,
                                onTap: () async {
                                  showLoadingIndicator("text");
                                  var msg = addGoalsWho(
                                          (language == "English")
                                              ? english[
                                                  'What do I love, what is my passion? Why do I forget the time?']
                                              : (language == "Slovak")
                                                  ? slovak[
                                                      'What do I love, what is my passion? Why do I forget the time?']
                                                  : czech[
                                                      'What do I love, what is my passion? Why do I forget the time?'],
                                          whatdoilove.text,
                                          DateTime.now())
                                      .whenComplete(() =>
                                          Fluttertoast.showToast(
                                              msg: "Success"))
                                      .onError((error, stackTrace) =>
                                          Fluttertoast.showToast(
                                              msg: "Something went wrong"));

                                  Navigator.pop(context);
                                },
                                controller: whatdoilove,
                                hint: (language == "English")
                                    ? english['Type..']
                                    : (language == "Slovak")
                                        ? slovak['Type..']
                                        : czech['Type..'],
                                numb: 3,
                              )
                            ],
                          ),
                          false,
                          context,
                          ''),
                      SizedBox(
                        height: 5.0,
                      ),
                      Divider(
                        thickness: 3.0,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                    ],
                  ),
                ),
                _wrapScrollTag(
                  index: 4,
                  child: getText(
                    (language == "English")
                        ? english['My weaknesses']
                        : (language == "Slovak")
                            ? slovak['My weaknesses']
                            : czech['My weaknesses'],
                    size,
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      expansionTile(
                          Icons.person,
                          (language == "English")
                              ? english[
                                  'What is holding me back? What is wrong with me?']
                              : (language == "Slovak")
                                  ? slovak[
                                      'What is holding me back? What is wrong with me?']
                                  : czech[
                                      'What is holding me back? What is wrong with me?'],

                          // "What's holding me back? What's wrong with me?",
                          size,
                          Column(
                            children: [
                              GoalField(
                                iconbin: SizedBox,
                                prefix: InkWell(
                                    onTap: () {
                                      whatsholdingstatus = true;
                                      setState(() {});
                                    },
                                    child: Icon(Icons.edit_outlined)),
                                enable: (whatsholding.text.isEmpty)
                                    ? true
                                    : whatsholdingstatus,
                                onTap: () async {
                                  showLoadingIndicator("text");
                                  var msg = addGoalsWho(
                                          (language == "English")
                                              ? english[
                                                  'What is holding me back? What is wrong with me?']
                                              : (language == "Slovak")
                                                  ? slovak[
                                                      'What is holding me back? What is wrong with me?']
                                                  : czech[
                                                      'What is holding me back? What is wrong with me?'],
                                          whatsholding.text,
                                          DateTime.now())
                                      .whenComplete(() =>
                                          Fluttertoast.showToast(
                                              msg: "Success"))
                                      .onError((error, stackTrace) =>
                                          Fluttertoast.showToast(
                                              msg: "Something went wrong"));

                                  Navigator.pop(context);
                                },
                                controller: whatsholding,
                                hint: (language == "English")
                                    ? english['Type..']
                                    : (language == "Slovak")
                                        ? slovak['Type..']
                                        : czech['Type..'],
                                numb: 3,
                              )
                            ],
                          ),
                          false,
                          context,
                          ''),
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
                          Icons.person,
                          (language == "English")
                              ? english['What do I not want to do?']
                              : (language == "Slovak")
                                  ? slovak['What do I not want to do?']
                                  : czech['What do I not want to do?'],

                          // "What do I not want to do?",
                          size,
                          Column(
                            children: [
                              GoalField(
                                iconbin: SizedBox,
                                prefix: InkWell(
                                    onTap: () {
                                      whatdoinotstatus = true;
                                      setState(() {});
                                    },
                                    child: Icon(Icons.edit_outlined)),
                                enable: (whatdoinot.text.isEmpty)
                                    ? true
                                    : whatdoinotstatus,
                                onTap: () async {
                                  showLoadingIndicator("text");
                                  var msg = addGoalsWho(
                                          (language == "English")
                                              ? english[
                                                  'What do I not want to do?']
                                              : (language == "Slovak")
                                                  ? slovak[
                                                      'What do I not want to do?']
                                                  : czech[
                                                      'What do I not want to do?'],
                                          whatdoinot.text,
                                          DateTime.now())
                                      .whenComplete(() =>
                                          Fluttertoast.showToast(
                                              msg: "Success"))
                                      .onError((error, stackTrace) =>
                                          Fluttertoast.showToast(
                                              msg: "Something went wrong"));

                                  Navigator.pop(context);
                                },
                                controller: whatdoinot,
                                hint: (language == "English")
                                    ? english['Type..']
                                    : (language == "Slovak")
                                        ? slovak['Type..']
                                        : czech['Type..'],
                                numb: 3,
                              )
                            ],
                          ),
                          false,
                          context,
                          ''),
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
                          Icons.person,
                          (language == "English")
                              ? english[
                                  'Which activities/habits are taking me away from my dreams and goals?']
                              : (language == "Slovak")
                                  ? slovak[
                                      'Which activities/habits are taking me away from my dreams and goals?']
                                  : czech[
                                      'Which activities/habits are taking me away from my dreams and goals?'],

                          // "Which activities/habits are taking me away from my dreams and goals?",
                          size,
                          Column(
                            children: [
                              GoalField(
                                iconbin: SizedBox,
                                prefix: InkWell(
                                    onTap: () {
                                      whichactivitystatus = true;
                                      setState(() {});
                                    },
                                    child: Icon(Icons.edit_outlined)),
                                enable: (whichactivity.text.isEmpty)
                                    ? true
                                    : whichactivitystatus,
                                onTap: () async {
                                  showLoadingIndicator("text");
                                  var msg = addGoalsWho(
                                          (language == "English")
                                              ? english[
                                                  'Which activities/habits are taking me away from my dreams and goals?']
                                              : (language == "Slovak")
                                                  ? slovak[
                                                      'Which activities/habits are taking me away from my dreams and goals?']
                                                  : czech[
                                                      'Which activities/habits are taking me away from my dreams and goals?'],
                                          whichactivity.text,
                                          DateTime.now())
                                      .whenComplete(() =>
                                          Fluttertoast.showToast(
                                              msg: "Success"))
                                      .onError((error, stackTrace) =>
                                          Fluttertoast.showToast(
                                              msg: "Something went wrong"));

                                  Navigator.pop(context);
                                },
                                controller: whichactivity,
                                hint: (language == "English")
                                    ? english['Type..']
                                    : (language == "Slovak")
                                        ? slovak['Type..']
                                        : czech['Type..'],
                                numb: 3,
                              )
                            ],
                          ),
                          false,
                          context,
                          ''),
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
                          Icons.person,
                          (language == "English")
                              ? english[
                                  'What can I delegate/sell/ask someone for help with?']
                              : (language == "Slovak")
                                  ? slovak[
                                      'What can I delegate/sell/ask someone for help with?']
                                  : czech[
                                      'What can I delegate/sell/ask someone for help with?'],

                          // "What can I delegate/sell/ask someone for help with?",
                          size,
                          Column(
                            children: [
                              GoalField(
                                iconbin: SizedBox,
                                prefix: InkWell(
                                    onTap: () {
                                      whatcanidelegatestatus = true;
                                      setState(() {});
                                    },
                                    child: Icon(Icons.edit_outlined)),
                                enable: (whatcanidelegate.text.isEmpty)
                                    ? true
                                    : whatcanidelegatestatus,
                                onTap: () async {
                                  showLoadingIndicator("text");
                                  var msg = addGoalsWho(
                                          (language == "English")
                                              ? english[
                                                  'What can I delegate/sell/ask someone for help with?']
                                              : (language == "Slovak")
                                                  ? slovak[
                                                      'What can I delegate/sell/ask someone for help with?']
                                                  : czech[
                                                      'What can I delegate/sell/ask someone for help with?'],
                                          whatcanidelegate.text,
                                          DateTime.now())
                                      .whenComplete(() =>
                                          Fluttertoast.showToast(
                                              msg: "Success"))
                                      .onError((error, stackTrace) =>
                                          Fluttertoast.showToast(
                                              msg: "Something went wrong"));

                                  Navigator.pop(context);
                                },
                                controller: whatcanidelegate,
                                hint: (language == "English")
                                    ? english['Type..']
                                    : (language == "Slovak")
                                        ? slovak['Type..']
                                        : czech['Type..'],
                                numb: 3,
                              )
                            ],
                          ),
                          false,
                          context,
                          ''),
                      SizedBox(
                        height: 5.0,
                      ),
                      Divider(
                        thickness: 3.0,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                    ],
                  ),
                ),
                _wrapScrollTag(
                  index: 5,
                  child: getText(
                    (language == "English")
                        ? english['My Values']
                        : (language == "Slovak")
                            ? slovak['My Values']
                            : czech['My Values'],
                    size,
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      expansionTile(
                          Icons.person,
                          (language == "English")
                              ? english[
                                  'What values are important to me in my life?']
                              : (language == "Slovak")
                                  ? slovak[
                                      'What values are important to me in my life?']
                                  : czech[
                                      'What values are important to me in my life?'],

                          // "What values are important to me in my life?",
                          size,
                          Column(
                            children: [
                              GoalField(
                                iconbin: SizedBox,
                                prefix: InkWell(
                                    onTap: () {
                                      whatvaluesstatus = true;
                                      setState(() {});
                                    },
                                    child: Icon(Icons.edit_outlined)),
                                enable: (whatvalues.text.isEmpty)
                                    ? true
                                    : whatvaluesstatus,
                                onTap: () async {
                                  showLoadingIndicator("text");
                                  var msg = addGoalsWho(
                                          (language == "English")
                                              ? english[
                                                  'What values are important to me in my life?']
                                              : (language == "Slovak")
                                                  ? slovak[
                                                      'What values are important to me in my life?']
                                                  : czech[
                                                      'What values are important to me in my life?'],
                                          whatvalues.text,
                                          DateTime.now())
                                      .whenComplete(() =>
                                          Fluttertoast.showToast(
                                              msg: "Success"))
                                      .onError((error, stackTrace) =>
                                          Fluttertoast.showToast(
                                              msg: "Something went wrong"));

                                  Navigator.pop(context);
                                },
                                controller: whatvalues,
                                hint: (language == "English")
                                    ? english['Type..']
                                    : (language == "Slovak")
                                        ? slovak['Type..']
                                        : czech['Type..'],
                                numb: 3,
                              )
                            ],
                          ),
                          false,
                          context,
                          ''),
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
                          Icons.person,
                          (language == "English")
                              ? english[
                                  'When and how will I know that they are filled?']
                              : (language == "Slovak")
                                  ? slovak[
                                      'When and how will I know that they are filled?']
                                  : czech[
                                      'When and how will I know that they are filled?'],

                          // "When and how will I know that they are filled?",
                          size,
                          Column(
                            children: [
                              GoalField(
                                iconbin: SizedBox,
                                prefix: InkWell(
                                    onTap: () {
                                      whenandhowstatus = true;
                                      setState(() {});
                                    },
                                    child: Icon(Icons.edit_outlined)),
                                enable: (whenandhow.text.isEmpty)
                                    ? true
                                    : whenandhowstatus,
                                onTap: () async {
                                  showLoadingIndicator("text");
                                  var msg = addGoalsWho(
                                          (language == "English")
                                              ? english[
                                                  'When and how will I know that they are filled?']
                                              : (language == "Slovak")
                                                  ? slovak[
                                                      'When and how will I know that they are filled?']
                                                  : czech[
                                                      'When and how will I know that they are filled?'],
                                          whenandhow.text,
                                          DateTime.now())
                                      .whenComplete(() =>
                                          Fluttertoast.showToast(
                                              msg: "Success"))
                                      .onError((error, stackTrace) =>
                                          Fluttertoast.showToast(
                                              msg: "Something went wrong"));

                                  Navigator.pop(context);
                                },
                                controller: whenandhow,
                                hint: (language == "English")
                                    ? english['Type..']
                                    : (language == "Slovak")
                                        ? slovak['Type..']
                                        : czech['Type..'],
                                numb: 3,
                              )
                            ],
                          ),
                          false,
                          context,
                          ''),
                    ],
                  ),
                ),
              ],
            ),
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
          bottom: size.height * 0.01,
          top: size.height * 0.01),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
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
            ],
          ),
        ],
      ),
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

  int counter = -1;

  Future _nextCounter(index) {
    print(index);
    setState(() => counter = index);
    return _scrollToCounter();
  }

  Future _scrollToCounter() async {
    await controller.scrollToIndex(counter,
        preferPosition: AutoScrollPosition.begin);
    controller.highlight(counter);
  }

  Widget _wrapScrollTag({required int index, required Widget child}) =>
      AutoScrollTag(
        key: ValueKey(index),
        controller: controller,
        index: index,
        child: child,
        highlightColor: Colors.black.withOpacity(0.1),
      );
}
