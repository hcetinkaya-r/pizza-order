import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/util/size_config.dart';
import '../../../../models/category/category_model.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  final bool isSelected;

  const CategoryItem({this.category, this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected
          ? Theme.of(context).primaryColor
          : Theme.of(context).canvasColor.withOpacity(.8),
      elevation: 6,
      shadowColor: Colors.grey.shade400,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(SizeConfig.imagesSizeMultiplier * 3),
      ),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: AssetImage(
                category.categoryImgUrl,
              ),
              height: SizeConfig.imagesSizeMultiplier * 6,
              width: SizeConfig.imagesSizeMultiplier * 6,
            ),
            Text(
              category.categoryName,
              style: TextStyle(
                  color:
                      isSelected ? Theme.of(context).canvasColor : Colors.black,
                  fontSize: SizeConfig.textMultiplier * 2.75),
            ),
          ],
        ),
      ),
    );
  }
}
