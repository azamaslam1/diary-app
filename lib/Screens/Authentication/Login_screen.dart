import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:personal_dairy/Screens/Authentication/reset_password.dart';
import 'package:personal_dairy/Screens/Controllers/auth_service.dart';
import 'package:personal_dairy/Screens/bottom.dart';
import 'package:personal_dairy/utils/constants.dart';
import 'package:personal_dairy/widgets/custom_bottom_btn.dart';
import 'package:personal_dairy/widgets/custom_dropdown.dart';
import 'package:personal_dairy/widgets/custom_field.dart';
import 'package:personal_dairy/widgets/social_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../widgets/custom_loading_indicator.dart';
import 'main_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var visibilty = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
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
                ? english['Email Address']
                : (language == "Slovak")
                    ? slovak['Email Address']
                    : czech['Email Address'],
            icon: Icons.email,
            controller: emailController,
          ),
          SizedBox(
            height: size.height * 0.007,
          ),
          CustomFields(
            hint: (language == "English")
                ? english['Password']
                : (language == "Slovak")
                    ? slovak['Password']
                    : czech['Password'],
            visibilty: visibilty,
            icon: (visibilty == true) ? Icons.visibility_off : Icons.visibility,
            onTap: () {
              if (visibilty == true) {
                visibilty = false;
              } else {
                visibilty = true;
              }
              setState(() {});
            },
            controller: passController,
          ),
          SizedBox(
            height: size.height * 0.007,
          ),
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
                icon: const Icon(Icons.keyboard_arrow_down_outlined),
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
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          languages.name,
                          style: const TextStyle(color: Colors.red),
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

                  if (emailController.text == null ||
                      passController.text == null) {
                    Fluttertoast.showToast(
                        msg: (language == "English")
                            ? english['Fields must be filled']
                            : (language == "Slovak")
                                ? slovak['Fields must be filled']
                                : czech['Fields must be filled']);
                  } else {
                    showLoadingIndicator("Creating User");
                    User? user = FirebaseAuth.instance.currentUser;
                    var msg = await login(email, password);
                    Fluttertoast.showToast(msg: "$msg");
                    setState(() {
                      passController.clear();
                      emailController.clear();
                    });

                    if (msg == 'Logged In') {
                      var uid = user?.uid;

                      SharedPreferences sp =
                          await SharedPreferences.getInstance();
                      sp.setBool('isloggedin', true);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BottomBar()));
                    } else {
                      Navigator.of(context).pop();
                    }
                  }
                },
                child: CustomBottomButton(
                  title: (language == "English")
                      ? english['Login']
                      : (language == "Slovak")
                          ? slovak['Login']
                          : czech['Login'],
                )),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ResetPassword()));
            },
            child: Text(
              (language == "English")
                  ? english['Forgot your password?']
                  : (language == "Slovak")
                      ? slovak['Forgot your password?']
                      : czech['Forgot your password?'],
              style: const TextStyle(
                fontSize: 15.0,
                decoration: TextDecoration.underline,
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
            child: const Divider(),
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
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              backgroundColor: colorHeader,
              content: LoadingIndicator(text: text),
            ));
      },
    );
  }
}
