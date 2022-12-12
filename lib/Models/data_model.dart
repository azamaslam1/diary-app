import 'package:cloud_firestore/cloud_firestore.dart';

class DataModel {
  final String? title;
  final String? image;
  final String? subtitle;
  final id;

  DataModel({this.title, this.image, this.subtitle, this.id});

  //Create a method to convert QuerySnapshot from Cloud Firestore to a list of objects of this DataModel
  //This function in essential to the working of FirestoreSearchScaffold
  List<DataModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
          snapshot.data() as Map<String, dynamic>;

      return DataModel(
          image: dataMap['image'],
          title: dataMap['title'],
          id: dataMap['uid'],
          subtitle: dataMap['note']);
    }).toList();
  }
}
