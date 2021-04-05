import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/components/widgets/filter.dart';
import '../../core/util/size_config.dart';
import '../../main/widgets/background_image.dart';
import '../../main/widgets/main_nav_bar.dart';
import 'widgets/open_order_card.dart';

enum PaymentStatus { Paid, Unpaid }

class OpenOrdersPage extends StatelessWidget {
  static const routeName = '/open-orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          BackgroundImage(),
          Filter(),
          MainNavBar(),
          Positioned(
            left: SizeConfig.widthMultiplier * 24,
            child: Container(
              height: SizeConfig.heightMultiplier * 95,
              width: SizeConfig.widthMultiplier * 74,
              margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.heightMultiplier * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        bottom: SizeConfig.heightMultiplier * 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Text(
                          'OPEN ORDERS',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConfig.textMultiplier * 5),
                        ),
                        IconButton(
                          color: Theme.of(context).primaryColor,
                          iconSize: SizeConfig.imagesSizeMultiplier * 3,
                          icon: Icon(Icons.search),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  OpenOrderTitles(),
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                  Expanded(
                    child: ListView.builder(
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return OpenOrderCard(
                            orderNo: 'SN046',
                            paymentTypeImgUrl: 'assets/images/swish.png',
                            amount: 74.84,
                            paymentResult: 'Paid',
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OpenOrderTitles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var style = TextStyle(
        fontSize: SizeConfig.textMultiplier * 3, fontWeight: FontWeight.bold);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            'Order No',
            style: style,
          ),
          Text(
            'Payment Method',
            style: style,
          ),
          Text(
            'Amount',
            style: style,
          ),
          Text(
            'Payment',
            style: style,
          ),
          Text(
            'Status',
            style: style,
          )
        ],
      ),
    );
  }
}
