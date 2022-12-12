import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:personal_dairy/Screens/Controllers/auth_service.dart';
import 'package:personal_dairy/utils/constants.dart';
import 'package:personal_dairy/widgets/custom_bottom_btn.dart';
import 'package:personal_dairy/widgets/custom_dropdown.dart';
import 'package:personal_dairy/widgets/custom_field.dart';
import 'package:personal_dairy/widgets/social_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../widgets/custom_loading_indicator.dart';
import '../bottom.dart';
import 'main_auth.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  List languages = [
    Item(
        'English',
        Image.asset(
          'assets/english.png',
          width: 40.0,
        )),
    Item(
        'Slovak',
        Image.asset(
          'assets/slovakflag.png',
          width: 40.0,
        )),
    Item(
        'Czech',
        Image.asset(
          'assets/czechflag.png',
          width: 40.0,
        )),
  ];
  var visibilty = true;
  var visibiltyConfirm = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController conPassController = TextEditingController();
  TextEditingController usernamController = TextEditingController();
  var selectedLanguage;

  @override
  void initState() {
    selectedLanguage = languages[0];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.04,
          ),
          CustomFields(
            hint: (language == "English")
                ? english['Username']
                : (language == "Slovak")
                    ? slovak['Username']
                    : czech['Username'],
            icon: Icons.person,
            controller: usernamController,
          ),
          SizedBox(
            height: size.height * 0.007,
          ),
          CustomFields(
              hint: (language == "English")
                  ? english['Email Address']
                  : (language == "Slovak")
                      ? slovak['Email Address']
                      : czech['Email Address'],
              icon: Icons.email,
              controller: emailController),
          SizedBox(
            height: size.height * 0.007,
          ),
          CustomFields(
              visibilty: visibilty,
              hint: (language == "English")
                  ? english['Password']
                  : (language == "Slovak")
                      ? slovak['Password']
                      : czech['Password'],
              icon:
                  (visibilty == true) ? Icons.visibility_off : Icons.visibility,
              onTap: () {
                if (visibilty == true) {
                  visibilty = false;
                } else {
                  visibilty = true;
                }
                setState(() {});
              },
              controller: passController),
          SizedBox(
            height: size.height * 0.007,
          ),
          CustomFields(
              visibilty: visibilty,
              hint: (language == "English")
                  ? english['Confirm Password']
                  : (language == "Slovak")
                      ? slovak['Confirm Password']
                      : czech['Confirm Password'],

              // hint: "Confirm Password",
              icon:
                  (visibilty == true) ? Icons.visibility_off : Icons.visibility,
              onTap: () {
                if (visibilty == true) {
                  visibilty = false;
                } else {
                  visibilty = true;
                }
                setState(() {});
              },
              controller: conPassController),
          Container(
            margin: EdgeInsets.only(
                left: size.width * 0.03,
                right: size.width * 0.03,
                top: size.height * 0.015,
                bottom: size.height * 0.015),
            padding: EdgeInsets.only(
                left: size.width * 0.03,
                right: size.width * 0.03,
                top: size.height * 0.015,
                bottom: size.height * 0.015),
            decoration: BoxDecoration(
                border: Border.all(color: colorHeader),
                borderRadius: BorderRadius.circular(10.0)),
            width: size.width,
            height: size.height * 0.075,
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                icon: Icon(Icons.keyboard_arrow_down_outlined),
                iconSize: 24,
                elevation: 16,
                value: selectedLanguage,
                isExpanded: true,
                items: languages.map((languages) {
                  return DropdownMenuItem(
                    value: languages,
                    child: Row(
                      children: [
                        languages.icon,
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          languages.name,
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (languages.indexOf(value) == 0) {
                    print(language);
                    language = "English";
                    setState(() {});
                  } else if (languages.indexOf(value) == 1) {
                    language = "Slovak";
                    setState(() {});
                  } else if (languages.indexOf(value) == 2) {
                    language = "Czech";
                    setState(() {});
                  }
                  setState(() {});
                  setState(() {
                    selectedLanguage = value;
                  });
                },
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.007,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.03,
                right: size.width * 0.03,
                top: size.height * 0.01,
                bottom: size.height * 0.01),
            child: InkWell(
                onTap: () async {
                  final String email = emailController.text.trim();
                  final String password = passController.text.trim();
                  final String username = usernamController.text.trim();
                  if (passController.text != conPassController.text) {
                    Fluttertoast.showToast(
                        msg: (language == "English")
                            ? english['Password must be same']
                            : (language == "Slovak")
                                ? slovak['Password must be same']
                                : czech['Password must be same']);

                    // Fluttertoast.showToast(msg: "Password must be same");
                  } else {
                    if (email.isEmpty) {
                      Fluttertoast.showToast(
                          msg: (language == "English")
                              ? english['Email must not be empty']
                              : (language == "Slovak")
                                  ? slovak['Email must not be empty']
                                  : czech['Email must not be empty']);

                      // Fluttertoast.showToast(msg: "Email must not be empty");
                    } else {
                      if (password.isEmpty) {
                        Fluttertoast.showToast(
                            msg: (language == "English")
                                ? english['Password must not be empty']
                                : (language == "Slovak")
                                    ? slovak['Password must not be empty']
                                    : czech['Password must not be empty']);

                        // Fluttertoast.showToast(
                        //
                        //     msg: "Password must not be empty");
                      } else {
                        if (username.isEmpty) {
                          Fluttertoast.showToast(
                              msg: (language == "English")
                                  ? english['Username must not be empty']
                                  : (language == "Slovak")
                                      ? slovak['Username must not be empty']
                                      : czech['Username must not be empty']);

                          // Fluttertoast.showToast(
                          //     msg: "Username must not be empty");
                        } else {
                          showLoadingIndicator("Creating User");
                          DateTime selectedDate = DateTime.now();
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(DateTime.now());
                          User? user = FirebaseAuth.instance.currentUser;
                          var msg = await signUp(
                                  email, password, username, languageSelected)
                              .then((value) async {
                            await FirebaseFirestore.instance
                                .collection("GoalBoards")
                                .doc(user?.uid)
                                .set({
                              'title': '',
                              'uid': user?.uid,
                              'imagesPersonalProgress': [],
                              'timeForYourself': [],
                              'workCareer': [],
                              'money': [],
                              'family': [],
                              'health': [],
                            }).then((value) => print("jfjjfjf "));
                            print('goal added');
                            user = await FirebaseAuth.instance.currentUser;
                            setState(() {});
                            await FirebaseFirestore.instance
                                .collection("userdata")
                                .doc(user?.uid)
                                .set({
                              'uid': user?.uid,
                              "date": formattedDate,
                              "weekData": [
                                {
                                  "date": formattedDate,
                                  'goalsOfWeek1': '',
                                  'goalsOfWeek2': '',
                                  'goalsOfWeek3': '',
                                  'pleasureOfWeek1': '',
                                  'pleasureOfWeek2': '',
                                  'pleasureOfWeek3': '',
                                  'habitOfWeek': '',
                                }
                              ],
                              "$formattedDate": [
                                {
                                  'feelings': 2,
                                  'gratitudeOfDay1': '',
                                  'gratitudeOfDay2': '',
                                  'gratitudeOfDay3': '',
                                  'priority': '',
                                  'programOfDay1': '',
                                  'programOfDay2': '',
                                  'programOfDay3': '',
                                  'ritualOfDay1': '',
                                  'ritualOfDay2': '',
                                  'successOfDay1': '',
                                  'successOfDay2': '',
                                  'successOfDay3': '',
                                  'financeOfDay1': '',
                                  'financeOfDay2': '',
                                  'learningOfDay1': '',
                                  'learningOfDay2': '',
                                }
                              ],
                              // "$formattedDate":[{
                              //   '${formattedDate} feelings': 2,
                              //   '${formattedDate} goalsOfWeek1': '',
                              //   '${formattedDate} goalsOfWeek2': '',
                              //   '${formattedDate} goalsOfWeek3': '',
                              //   '${formattedDate} pleasureOfWeek1': '',
                              //   '${formattedDate} pleasureOfWeek2': '',
                              //   '${formattedDate} pleasureOfWeek3': '',
                              //
                              //   '${formattedDate} gratitudeOfDay1': '',
                              //   '${formattedDate} gratitudeOfDay2': '',
                              //   '${formattedDate} gratitudeOfDay3': '',
                              //   '${formattedDate} priority': '',
                              //   '${formattedDate} programOfDay1': '',
                              //   '${formattedDate} programOfDay2': '',
                              //   '${formattedDate} programOfDay3': '',
                              //   '${formattedDate} ritualOfDay1': '',
                              //   '${formattedDate} ritualOfDay2': '',
                              //   '${formattedDate} successOfDay1': '',
                              //   '${formattedDate} successOfDay2': '',
                              //   '${formattedDate} successOfDay3': '',
                              //   '${formattedDate} financeOfDay1': '',
                              //   '${formattedDate} financeOfDay2': '',
                              //   '${formattedDate} learningOfDay1': '',
                              //   '${formattedDate} learningOfDay2': '',
                              //   '${formattedDate} habitOfWeek': '',
                              // } ],
                            }, SetOptions(merge: true));

                            var uid = user?.uid;
                            SharedPreferences sp =
                                await SharedPreferences.getInstance();
                            sp.setBool('isloggedin', true);

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const BottomBar()));
                          });
                          Fluttertoast.showToast(msg: "$msg");
                          setState(() {
                            conPassController.clear();
                            passController.clear();
                            emailController.clear();
                            usernamController.clear();
                          });
                        }
                      }
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomBar()));

                    }
                  }
                },
                child: CustomBottomButton(
                  title: (language == "English")
                      ? english['Create Account']
                      : (language == "Slovak")
                          ? slovak['Create Account']
                          : czech['Create Account'],
                )),
          ),
          SizedBox(
            height: size.height * 0.007,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.03,
                right: size.width * 0.03,
                top: size.height * 0.01,
                bottom: size.height * 0.01),
            child: Divider(),
          ),
          SocialButton(
            image: "assets/facebook.png",
            text: (language == "English")
                ? english['Signin with Facebook']
                : (language == "Slovak")
                    ? slovak['Signin with Facebook']
                    : czech['Signin with Facebook'],
            color: colorHeader,
          ),
          SizedBox(
            height: size.height * 0.005,
          ),
          InkWell(
              onTap: () async {
                showLoadingIndicator("Signing In");
                signInWithGoogle(context);
                Navigator.of(context).pop();
              },
              child: SocialButton(
                image: "assets/google.png",
                text: (language == "English")
                    ? english['Signin with Google']
                    : (language == "Slovak")
                        ? slovak['Signin with Google']
                        : czech['Signin with Google'],
                color: colorHeader,
              )),
          SizedBox(
            height: size.height * 0.005,
          ),
          SocialButton(
            image: "assets/apple.png",
            text: (language == "English")
                ? english['Signin with Apple']
                : (language == "Slovak")
                    ? slovak['Signin with Apple']
                    : czech['Signin with Apple'],
            color: colorHeader,
          )
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
}
