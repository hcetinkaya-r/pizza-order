import 'package:flutter/material.dart';

import '../../util/size_config.dart';

class CardItem extends StatelessWidget {
  final Widget button;
  final Widget title;
  final double width;
  final double height;
  final bool isTrue;
  final bool isMain;

  const CardItem({
    this.button,
    this.title,
    this.width,
    this.height,
    this.isTrue,
    this.isMain,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(SizeConfig.imagesSizeMultiplier * 1.5),
        side: BorderSide(color: Colors.transparent, style: BorderStyle.none),
      ),
      elevation: 4,
      shadowColor: Colors.grey.shade100,
      color: Theme.of(context).canvasColor.withOpacity(0.8),
      child: Container(
        width: width,
        height: height,
        child: isTrue
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: SizeConfig.widthMultiplier * 1,
                  ),
                  button,
                  SizedBox(width: SizeConfig.widthMultiplier * 2),
                  title,
                ],
              )
            : Row(
                mainAxisAlignment: isMain
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceAround,
                children: [
                  title,
                  Container(),
                  button,
                ],
              ),
      ),
    );
  }
}
