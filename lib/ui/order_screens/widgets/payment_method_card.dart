import 'package:flutter/material.dart';
import '../../../core/components/buttons/elevated_button.dart';

import '../../../core/util/size_config.dart';
import 'payment_button.dart';

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: SizeConfig.widthMultiplier * 28,
      height: SizeConfig.heightMultiplier * 85,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  width: SizeConfig.widthMultiplier * 27,
                  child: Text(
                    'Payment Method',
                    style: TextStyle(fontSize: SizeConfig.textMultiplier * 4.5),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    PaymentButton(
                      imgUrl: 'assets/images/swish.png',
                      method: 'Swish',
                    ),
                    PaymentButton(
                      imgUrl: 'assets/images/cash.png',
                      method: 'Cash',
                    ),
                    PaymentButton(
                      imgUrl: 'assets/images/credit_card.png',
                      method: 'Credit Card',
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Text(
                    'Subtotal:',
                    style: TextStyle(fontSize: 45),
                  ),
                  trailing: Text(
                    '69.30 TL',
                    style: TextStyle(
                      fontSize: 37,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ListTile(
                  leading: Text(
                    'Tax:',
                    style: TextStyle(fontSize: 45),
                  ),
                  trailing: Text(
                    '5.54 TL',
                    style: TextStyle(
                      fontSize: 37,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ListTile(
                  leading: Text(
                    'TOTAL:',
                    style: TextStyle(
                      fontSize: 45,
                    ),
                  ),
                  trailing: Text(
                    '74.84 TL',
                    style: TextStyle(
                        fontSize: 37, color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          ),
          AppElevatedButton(
            fontSize: SizeConfig.textMultiplier * 4,
            inColor: Colors.black87,
            buttonColor: Theme.of(context).accentColor,
            width: SizeConfig.widthMultiplier * 18,
            height: SizeConfig.heightMultiplier * 8,
            radius: SizeConfig.imagesSizeMultiplier * 1.5,
            child: Text('Pay'),
            function: () {},
          ),
        ],
      ),
    );
  }
}
