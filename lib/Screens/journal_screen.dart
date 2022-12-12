import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:personal_dairy/Screens/new_main.dart';
import 'package:personal_dairy/Screens/search_screen.dart';
import 'package:personal_dairy/utils/constants.dart';

import '../widgets/header.dart';
import '../widgets/todo_item.dart';
import 'add_journals.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({Key? key}) : super(key: key);

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: colorHeader,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddJournals()));
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          FloatingActionButton(
            backgroundColor: bgColor,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchFeed()));
            },
            child: Icon(
              Icons.search,
              color: colorHeader,
            ),
          ),
        ],
      ),
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.2),
        child: CustomHeader(
          percent: percent,
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Journals')
              .where('uid', isEqualTo: user?.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              children: snapshot.data!.docs.map((document) {
                return Center(
                    child: ToDoItem(
                  image: (document['image'] == '')
                      ? Icon(
                          Icons.image_not_supported_outlined,
                          size: size.width * 0.13,
                        )
                      : Image.network(document['image']),
                  text: document['title'],
                  subtitle: document['note'],
                  onToDoChanged: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddJournals(
                                title: document['title'],
                                tags: document['tags'],
                                note: document['note'],
                                status: 'update',
                                image: document['image'],
                                id: document.id)));
                  },
                  onDeleteItem: () {
                    print("djsjd");
                    FirebaseFirestore.instance
                        .collection("Journals")
                        .doc(document.id)
                        .delete()
                        .whenComplete(
                            () => Fluttertoast.showToast(msg: "Deleted"));
                  },
                ));
              }).toList(),
            );
          }),
    ));
  }

  Future deleteData(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("Journals")
          .doc(id)
          .delete();
      setState(() {});
    } catch (e) {
      return false;
    }
  }
}
