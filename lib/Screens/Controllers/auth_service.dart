import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:personal_dairy/Screens/bottom.dart';
import 'package:shared_preferences/shared_preferences.dart';

GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference users = FirebaseFirestore.instance.collection('users');

// changing return type to void
// as bool was not needed here
void signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      final UserCredential authResult =
          await auth.signInWithCredential(credential);

      final User? user = authResult.user;

      var userData = {
        'name': googleSignInAccount.displayName,
        'provider': 'google',
        'photoUrl': googleSignInAccount.photoUrl,
        'email': googleSignInAccount.email,
        'uid': user?.uid,
        'feeling': 'okay'
      };

      users.doc(user?.uid).get().then((doc) async {
        if (doc.exists) {
          // old user
          print("old");
          doc.reference.update(userData);

          FirebaseFirestore.instance.collection("userdata").doc(user?.uid).set({
            'feelings': 2,
            'uid': user?.uid,
            'goalsOfWeek': [
              {'first': ""},
              {'scnd': ""},
              {'third': ""}
            ],
            'pleasureOfWeek': [
              {'first': ''},
              {'scnd': ''},
              {'third': ''}
            ],
            'gratitudeOfDay': [
              {'first': "1st Gratitude"},
              {'scnd': "2nd Gratitude"},
              {'third': '3rd Gratitude'}
            ],
            'priority': '',
            'programOfDay': [
              {'first': ''},
              {'scnd': ''},
              {'third': ''}
            ],
            'ritualOfDay': [
              {'first': ''},
              {'scnd': ''}
            ],
            'successOfDay': [
              {'first': ''},
              {'scnd': ''},
              {'third': ''}
            ],
            'financeOfDay': [
              {'first': ''},
              {'scnd': ''}
            ],
            'learningOfDay': [
              {'first': ''},
              {'scnd': ''}
            ],
            'habitOfWeek': '',
          });
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
          });
          var uid = user?.uid;

          SharedPreferences sp = await SharedPreferences.getInstance();
          sp.setBool('isloggedin', true);
          sp.setString('uid', uid!);

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => BottomBar(),
            ),
          );
        } else {
          // new user
          print("new");

          users.doc(user?.uid).set(userData);
          FirebaseFirestore.instance.collection("userdata").doc(user?.uid).set({
            'feelings': 2,
            'uid': user?.uid,
            'goalsOfWeek': [
              {'first': ""},
              {'scnd': ""},
              {'third': ""}
            ],
            'pleasureOfWeek': [
              {'first': ''},
              {'scnd': ''},
              {'third': ''}
            ],
            'gratitudeOfDay': [
              {'first': "1st Gratitude"},
              {'scnd': "2nd Gratitude"},
              {'third': '3rd Gratitude'}
            ],
            'priority': '',
            'programOfDay': [
              {'first': ''},
              {'scnd': ''},
              {'third': ''}
            ],
            'ritualOfDay': [
              {'first': ''},
              {'scnd': ''}
            ],
            'successOfDay': [
              {'first': ''},
              {'scnd': ''},
              {'third': ''}
            ],
            'financeOfDay': [
              {'first': ''},
              {'scnd': ''}
            ],
            'learningOfDay': [
              {'first': ''},
              {'scnd': ''}
            ],
            'habitOfWeek': '',
          });
          var uid = user?.uid;

          SharedPreferences sp = await SharedPreferences.getInstance();
          sp.setBool('isloggedin', true);
          sp.setString('uid', uid!);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => BottomBar(),
            ),
          );
        }
      });
    }
  } catch (PlatformException) {
    print(PlatformException);
    Fluttertoast.showToast(msg: "$PlatformException");
    // better show an alert here
  }
}

Future<Object> login(String email, String password) async {
  try {
    await auth.signInWithEmailAndPassword(email: email, password: password);
    return 'Logged In';
  } catch (e) {
    return e;
  }
}

Future<Object> signUp(String email, String password, username, language) async {
  try {
    await auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      User? user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance.collection("users").doc(user?.uid).set({
        'uid': user?.uid,
        'email': email,
        'username': username,
        'language': language,
        'password': password,
        'feeling': 'okay'
      });
    });
    return 'Register Successfully';
  } catch (e) {
    Fluttertoast.showToast(msg: "$e");
    return e;
  }
}

enum AuthStatus {
  successful,
  wrongPassword,
  emailAlreadyExists,
  invalidEmail,
  weakPassword,
  unknown,
}

class AuthExceptionHandler {
  static handleAuthException(FirebaseAuthException e) {
    AuthStatus status;
    switch (e.code) {
      case "invalid-email":
        status = AuthStatus.invalidEmail;
        break;
      case "wrong-password":
        status = AuthStatus.wrongPassword;
        break;
      case "weak-password":
        status = AuthStatus.weakPassword;
        break;
      case "email-already-in-use":
        status = AuthStatus.emailAlreadyExists;
        break;
      default:
        status = AuthStatus.unknown;
    }
    return status;
  }

  static String generateErrorMessage(error) {
    String errorMessage;
    switch (error) {
      case AuthStatus.invalidEmail:
        errorMessage = "Your email address appears to be malformed.";
        break;
      case AuthStatus.weakPassword:
        errorMessage = "Your password should be at least 6 characters.";
        break;
      case AuthStatus.wrongPassword:
        errorMessage = "Your email or password is wrong.";
        break;
      case AuthStatus.emailAlreadyExists:
        errorMessage =
            "The email address is already in use by another account.";
        break;
      default:
        errorMessage = "An error occured. Please try again later.";
    }
    return errorMessage;
  }
}
