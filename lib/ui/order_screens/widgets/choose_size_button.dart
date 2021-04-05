import 'package:flutter/material.dart';

import '../../../core/util/size_config.dart';

class ChooseSizeButton extends StatelessWidget {
  final String sizeName;
  final double price;
  final bool isSelected;

  const ChooseSizeButton({this.sizeName, this.price, this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(right: SizeConfig.widthMultiplier * 2),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(SizeConfig.imagesSizeMultiplier * 1.6),
      ),
      color: isSelected
          ? Colors.green.withOpacity(.8)
          : Theme.of(context).canvasColor.withOpacity(.8),
      elevation: 4,
      shadowColor: Colors.grey.shade400,
      child: Container(
        height: SizeConfig.heightMultiplier * 25,
        width: SizeConfig.widthMultiplier * 11,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(sizeName,
                style: TextStyle(fontSize: SizeConfig.textMultiplier * 4)),
            Text(
              '${price.toStringAsFixed(2)} ₺',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.textMultiplier * 4),
            ),
          ],
        ),
      ),
    );
  }
}
