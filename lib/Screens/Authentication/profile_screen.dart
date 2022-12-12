import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:personal_dairy/Screens/bottom.dart';
import 'package:personal_dairy/widgets/custom_bottom_btn.dart';
import 'package:personal_dairy/widgets/custom_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_loading_indicator.dart';
import '../Controllers/auth_service.dart';
import 'main_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        leading: InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => BottomBar()));
            },
            child: Icon(Icons.arrow_back_ios)),
        backgroundColor: colorHeader,
        title: Text((language == "English")
            ? english['Profile']
            : (language == "Slovak")
                ? slovak['Profile']
                : czech['Profile']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              customContainer(size),
              SizedBox(
                height: 5,
              ),
              //dasa
              Divider(
                thickness: 2.0,
              ),
              SizedBox(
                height: 5,
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
                        language = "English";
                        setState(() {});
                      } else if (languages.indexOf(value) == 1) {
                        language = "Slovak";
                        print('slovak');

                        // selectedLanguage=languages[1];
                        print('${selectedLanguage.name}');

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
                height: size.height * 0.02,
              ),
              getTiles(
                  (language == "English")
                      ? english['Update my details']
                      : (language == "Slovak")
                          ? slovak['Update my details']
                          : czech['Update my details'],
                  size),
              getTiles(
                  (language == "English")
                      ? english['Notification prefrences']
                      : (language == "Slovak")
                          ? slovak['Notification prefrences']
                          : czech['Notification prefrences'],
                  size),
              getTiles(
                  (language == "English")
                      ? english['Post your feedback']
                      : (language == "Slovak")
                          ? slovak['Post your feedback']
                          : czech['Post your feedback'],
                  size),
              getTiles(
                  (language == "English")
                      ? english['Delete account & Data']
                      : (language == "Slovak")
                          ? slovak['Delete account & Data']
                          : czech['Delete account & Data'],
                  size),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.03,
                    right: size.width * 0.03,
                    top: size.height * 0.015,
                    bottom: size.height * 0.015),
                child: CustomBottomButton(
                  title: "Logout",
                  onTap: () async {
                    showLoadingIndicator("text");
                    SharedPreferences sp =
                        await SharedPreferences.getInstance();
                    sp.clear();
                    if (googleSignIn.currentUser != null) {
                      await googleSignIn.disconnect();
                      await FirebaseAuth.instance.signOut();
                    } else {
                      await FirebaseAuth.instance.signOut();
                    }
                    Navigator.of(context).pop();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MainAuth()),
                        (route) => false);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customContainer(size) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Card(
        elevation: 3.0,
        child: Container(
          width: size.width,
          height: size.height * 0.18,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.05,
                top: size.height * 0.02,
                right: size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: size.width * 0.07,
                      backgroundImage: AssetImage('assets/spouse.png'),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Daniel Gadus",
                          style: TextStyle(
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              color: colorHeader),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: size.width * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      iconGet(
                          "danielgadus@gmail.com", size, Icons.alternate_email),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget iconGet(text, size, icn) {
    return Container(
      child: Row(
        children: [
          Icon(
            icn,
            color: colorHeader,
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            "$text",
            style: TextStyle(
                color: colorHeader,
                fontSize: size.width * 0.03,
                letterSpacing: 1.0),
          ),
        ],
      ),
    );
  }

  Widget getTiles(text, size) {
    return Padding(
      padding: EdgeInsets.only(
          left: size.width * 0.03,
          top: size.height * 0.03,
          right: size.width * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$text",
            style: TextStyle(
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                color: colorHeader),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: colorHeader,
          )
        ],
      ),
    );
  }

  Future<void> _deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  /// this will delete app's storage
  Future<void> _deleteAppDir() async {
    final appDir = await getApplicationSupportDirectory();

    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
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
