import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:personal_dairy/widgets/custom_bottom_btn.dart';
import 'package:personal_dairy/widgets/custom_field.dart';

import '../../main.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_loading_indicator.dart';
import '../Controllers/auth_service.dart';
import 'main_auth.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: colorHeader,
        title: Text((language == "English")
            ? english['Reset Password']
            : (language == "Slovak")
                ? slovak['Reset Password']
                : czech['Reset Password']),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.04,
            ),
            Text(
              (language == "English")
                  ? english['Go Back To LogIn']
                  : (language == "Slovak")
                      ? slovak['Go Back To LogIn']
                      : czech['Go Back To LogIn'],
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 1.0,
                  fontSize: size.width * 0.06),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              (language == "English")
                  ? english[
                      'We will send you an e-mail with a link to reset your password. Please enter the e-mail, associated with your account, below.']
                  : (language == "Slovak")
                      ? slovak[
                          'We will send you an e-mail with a link to reset your password. Please enter the e-mail, associated with your account, below.']
                      : czech[
                          'We will send you an e-mail with a link to reset your password. Please enter the e-mail, associated with your account, below.'],
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: colorHeader,
                  letterSpacing: 1.0,
                  fontSize: size.width * 0.037),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            CustomFields(
              hint: (language == "English")
                  ? english['Your e-mail address']
                  : (language == "Slovak")
                      ? slovak['Your e-mail address']
                      : czech['Your e-mail address'],

              // hint: "Your e-mail address",
              controller: emailController,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.03,
                  right: size.width * 0.03,
                  top: size.height * 0.01,
                  bottom: size.height * 0.01),
              child: InkWell(
                  onTap: () async {
                    final _auth = FirebaseAuth.instance;
                    var _status;
                    showLoadingIndicator("Creating User");
                    await _auth
                        .sendPasswordResetEmail(email: emailController.text)
                        .then((value) => _status = (language == "English")
                            ? english['Link Send to your email']
                            : (language == "Slovak")
                                ? slovak['Link Send to your email']
                                : czech['Link Send to your email'])
                        .catchError((e) => _status =
                            AuthExceptionHandler.handleAuthException(e));
                    Fluttertoast.showToast(msg: "$_status");
                    Navigator.of(context).pop();
                    setState(() {
                      emailController.clear();
                    });
                  },
                  child: CustomBottomButton(
                    title: (language == "English")
                        ? english['Reset my password']
                        : (language == "Slovak")
                            ? slovak['Reset my password']
                            : czech['Reset my password'],
                  )),
            ),
            Text(
              (language == "English")
                  ? english['Reset Password?']
                  : (language == "Slovak")
                      ? slovak['Reset Password?']
                      : czech['Reset Password?'],
              style: TextStyle(
                fontSize: 15.0,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
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
