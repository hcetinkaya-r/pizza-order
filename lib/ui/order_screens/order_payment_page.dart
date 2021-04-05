import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kiosk_desktop/controllers/order/order_controller.dart';
import 'package:kiosk_desktop/models/order/order_model.dart';

import '../../core/components/widgets/filter.dart';
import '../../core/util/size_config.dart';
import '../../main/widgets/background_image.dart';
import '../../main/widgets/main_nav_bar.dart';
import 'widgets/payment_method_card.dart';
import 'widgets/payment_order__card.dart';

class OrderPaymentPage extends StatefulWidget {
  static const routeName = '/order-payment';

  final Order order;

  const OrderPaymentPage({Key key, this.order}) : super(key: key);

  @override
  _OrderPaymentPageState createState() => _OrderPaymentPageState();
}

class _OrderPaymentPageState extends State<OrderPaymentPage> {
  final controller = OrderController();

  @override
  void initState() {
    // TODO: implement initState

    controller.getOrder(context, widget.order.orderId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderId = ModalRoute.of(context).settings.arguments as String;


    return Scaffold(
      body: Stack(
        children: <Widget>[
          BackgroundImage(),
          Filter(),
          MainNavBar(),
          Positioned(
            left: SizeConfig.widthMultiplier * 22,
            child: Container(
              width: SizeConfig.widthMultiplier * 76,
              height: SizeConfig.heightMultiplier * 97,
              margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.heightMultiplier * 1,
                  horizontal: SizeConfig.widthMultiplier * 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.only(right: SizeConfig.widthMultiplier * 20),
                    margin:
                        EdgeInsets.only(left: SizeConfig.widthMultiplier * 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Order No: SN046',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        Text(
                          'ORDER',
                          style: TextStyle(color: Colors.black, fontSize: 50),
                        ),
                        Container(),
                      ],
                    ),
                  ),
                  Container(
                    height: SizeConfig.heightMultiplier * 85,
                    margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.heightMultiplier * 2,
                        horizontal: SizeConfig.widthMultiplier * 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: SizeConfig.widthMultiplier * 38,
                          height: SizeConfig.heightMultiplier * 85,
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: widget.order.products.length,
                                  itemBuilder: (context, index) =>
                                      PaymentOrderCard(
                                        productName: ,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        PaymentMethodCard(),
                      ],
                    ),
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
