// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:personal_dairy/Screens/Controllers/services_storage.dart';
import 'package:personal_dairy/utils/constants.dart';
import 'package:personal_dairy/widgets/custom_bottom_btn.dart';
import 'package:personal_dairy/widgets/custom_field.dart';
import 'package:personal_dairy/widgets/goal_field.dart';

import '../main.dart';
import '../widgets/custom_loading_indicator.dart';
import 'Authentication/main_auth.dart';

class AddJournals extends StatefulWidget {
  final title;
  final tags;
  final note;
  final image;
  final status;
  final id;

  const AddJournals(
      {Key? key,
      this.title,
      this.tags,
      this.note,
      this.status,
      this.image,
      this.id})
      : super(key: key);

  @override
  State<AddJournals> createState() => _AddJournalsState();
}

class _AddJournalsState extends State<AddJournals> {
  FirebaseStorage _storage = FirebaseStorage.instance;

  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController tagsController = TextEditingController();
  var todayy = DateFormat('EEEE').format(DateTime.now());

  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String formattedTime = DateFormat('kk:mm:a').format(DateTime.now());
  var imageSelected;
  var imageNetwork;
  var imageSelectedName;

  @override
  void initState() {
    titleController.text = (widget.title == null) ? "" : widget.title;
    noteController.text = (widget.note == null) ? "" : widget.note;
    tagsController.text = (widget.tags == null) ? "" : widget.tags;
    imageNetwork = widget.image;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var todayy = DateFormat('EEEE').format(DateTime.now());
    print(todayy);

    String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    String formattedTime = DateFormat('kk:mm:a').format(DateTime.now());
    print(DateTime.now());
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: colorHeader,
        centerTitle: true,
        actions: [
          (widget.id == null)
              ? SizedBox()
              : InkWell(
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection("Journals")
                        .doc(widget.id)
                        .delete()
                        .whenComplete(
                            () => Fluttertoast.showToast(msg: "Deleted"));
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.delete)),
        ],
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
              ? english['Add Journal']
              : (language == "Slovak")
                  ? slovak['Add Journal']
                  : czech['Add Journal'],
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: size.width * 0.01,
            right: size.width * 0.01,
            top: size.height * 0.02),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: size.width * 0.03,
                  right: size.width * 0.03,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      '$todayy',
                      style: TextStyle(
                          color: colorHeader,
                          fontSize: size.width * 0.04,
                          letterSpacing: 1.0),
                    ),
                    Container(
                      height: 20.0,
                      child: IntrinsicHeight(
                        child: VerticalDivider(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      "$formattedDate",
                      style: TextStyle(
                          color: colorHeader,
                          fontSize: size.width * 0.04,
                          letterSpacing: 1.0),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.03,
                    right: size.width * 0.03,
                    top: size.height * 0.02),
                child: Row(
                  children: [
                    Icon(
                      Icons.timer,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "$formattedTime",
                      style: TextStyle(
                          color: colorHeader,
                          fontSize: size.width * 0.04,
                          letterSpacing: 1.0),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              CustomFields(
                  controller: titleController,
                  hint: (language == "English")
                      ? english['Title']
                      : (language == "Slovak")
                          ? slovak['Title']
                          : czech['Title'],

                  // hint: "Title",
                  icon: Icons.title),
              GoalField(
                iconbin: SizedBox,

                controller: noteController,
                numb: 5,
                hint: (language == "English")
                    ? english['Type note here']
                    : (language == "Slovak")
                        ? slovak['Type note here']
                        : czech['Type note here'],

                // hint: "Type note here",
              ),
              CustomFields(
                  controller: tagsController,
                  // hint: "Tags",
                  hint: (language == "English")
                      ? english['Tags']
                      : (language == "Slovak")
                          ? slovak['Tags']
                          : czech['Tags'],
                  icon: Icons.tag),
              SizedBox(
                height: size.height * 0.02,
              ),
              (imageNetwork == null)
                  ? (imageSelected == null)
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomBottomButton(
                            onTap: () async {
                              var image = await ImagePicker.platform
                                  .pickImage(source: ImageSource.gallery);
                              imageSelected = image;

                              setState(() {});
                            },
                            title: "Pick Image",
                          ),
                        )
                      : Container(
                          height: size.height * 0.12,
                          width: size.width * 0.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                  image: FileImage(File(imageSelected!.path)))),
                        )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            height: size.height * 0.12,
                            width: size.width * 0.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                    image: NetworkImage(widget.image)))),
                        InkWell(
                            onTap: () async {
                              var image = await ImagePicker.platform
                                  .pickImage(source: ImageSource.gallery);
                              imageSelected = image;
                              print(imageSelected!.path);

                              if (image != null) {
                                print("ide");
                                imageNetwork = null;
                              } else {
                                print('ye');
                                imageNetwork = widget.image;
                              }
                              setState(() {});
                            },
                            child: Icon(Icons.edit_outlined))
                      ],
                    ),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.03,
                    right: size.width * 0.03,
                    top: size.height * 0.01,
                    bottom: size.height * 0.01),
                child: InkWell(
                    onTap: () async {
                      if (widget.status == 'update') {
                        print("updddd");
                        updateDoc(imageSelected);
                      } else {
                        uploadPic(imageSelected);
                      }
                    },
                    child: CustomBottomButton(
                      title: (language == "English")
                          ? english['Save']
                          : (language == "Slovak")
                              ? slovak['Save']
                              : czech['Save'],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  updateDoc(image) async {
    //Select Image

    if (imageSelected != null) {
      showLoadingIndicator("text");
      //Upload to Firebase
      var file = File(imageSelected!.path);

      var snapshot = await _storage
          .ref()
          .child('images/${imageSelected!.path.split('/').last}')
          .putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      var imageUrl;
      setState(() {
        imageUrl = downloadUrl;
      });

      var msg = updatejournal(
              titleController.text,
              imageUrl,
              tagsController.text,
              DateTime.now(),
              noteController.text,
              widget.id)
          .then((value) {
        Navigator.of(context).pop();
        Fluttertoast.showToast(msg: "Updated Successfully");
        Navigator.of(context).pop();
      });
      // ignore: unrelated_type_equality_checks

      setState(() {});
    } else if (imageNetwork != null) {
      showLoadingIndicator("text");
      print("update");
      var msg = updatejournal(
              titleController.text,
              widget.image,
              tagsController.text,
              DateTime.now(),
              noteController.text,
              widget.id)
          .then((value) {
        Navigator.of(context).pop();
        Fluttertoast.showToast(msg: "Updated Successfully");
        Navigator.of(context).pop();
      });
    } else {
      print('No Image Path Received');
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: 'No Image Path Received');
    }
  }

  uploadPic(image) async {
    //Select Image

    if (imageSelected != null) {
      var file = File(imageSelected!.path);

      showLoadingIndicator("text");
      //Upload to Firebase
      var snapshot = await _storage
          .ref()
          .child('images/${imageSelected!.path.split('/').last}')
          .putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      var imageUrl;
      setState(() {
        imageUrl = downloadUrl;
      });
      var msg = addjournal(titleController.text, imageUrl, tagsController.text,
              DateTime.now(), noteController.text)
          .then((value) {
        Navigator.of(context).pop();
        Fluttertoast.showToast(msg: "Uploaded Successfully");
      });
      // ignore: unrelated_type_equality_checks

      setState(() {
        titleController.clear();
        tagsController.clear();
        noteController.clear();
        imageSelected = null;
      });
    } else {
      print('No Image Path Received');
      var msg = addjournal(titleController.text, '', tagsController.text,
              DateTime.now(), noteController.text)
          .then((value) {
        Navigator.of(context).pop();
        Fluttertoast.showToast(msg: "Uploaded Successfully");
      });
      Fluttertoast.showToast(msg: 'No Image Path Received');
    }
  }

  //returns the download url

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
