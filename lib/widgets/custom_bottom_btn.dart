import 'package:flutter/material.dart';
import 'package:personal_dairy/utils/constants.dart';

class CustomBottomButton extends StatefulWidget {
  final onTap;
  final title;

  const CustomBottomButton({Key? key, this.onTap, this.title})
      : super(key: key);

  @override
  State<CustomBottomButton> createState() => _CustomBottomButtonState();
}

class _CustomBottomButtonState extends State<CustomBottomButton> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.only(
            top: size.height * 0.027, bottom: size.height * 0.02),
        decoration: BoxDecoration(
            color: colorHeader, borderRadius: BorderRadius.circular(10.0)),
        height: size.height * 0.067,
        child: Center(
            child: Text(
          (widget.title == null) ? "OK" : widget.title,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
              fontSize: size.width * 0.06),
        )),
      ),
    );
  }
}
