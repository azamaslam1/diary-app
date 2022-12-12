import 'package:dart_quote/widget_quote.dart';
import 'package:flutter/material.dart';
import 'package:personal_dairy/utils/constants.dart';
import 'package:personal_dairy/utils/info_data.dart';
import 'package:personal_dairy/widgets/custom_bottom_btn.dart';

import '../Screens/Authentication/main_auth.dart';
import '../main.dart';

class ModelSheetCustom extends StatefulWidget {
  final status;

  const ModelSheetCustom({Key? key, this.status}) : super(key: key);

  @override
  State<ModelSheetCustom> createState() => _ModelSheetCustomState();
}

class _ModelSheetCustomState extends State<ModelSheetCustom> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.34,
      color: Colors.transparent, //could change this to Color(0xFF737373),
      child: Container(
          padding: EdgeInsets.only(
              left: size.width * 0.04, right: size.width * 0.04),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20.0),
                  topRight: const Radius.circular(20.0))),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.025,
                ),
                Container(
                  width: size.width * 0.2,
                  height: 5.0,
                  color: colorHeader,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  (language == "English")
                      ? english['Information']
                      : (language == "Slovak")
                          ? slovak['Information']
                          : czech['Information'],
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width * 0.06,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                (widget.status == "whoami")
                    ? Container(
                        width: size.width * 0.95,
                        child: Column(
                          children: [
                            WidgetQuote(
                                    padding: EdgeInsets.all(10.0),
                                    text: quoteData)
                                .quote(),
                            Text(
                              infoQuoteBelow,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: size.width * 0.04,
                              ),
                            ),
                            Divider(),
                            Text(
                              infoBelow3,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: size.width * 0.04,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        width: size.width * 0.95,
                        child: Text(
                          (widget.status == "goals")
                              ? infoGoalText
                              : (widget.status == "pleasure")
                                  ? infoPleasureText
                                  : (widget.status == "gratitude")
                                      ? infoGratitudeText
                                      : (widget.status == "priority")
                                          ? infoPriorityText
                                          : (widget.status == "programs")
                                              ? infoProgramText
                                              : (widget.status == "rituals")
                                                  ? infoRitualsText
                                                  : (widget.status == "Success")
                                                      ? infoSuccesseText
                                                      : (widget.status ==
                                                              "Learning")
                                                          ? infoLearningText
                                                          : (widget.status ==
                                                                  "finance")
                                                              ? infoFinanceText
                                                              : (widget.status ==
                                                                      "habit")
                                                                  ? infoHabitText
                                                                  : "",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: size.width * 0.04,
                          ),
                        ),
                      ),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: CustomBottomButton(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }
}
