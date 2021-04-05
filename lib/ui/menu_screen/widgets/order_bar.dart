import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/components/buttons/elevated_button.dart';
import '../../../core/util/size_config.dart';
import '../../../models/order/order_model.dart';
import '../../order_screens/order_payment_page.dart';
import '../_components/order_item/order_item_card.dart';

class OrderBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderModel>(
      builder: (ctx, order, child) => Card(
        margin: EdgeInsets.only(top: SizeConfig.heightMultiplier * 5),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft:
                    Radius.circular(SizeConfig.imagesSizeMultiplier * 1.5))),
        color: Theme.of(context).canvasColor.withOpacity(.8),
        shadowColor: Colors.grey.shade100,
        elevation: 4,
        child: Container(
          height: SizeConfig.heightMultiplier * 80,
          width: SizeConfig.widthMultiplier * 23,
          decoration: BoxDecoration(
            border:
                Border.all(color: Colors.transparent, style: BorderStyle.none),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: SizeConfig.heightMultiplier * 60,
                width: SizeConfig.widthMultiplier * 38.4,
                child: Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Text(
                      'ORDER',
                      style: TextStyle(fontSize: SizeConfig.textMultiplier * 4),
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    Container(
                      height: SizeConfig.heightMultiplier * 40,
                      width: SizeConfig.widthMultiplier * 38.4,
                      alignment: Alignment.center,
                      child: order.activeOrder == null
                          ? Center(child: Text('No active order'))
                          : ListView.builder(
                              itemCount: order.activeOrder.products.length,
                              itemBuilder: (ctxList, index) => OrderItemCard(
                                item: order.activeOrder.products[index],
                              ),
                            ),
                    ),
                    Divider(
                      height: SizeConfig.heightMultiplier * 2,
                      thickness: SizeConfig.heightMultiplier * 0.1,
                      indent: SizeConfig.widthMultiplier * 2,
                      endIndent: SizeConfig.widthMultiplier * 2,
                    ),
                    Text(
                      'Total',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: SizeConfig.textMultiplier * 3.5),
                    ),
                    Text(
                      // ignore: lines_longer_than_80_chars
                      '${order.activeOrder?.totalPrice == null ? '' : order.activeOrder.totalPrice + (order.activeOrder.totalPrice * 0.12)}',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: SizeConfig.textMultiplier * 3.5),
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.heightMultiplier * 2),
              AppElevatedButton(
                fontSize: SizeConfig.textMultiplier * 3.5,
                buttonColor: Theme.of(context).accentColor,
                width: SizeConfig.widthMultiplier * 15,
                height: SizeConfig.heightMultiplier * 10,
                inColor: Colors.black87,
                radius: SizeConfig.imagesSizeMultiplier * 2,
                function: () => Navigator.pushNamed(
                    context, OrderPaymentPage.routeName,
                    arguments: order.activeOrder.orderId),
                /*     Navigator.pushNamed(context, OrderPaymentPage.routeName),*/
                child: Text(
                  'CONFIRM',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
