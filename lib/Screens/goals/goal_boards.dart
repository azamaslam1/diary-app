// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personal_dairy/Screens/Controllers/services_storage.dart';
import 'package:personal_dairy/widgets/big_image.dart';
import 'package:personal_dairy/widgets/expansion_tile.dart';

import '../../main.dart';
import '../../utils/constants.dart';
import '../../widgets/bottom_sheet.dart';
import '../../widgets/custom_loading_indicator.dart';
import '../Authentication/main_auth.dart';

class GoalBords extends StatefulWidget {
  const GoalBords({Key? key}) : super(key: key);

  @override
  State<GoalBords> createState() => _GoalBordsState();
}

class _GoalBordsState extends State<GoalBords> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  List<Widget> itemImages = [];

  var titleExpand;
  var title = [
    (language == "English")
        ? english['Personal Progress']
        : (language == "Slovak")
            ? slovak['Personal Progress']
            : czech['Personal Progress'],
    (language == "English")
        ? english['Time for yourself']
        : (language == "Slovak")
            ? slovak['Time for yourself']
            : czech['Time for yourself'],
    (language == "English")
        ? english['Work career']
        : (language == "Slovak")
            ? slovak['Work career']
            : czech['Work career'],
    (language == "English")
        ? english['Money and passive primes']
        : (language == "Slovak")
            ? slovak['Money and passive primes']
            : czech['Money and passive primes'],
    (language == "English")
        ? english['Family and relationships']
        : (language == "Slovak")
            ? slovak['Family and relationships']
            : czech['Family and relationships'],
    (language == "English")
        ? english['Health and fitness']
        : (language == "Slovak")
            ? slovak['Health and fitness']
            : czech['Health and fitness']
  ];
  var imageItems = [];
  var imagesListWork = [];
  var imagesListProgress = [];
  var imagesListMoney = [];
  var imagesListFamily = [];
  var imagesListHealth = [];
  var imagesListTime = [];
  List<Widget> imagesWidget = [];
  List<Widget> imagesWidgetWork = [];
  List<Widget> imagesWidgetTime = [];
  List<Widget> imagesWidgetMoney = [];
  List<Widget> imagesWidgetFamily = [];
  List<Widget> imagesWidgetHealth = [];

  Widget getImagesList(index, size, onTap) {
    if (index == 0) {
      if (imagesListProgress.isNotEmpty) {
        return getCarousel(size, imagesWidget);
      } else {
        return getPicker(title[index], size, onTap);
      }
    }
    if (index == 1) {
      print("this is $imagesListTime");
      if (imagesListTime.isNotEmpty) {
        return getCarousel(size, imagesWidgetTime);
      } else {
        return getPicker(title[index], size, onTap);
      }
    }

    if (index == 2) {
      print("2222");

      if (imagesListWork.isNotEmpty) {
        return getCarousel(size, imagesWidgetWork);
      } else {
        return getPicker(title[index], size, onTap);
      }
    }

    if (index == 3) {
      if (imagesListMoney.isNotEmpty) {
        return getCarousel(size, imagesWidgetMoney);
      } else {
        return getPicker(title[index], size, onTap);
      }
    }

    if (index == 4) {
      print('jfsdsjk $imagesListFamily');
      if (imagesListFamily.isNotEmpty) {
        return getCarousel(size, imagesWidgetFamily);
      } else {
        return getPicker(title[index], size, onTap);
      }
    }

    if (index == 5) {
      if (imagesListHealth.isNotEmpty) {
        return getCarousel(size, imagesWidgetHealth);
      } else {
        return getPicker(title[index], size, onTap);
      }
    }
    return getPicker(title[index], size, onTap);
  }

  var items = [];
  var status = 'loading';

  getData() async {
    User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection("GoalBoards")
        .where('uid', isEqualTo: user?.uid)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach(
        (f) => items.add(f.data()),
      );
    });

    setState(() {
      imagesListWork = items[0]['workCareer'];
      imagesListProgress = items[0]['imagesPersonalProgress'];
      imagesListTime = items[0]['timeForYourself'];
      imagesListFamily = items[0]['family'];
      imagesListHealth = items[0]['health'];
      imagesListMoney = items[0]['money'];
    });
    setState(() {});
    for (int i = 0; i < imagesListProgress.length; i++) {
      imagesWidget.add(Image.network(imagesListProgress[i]));
    }
    for (int i = 0; i < imagesListTime.length; i++) {
      imagesWidgetTime.add(Image.network(imagesListTime[i]));
    }
    for (int i = 0; i < imagesListWork.length; i++) {
      imagesWidgetWork.add(Image.network(items[0]['workCareer'][i]));
    }
    for (int i = 0; i < imagesListMoney.length; i++) {
      imagesWidgetMoney.add(Image.network(imagesListMoney[i]));
    }
    for (int i = 0; i < imagesListFamily.length; i++) {
      imagesWidgetFamily.add(Image.network(imagesListFamily[i]));
    }
    for (int i = 0; i < imagesListHealth.length; i++) {
      imagesWidgetHealth.add(Image.network(imagesListHealth[i]));
    }
    setState(() {
      print("this si $items");
    });
    status = "true";
    setState(() {});
  }

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  var indexImage = 0;

  var show = false;

  @override
  Widget build(BuildContext context) {
    print(items);
    var size = MediaQuery.of(context).size;
    print(imagesWidgetWork);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: colorHeader,
        centerTitle: true,
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
              ? english['Goal Boards']
              : (language == "Slovak")
                  ? slovak['Goal Boards']
                  : czech['Goal Boards'],
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    expansionTile(
                        Icons.picture_in_picture,
                        title[index],
                        size,
                        Column(
                          children: [
                            getImagesList(index, size, () {
                              selectImages(title[index]);
                            }),
                          ],
                        ),
                        false,
                        context,
                        ''),
                    SizedBox(
                      height: 5.0,
                    ),
                    Divider(
                      thickness: 3.0,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getText(txt, size) {
    return Padding(
      padding: EdgeInsets.only(
          left: size.width * 0.036,
          right: size.width * 0.036,
          bottom: size.height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$txt",
            style: TextStyle(
                color: Colors.black,
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0),
          ),
          InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (builder) {
                      return ModelSheetCustom();
                    });
              },
              child: Icon(
                Icons.info_outline,
                color: colorHeader,
              ))
        ],
      ),
    );
  }

  Widget getPicker(text, size, onTap) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: onTap,
          child: Column(
            children: [
              Icon(
                Icons.camera_alt_outlined,
                color: colorHeader,
                size: size.width * 0.2,
              ),
              Text(
                (language == "English")
                    ? english['Add Image']
                    : (language == "Slovak")
                        ? slovak['Add Image']
                        : czech['Add Image'],
                style: TextStyle(
                    color: Colors.pink,
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
              ),
            ],
          ),
        ));
  }

  Widget getCarousel(size, images) {
    return Stack(
      children: [
        Card(
          child: Container(
            height: size.height * 0.3,
            child: Column(
              children: [
                Container(
                    width: size.width * 0.5,
                    height: size.height * 0.2,
                    child: ImageSlideshow(
                      indicatorRadius: 5.0,
                      indicatorColor: colorHeader,
                      onPageChanged: (value) {
                        indexImage = value;
                        setState(() {});
                        debugPrint('Page changed: $value');
                      },
                      isLoop: true,
                      children: images,
                    )),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  width: 250.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: colorHeader,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: colorHeader,
                        child: InkWell(
                          onTap: () {
                            if (indexImage == 0) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ImageCustom(
                                            link: images[0],
                                          )));
                            }
                            if (indexImage == 1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ImageCustom(
                                            link: images[1],
                                          )));
                            }
                            if (indexImage == 2) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ImageCustom(
                                            link: images[2],
                                          )));
                            }
                            if (indexImage == 3) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ImageCustom(
                                            link: images[3],
                                          )));
                            }

                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageCustom(link:imageItems[0] ,)))
                          },
                          child: Icon(
                            Icons.open_in_new,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  uploadFiles(List<File> _images, title, status) async {
    var imageUrls =
        await Future.wait(_images.map((_image) => uploadFile(_image)));
    print(imageUrls);
    if (status == "Personal Progress") {
      var msg = await uploadImages("$title", imageUrls, imagesWidgetTime,
          imagesListWork, imagesListMoney, imagesListFamily, imagesListHealth);
    }
    if (status == "Work career") {
      var msg = await uploadImages("$title", imagesListProgress, imagesListTime,
          imageUrls, imagesListMoney, imagesListFamily, imagesListHealth);
    }
    if (status == "Time for yourself") {
      var msg = await uploadImages("$title", imagesListProgress, imageUrls,
          imagesListWork, imagesListMoney, imagesListFamily, imagesListHealth);
    }
    if (status == "Money and passive primes") {
      var msg = await uploadImages("$title", imagesListProgress, imagesListTime,
          imagesListWork, imageUrls, imagesListFamily, imagesListHealth);
    }
    if (status == "Family and relationships") {
      var msg = await uploadImages("$title", imagesListProgress, imagesListTime,
          imagesListWork, imagesListMoney, imageUrls, imagesListHealth);
    }
    if (status == "Health and fitness") {
      var msg = await uploadImages("$title", imagesListProgress, imagesListTime,
          imagesListWork, imagesListMoney, imagesListFamily, imageUrls);
    }
    await getData();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => GoalBords()));
  }

  void selectImages(
    title,
  ) async {
    final selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    showLoadingIndicator("Creating User");

    List<File> listt = [];
    print(imageFileList!.length);
    for (int i = 0; i < imageFileList!.length; i++) {
      listt.add(File(imageFileList![i].path));
    }
    await uploadFiles(listt, title, title);
    setState(() {});
  }

  Future<String> uploadFile(File _image) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('posts/${{_image!.path.split('/').last}}');
    UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.whenComplete(() => print("uploaded"));

    return await storageReference.getDownloadURL();
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
