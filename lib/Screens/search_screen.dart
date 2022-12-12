// ignore_for_file: unnecessary_const

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_search/firestore_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:personal_dairy/Models/data_model.dart';
import 'package:personal_dairy/utils/constants.dart';

import '../widgets/todo_item.dart';

class SearchFeed extends StatefulWidget {
  const SearchFeed({Key? key}) : super(key: key);

  @override
  _SearchFeedState createState() => _SearchFeedState();
}

class _SearchFeedState extends State<SearchFeed> {
  @override
  Widget build(BuildContext context) {
    return FirestoreSearchScaffold(
      appBarBackgroundColor: colorHeader,
      firestoreCollectionName: 'Journals',
      searchBy: 'tags',
      scaffoldBody: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: const Text('Search By Tags'),
          )
        ],
      ),
      dataListFromSnapshot: DataModel().dataListFromSnapshot,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<DataModel>? dataList = snapshot.data;
          if (dataList!.isEmpty) {
            return const Center(
              child: Text('No Results Returned'),
            );
          }
          return ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                final DataModel data = dataList[index];

                return ToDoItem(
                  image: Image.network(data.image!),
                  text: data.title,
                  subtitle: data.subtitle,
                  onToDoChanged: null,
                  onDeleteItem: () {
                    print("djsjd");
                    FirebaseFirestore.instance
                        .collection("Journals")
                        .doc(snapshot.data.doc.id)
                        .delete()
                        .whenComplete(
                            () => Fluttertoast.showToast(msg: "Deleted"));
                  },
                );
              });
        }

        if (snapshot.connectionState == ConnectionState.done) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text('No Results Returned'),
            );
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
