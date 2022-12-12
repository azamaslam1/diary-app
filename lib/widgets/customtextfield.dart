import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.height,
    this.maxlines = 1,
    this.focus = false,
    this.hintTitle,
    this.title,
    this.pretitle,
    this.password = false,
    this.enable = true,
    this.textEditingController,
    this.validator,
    this.absure = false,
    this.onPress,
    this.keyboardType,
    this.onpassword,
  }) : super(key: key);
  final double? height;
  final bool? password;
  final bool? enable;

  final String? hintTitle;
  final String? title;
  final String? pretitle;
  final String? validator;
  final String? keyboardType;
  final VoidCallback? onPress;
  final bool? focus;
  final int? maxlines;
  final Widget? onpassword;
  final bool absure;

  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    String validateEmail(
      String? value,
    ) {
      Pattern pattern =
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          r"{0,253}[a-zA-Z0-9])?)*$";
      RegExp regex = RegExp(pattern.toString());
      if (!regex.hasMatch(value!)) {
        return "enter_valid_email";
      } else {
        return '';
      }
    }

    return Padding(
      padding: EdgeInsets.only(
        top: height! * 0.0,
      ),
      child: Column(
        children: [
          pretitle != "" && pretitle != null
              ? Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          '$pretitle',
                          style: const TextStyle(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ],
                )
              : const SizedBox(
                  height: 15,
                ),
          SizedBox(
            // height: height! * 0.06,
            child: TextFormField(
              maxLines: maxlines,
              autofocus: focus == true ? true : false,
              controller: textEditingController,
              keyboardType: keyboardType == "numeric"
                  ? TextInputType.number
                  : TextInputType.multiline,
              obscureText: absure,

              // obscureText: password == true ? true : false,
              style: TextStyle(
                color: Colors.black,
                fontSize: height! * 0.02,
              ),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    vertical: height! * 0.025, horizontal: height! * 0.02),
                isDense: true,
                // fillColor: lightbackground,
                // filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: Colors.grey.withOpacity(0.8),
                    width: 1.0,
                  ),
                ),
                enabled: enable == false ? false : true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ),
                ),
                suffixIcon: onpassword,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                      width: 0,
                      // style: BorderStyle.none,
                      color: Colors.green),
                ),
                hoverColor: Colors.blue,
                focusColor: Colors.blue,
                hintText: hintTitle,
                hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: height! * 0.020,
                    fontWeight: FontWeight.w500),
              ),
              validator: validator == "email"
                  ? validateEmail
                  : validator == 'no'
                      ? null
                      : (value) {
                          if (value!.isEmpty) {
                            return validator;
                          } else {}

                          return null;
                        },
              onTap: onPress,
            ),
          ),
        ],
      ),
    );
  }
}
