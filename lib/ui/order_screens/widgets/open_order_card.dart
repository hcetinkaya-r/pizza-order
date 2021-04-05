import 'package:flutter/material.dart';

import '../../../core/components/buttons/circle_button.dart';
import '../../../core/util/size_config.dart';

class OpenOrderCard extends StatelessWidget {
  final String orderNo;
  final String paymentTypeImgUrl;

  final double amount;
  final String paymentResult;

  const OpenOrderCard(
      {this.orderNo, this.paymentTypeImgUrl, this.amount, this.paymentResult});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).canvasColor.withOpacity(0.8),
      margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 1),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(SizeConfig.imagesSizeMultiplier * 1.5),
      ),
      elevation: 4,
      shadowColor: Colors.grey.shade100,
      child: Container(
        height: SizeConfig.heightMultiplier * 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              orderNo,
              style: TextStyle(
                fontSize: SizeConfig.textMultiplier * 3,
              ),
            ),
            Container(
              child: Image(
                image: AssetImage(paymentTypeImgUrl),
                width: 53,
                height: 53,
              ),
            ),
            Text(
              amount.toStringAsFixed(2),
              style: TextStyle(
                fontSize: SizeConfig.textMultiplier * 3,
              ),
            ),
            paymentResult == 'Paid'
                ? CircleButton(
                    color: Theme.of(context).accentColor,
                    constraints: BoxConstraints(
                      maxWidth: SizeConfig.widthMultiplier * 40,
                      maxHeight: SizeConfig.heightMultiplier * 40,
                    ),
                    child: Icon(
                      Icons.done_rounded,
                      size: SizeConfig.imagesSizeMultiplier * 2,
                      color: Theme.of(context).canvasColor,
                    ))
                : ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(
                        fontSize: 25,
                      ),
                      primary: Theme.of(context).primaryColor,
                      minimumSize: Size(96, 51),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                    child: Text(
                      'Pay',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(
                  fontSize: 25,
                ),
                primary: Theme.of(context).accentColor,
                minimumSize: Size(96, 51),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
              ),
              child: Text(
                'Done',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
