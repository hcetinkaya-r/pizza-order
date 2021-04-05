import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../../../core/util/size_config.dart';

class PaymentOrderCard extends StatelessWidget {
  final String productName;
  final int amount;
  final String imgUrl;
  final List ingredients;
  final double price;

  const PaymentOrderCard(
      {this.productName,
      this.amount,
      this.imgUrl,
      this.ingredients,
      this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 1),
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(SizeConfig.imagesSizeMultiplier * 3)),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 1,
        ),
        height: SizeConfig.heightMultiplier * 27,
        //width: SizeConfig.widthMultiplier * 30,
        child: Row(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.keyboard_arrow_up),
                    color: Theme.of(context).accentColor,
                    iconSize: SizeConfig.imagesSizeMultiplier * 3,
                    onPressed: () {}),
                Text(
                  '$amount',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: SizeConfig.textMultiplier * 3),
                ),
                IconButton(
                    icon: Icon(Icons.keyboard_arrow_down),
                    color: Theme.of(context).accentColor,
                    iconSize: SizeConfig.imagesSizeMultiplier * 3,
                    onPressed: () {}),
              ],
            ),
            Container(
              child: Image(
                image: AssetImage(imgUrl),
                width: SizeConfig.widthMultiplier * 10,
                height: SizeConfig.heightMultiplier * 13.5,
              ),
            ),
            Container(
              width: SizeConfig.widthMultiplier * 13,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    productName,
                    style: TextStyle(fontSize: SizeConfig.textMultiplier * 4),
                  ),
                  Container(
                    height: SizeConfig.heightMultiplier * 20,
                    child: ListView.builder(
                        itemCount: ingredients.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.add,
                                  color: Colors.red,
                                  size: SizeConfig.imagesSizeMultiplier * 2,
                                ),
                                Text(
                                  ingredients[index],
                                  style: TextStyle(
                                      fontSize: SizeConfig.textMultiplier * 3),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            Container(
              width: SizeConfig.widthMultiplier * 10,
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.heightMultiplier * 1,
                  horizontal: SizeConfig.widthMultiplier * 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        iconSize: SizeConfig.imagesSizeMultiplier * 2,
                        icon: Icon(
                          Icons.close,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '$price',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: SizeConfig.textMultiplier * 3),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
