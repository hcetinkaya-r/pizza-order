import 'package:flutter/material.dart';

import '../../../core/util/size_config.dart';
import '../../../models/ingredient/ingredient_model.dart';

class IngredientCard extends StatelessWidget {
  final Ingredient ingredient;
  final Widget button;
  final bool isInclude;

  const IngredientCard({this.button, this.ingredient, this.isInclude});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 1),
      elevation: 2,
      color: Theme.of(context).canvasColor.withOpacity(0.8),
      shadowColor: Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(SizeConfig.imagesSizeMultiplier * 1.5),
      ),
      child: Container(
        width: SizeConfig.widthMultiplier * 32,
        height: SizeConfig.heightMultiplier * 10,
        alignment: Alignment.center,
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 1),
          child: Row(
            children: <Widget>[
              Image.asset(
                ingredient.ingredientImgUrl,
                width: SizeConfig.widthMultiplier * 5,
                height: SizeConfig.heightMultiplier * 5,
              ),
              Text(ingredient.ingredientName,
                  style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 2.3,
                      fontWeight: FontWeight.w600)),
              Spacer(),
              isInclude
                  ? Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 2),
                      child: Text(' ${ingredient.price} ₺',
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 2.3,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor)))
                  : Container(),
              button
            ],
          ),
        ),
      ),
    );
  }
}
