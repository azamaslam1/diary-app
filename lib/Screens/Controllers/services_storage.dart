import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:personal_dairy/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Object> uploadImages(title, imagesProgres, imagesTime, imagesWork,
    imagesMoney, imagesFamily, imagesHealth) async {
  User? user = FirebaseAuth.instance.currentUser;
  try {
    await FirebaseFirestore.instance
        .collection("GoalBoards")
        .doc(user?.uid)
        .update({
      'title': title,
      'uid': user?.uid,
      'imagesPersonalProgress': imagesProgres,
      'timeForYourself': imagesTime,
      'workCareer': imagesWork,
      'money': imagesMoney,
      'family': imagesFamily,
      'health': imagesHealth,
    });
    return "Success";
  } catch (e) {
    return e;
  }
}

Future<Object> addjournal(title, image, tags, time, note) async {
  User? user = FirebaseAuth.instance.currentUser;
  try {
    await FirebaseFirestore.instance.collection("Journals").add({
      'uid': user?.uid,
      'title': title,
      'image': image,
      'datetime': time,
      'note': note,
      'tags': tags
    });
    return "Success";
  } catch (e) {
    return e;
  }
}

Future<Object> updatejournal(title, image, tags, time, note, id) async {
  User? user = FirebaseAuth.instance.currentUser;
  try {
    await FirebaseFirestore.instance.collection("Journals").doc(id).update({
      'uid': user?.uid,
      'title': title,
      'image': image,
      'datetime': time,
      'note': note,
      'tags': tags
    });
    return "Success";
  } catch (e) {
    return e;
  }
}

Future<Object> updateGoals(first, scnd, third, id, priority, habit) async {
  User? user = FirebaseAuth.instance.currentUser;
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var date = sharedPreferences.getString('date');
  DateTime dateTime = DateTime.parse(date!);

  var formattedDate = DateFormat('dd-MM-yyyy').format(dateTime!);
  print("tjfdsj    f$formattedDate");
  var dataUser = [];
  await FirebaseFirestore.instance
      .collection("userdata")
      .where('uid', isEqualTo: user?.uid)
      .get()
      .then((QuerySnapshot snapshot) {
    for (var f in snapshot.docs) {
      print(f.data());
      dataUser.add(f.data());
    }
  });
  print(dataUser);
  print("fnjsk");
  try {
    if (id == "goals" || id == "pleasures" || id == "habit") {
      await FirebaseFirestore.instance
          .collection("userdata")
          .doc(user?.uid)
          .update({
        'uid': user?.uid,
        "weekData": [
          {
            "date": formattedDate,
            "date": formattedDate,
            'goalsOfWeek1': goal1Field.text,
            'goalsOfWeek2': goal2Field.text,
            'goalsOfWeek3': goal3Field.text,
            'pleasureOfWeek1': pleasure1.text,
            'pleasureOfWeek2': pleasure2.text,
            'pleasureOfWeek3': pleasure3.text,
            'habitOfWeek': habitController.text,
          }
        ],
      });
    } else {
      await FirebaseFirestore.instance
          .collection("userdata")
          .doc(user?.uid)
          .update({
        'uid': user?.uid,
        "date": formattedDate,
        "$formattedDate": [
          {
            'feelings': 2,
            'gratitudeOfDay1': gratitude1.text,
            'gratitudeOfDay2': gratitude2.text,
            'gratitudeOfDay3': gratitude3.text,
            'priority': priorityController.text,
            'programOfDay1': program1.text,
            'programOfDay2': program2.text,
            'programOfDay3': program3.text,
            'ritualOfDay1': morningRitual.text,
            'ritualOfDay2': eveRitual.text,
            'successOfDay1': success1.text,
            'successOfDay2': success2.text,
            'successOfDay3': success3.text,
            'financeOfDay1': businessNumber.text,
            'financeOfDay2': personalNumber.text,
            'learningOfDay1': howwasmyday.text,
            'learningOfDay2': whatwouldido.text,
            'habitOfWeek': habitController.text,
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
      });
    }

    return "Success";
  } catch (e) {
    return e;
  }
}

Future<Object> addGoalsWho(
  category,
  text,
  time,
) async {
  User? user = FirebaseAuth.instance.currentUser;
  try {
    await FirebaseFirestore.instance.collection("WhoAmI").add({
      'uid': user?.uid,
      'category': category,
      'text': text,
      'datetime': time,
    });
    return "Success";
  } catch (e) {
    return e.toString();
  }
}

Future<Object> addRituals(
  category,
  text,
  time,
) async {
  User? user = FirebaseAuth.instance.currentUser;
  try {
    await FirebaseFirestore.instance.collection("Rituals").add({
      'text': text,
      'category': category,
      'time': time,
      'uid': user?.uid,
    });
    return "Success";
  } catch (e) {
    return e.toString();
  }
}
