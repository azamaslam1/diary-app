import 'package:flutter/material.dart';

import '../utils/constants.dart';

var statusSuggestion = false;

class GoalField extends StatefulWidget {
  final numb;
  final hint;
  final keyBoardType;
  final iconbin;
  final prefix;
  final status;
  final enable;
  final controller;
  final suggestions;
  var statusSuggestion;
  final onTap;
  late final ValueChanged<dynamic> onValueChanged;

  GoalField(
      {Key? key,
      this.numb,
      this.hint,
      this.keyBoardType,
      this.iconbin,
      this.controller,
      this.onTap,
      this.prefix,
      this.enable,
      this.status,
      this.suggestions,
      this.statusSuggestion})
      : super(key: key);

  @override
  State<GoalField> createState() => _GoalFieldState();
}

class _GoalFieldState extends State<GoalField> {
  List<SuggestionObject> suggestions = <SuggestionObject>[];
  List<String> suggestionStrings = [];
  List<dynamic> matchedItems = <dynamic>[];

  final TextEditingController _nameTextController = TextEditingController();

  void _textListenerFunctionality() {
    if (widget.controller.text.length > 0) {
      matchedItems.clear();
      widget.suggestions.forEach((f) {
        /// convert every string to upper case for only comparison with case insensitivity
        if (f.toUpperCase().contains(widget.controller.text.toUpperCase())) {
          matchedItems.add(f);
        }
      });

      // show items
      if (matchedItems.length > 0) {
        //////// Temporary fix for the bug when selecting string box pops up twice //////////
        if (matchedItems.length == 1 &&
            matchedItems[0] == widget.controller.text) {
          statusSuggestion = false;
        } else {
          statusSuggestion = true;
        }
      } else {
        statusSuggestion = false;
      }
      ////////////////
      setState(() {});
    } else {
      matchedItems.clear();
      //////////////
      setState(() {
        statusSuggestion = false;
      });
    }
  }

  //On choosing an item
  _onItemTap(String selectedItem) {
    widget.suggestions.clear();
    setState(() {
      widget.controller.text = selectedItem;
      statusSuggestion = false;

      widget.onValueChanged(selectedItem);
    });
  }

  @override
  void initState() {
    widget.controller.addListener(_textListenerFunctionality);

    super.initState();
  }

  Widget getSimpleDialog(size) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        contentPadding: EdgeInsets.only(top: 0.0),
        scrollable: true,
        // title:
        // Container(height: size.height*0.05,width: size.width,decoration: BoxDecoration(
        //   color: bgColor,
        //   borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0))
        // ),

        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Center(
        //       child:Text("History",style: TextStyle(color: colorHeader,fontWeight: FontWeight.bold,fontSize: size.width*0.06),) ,
        //     ),
        //     InkWell(
        //         onTap: (){
        //           Navigator.of(context).pop();
        //         },
        //         child: Icon(Icons.cancel_outlined,color: colorHeader,size: size.width*0.08,))
        //   ],
        // ),
        // ),
        content: Column(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.09,
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              decoration: BoxDecoration(
                color: colorHeader,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: size.width * 0.3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Text(
                        "History",
                        style: TextStyle(
                            color: bgColor,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.055),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: size.width * 0.02),
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.cancel_outlined,
                            color: bgColor,
                            size: size.width * 0.08,
                          )),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 300.0,
              width: 300.0,
              child: ListView.builder(
                itemCount: widget.suggestions.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      widget.controller.text = widget.suggestions[i];
                      statusSuggestion = false;
                      Navigator.of(context).pop();

                      setState(() {});
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.label_important_outline_rounded,
                        color: colorHeader,
                      ),
                      title: Text(widget.suggestions[i]),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }

  Widget getPopup(size) {
    return Padding(
      padding: EdgeInsets.only(left: size.width * 0.35, top: size.height * 0.1),
      child: Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)), //this right here
        child: Container(
            height: 250.0,
            width: 300.0,
            child: ListView.builder(
              itemCount: widget.suggestions.length,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () {
                    widget.controller.text = widget.suggestions[i];
                    statusSuggestion = false;
                    Navigator.of(context).pop();

                    setState(() {});
                  },
                  child: ListTile(
                    title: Text(widget.suggestions[i]),
                  ),
                );
              },
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
          left: size.width * 0.03,
          right: size.width * 0.03,
          bottom: size.height * 0.01,
          top: size.height * 0.01),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.0,
          ),
          Container(
              child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                //  onFieldSubmitted: (val)async{
                //   var msg= await addRituals("status", "val", DateTime.now());
                // if(msg=="Success"){
                //   Fluttertoast.showToast(msg: "Added");
                // }
                //
                //  },
                onChanged: (val) {},

                enabled: (widget.enable == null) ? true : widget.enable,
                onEditingComplete: widget.onTap,
                controller: widget.controller,

                keyboardType: (widget.keyBoardType == null)
                    ? TextInputType.text
                    : widget.keyBoardType,

                maxLines: 3,
                // textInputAction: TextInputAction.,

                decoration: InputDecoration(
                  suffixIcon: (widget.iconbin == null)
                      ? InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    getSimpleDialog(size));

                            // statusSuggestion=true;
                            setState(() {});
                          },
                          child: Icon(Icons.history))
                      : SizedBox(),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: colorHeader),
                      borderRadius: BorderRadius.circular(14.0)),
                  hintText: widget.hint,
                ),
              ),
            ),
          )),
          Visibility(
            visible: statusSuggestion,
            child: Column(
              children: [
                Container(
                  height: size.height * 0.15,
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: colorHeader, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width,
                        maxHeight: MediaQuery.of(context).size.height * 0.2),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: matchedItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () => _onItemTap(matchedItems[index]),
                                child: Text(
                                  "${matchedItems[index]}",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 22),
                                ),
                              ),
                              Divider(
                                color: Colors.black54,
                              ),
                            ],
                          ));
                        }),
                  ),
                ),
                Container(
                  height: size.height * 0.05,
                  padding: EdgeInsets.only(
                      left: size.width * 0.02, right: size.width * 0.02),
                  decoration: BoxDecoration(
                    color: colorHeader,
                    border: Border.all(color: colorHeader, width: 2),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.short_text_sharp,
                        color: Colors.white,
                        size: size.width * 0.08,
                      ),
                      InkWell(
                          onTap: () {
                            statusSuggestion = false;
                            setState(() {});
                          },
                          child: Icon(
                            Icons.clear,
                            size: size.width * 0.08,
                            color: bgColor,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SuggestionObject {
  String name;
  int id;

  SuggestionObject({required this.name, required this.id});
}
