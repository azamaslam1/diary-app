import 'package:flutter/material.dart';
import 'package:personal_dairy/utils/constants.dart';

class CustomFields extends StatefulWidget {
  final hint;
  final icon;
  final controller;
  final visibilty;
  final onTap;

  const CustomFields(
      {Key? key,
      this.hint,
      this.icon,
      this.controller,
      this.visibilty,
      this.onTap})
      : super(key: key);

  @override
  State<CustomFields> createState() => _CustomFieldsState();
}

class _CustomFieldsState extends State<CustomFields> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(
          left: size.width * 0.03,
          right: size.width * 0.03,
          top: size.height * 0.015,
          bottom: size.height * 0.01),
      child: TextFormField(
        controller: widget.controller,
        obscureText: (widget.visibilty == null) ? false : widget.visibilty,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          suffixIcon: InkWell(
              onTap: widget.onTap,
              child: Icon(
                widget.icon,
                color: colorHeader,
              )),
          hintText: '${widget.hint}',
          hintStyle: TextStyle(color: colorHeader),
          counterText: "",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: colorHeader)),
        ),
      ),
    );
  }
}
