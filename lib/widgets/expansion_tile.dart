import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'bottom_sheet.dart';

Widget expansionTile(
    icon, text, size, _widget, status, BuildContext context, statuss) {
  return ExpansionTile(
    initiallyExpanded: status,
    title: Row(
      children: [
        Container(
          width: size.width * 0.6,
          child: Row(
            children: [
              Icon(
                icon,
                color: colorHeader,
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Text(
                  '$text',
                  style: TextStyle(
                      color: colorHeader,
                      overflow: TextOverflow.ellipsis,
                      fontSize: size.width * 0.044,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: size.width * 0.05,
        ),
        InkWell(
            onTap: () {
              showModalBottomSheet(
                  builder: (builder) {
                    return ModelSheetCustom(
                      status: statuss,
                    );
                  },
                  context: context);
            },
            child: Icon(
              Icons.info_outline,
              color: colorHeader,
            ))
      ],
    ),
    children: [
      SizedBox(
        height: size.width * 0.02,
      ),
      _widget,
      SizedBox(
        height: size.width * 0.02,
      )
    ],
  );
}
