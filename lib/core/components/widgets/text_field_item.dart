import 'package:flutter/material.dart';

class TextFieldItem extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final double vPadding;
  final double hPadding;
  final double fontSize;
  final double bottomMargin;
  final TextEditingController initialValue;
  final int index;

  TextFieldItem({
    this.width,
    this.height,
    this.radius,
    this.vPadding,
    this.hPadding,
    this.fontSize,
    this.bottomMargin,
    this.initialValue,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).canvasColor.withOpacity(0.8),
      margin: EdgeInsets.only(bottom: bottomMargin),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      elevation: 2,
      shadowColor: Colors.black38,
      child: Container(
        width: width,
        height: height,
        color: Colors.transparent,
        child: TextField(
          controller: initialValue,
          style: TextStyle(fontSize: fontSize),
          onEditingComplete: () {
            print('print');
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.transparent,
            contentPadding:
                EdgeInsets.symmetric(vertical: vPadding, horizontal: hPadding),
            border: OutlineInputBorder(
              /*borderRadius: BorderRadius.circular(
                radius,
              ),*/
              borderSide: BorderSide(
                  color: Colors.transparent, style: BorderStyle.none, width: 0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(
                  color: Colors.transparent, style: BorderStyle.none, width: 0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(
                  color: Colors.transparent, style: BorderStyle.none, width: 0),
            ),
          ),
        ),
      ),
    );
  }
}
