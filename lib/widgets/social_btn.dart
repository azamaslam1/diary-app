import 'package:flutter/material.dart';

class SocialButton extends StatefulWidget {
  final color;
  final text;
  final image;

  const SocialButton({Key? key, this.color, this.text, this.image})
      : super(key: key);

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Card(
        elevation: 5.0,
        child: Container(
          width: size.width,
          height: size.height * 0.07,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              SizedBox(
                width: size.width * 0.2,
              ),
              Image.asset(
                widget.image,
                width: size.width * 0.1,
              ),
              SizedBox(
                width: size.width * 0.03,
              ),
              Expanded(
                  child: Text(
                widget.text,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: size.width * 0.04,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.bold),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
