import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../controllers/order/order_controller.dart';
import '../../../../core/components/buttons/circle_button.dart';
import '../../../../core/util/size_config.dart';
import '../../../../models/order/order_model.dart';

class OrderItemCard extends StatefulWidget {
  final OrderItem item;

  OrderItemCard({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  _OrderItemCardState createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  int piece;
  double price = 0.0;

  OrderController controller = OrderController();

  void calculateTotalPrice(double _price) {
    price = 0.0;
    setState(() {
      price = _price * piece;
    });
  }

  @override
  void initState() {
    super.initState();
    piece = (widget.item.piece);
    calculateTotalPrice(widget.item.price);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.heightMultiplier * 18,
      width: SizeConfig.widthMultiplier * 23,
      margin: EdgeInsets.symmetric(
          vertical: SizeConfig.heightMultiplier * 1,
          horizontal: SizeConfig.widthMultiplier * 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: SizeConfig.heightMultiplier * 9,
            width: SizeConfig.widthMultiplier * 8,
            child: Image.asset(
              widget.item.imgUrl ?? 'assets/images/special-pizzas.png',
              fit: BoxFit.contain,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 0.1,
                vertical: SizeConfig.heightMultiplier * 0.2),
            height: SizeConfig.heightMultiplier * 15,
            width: SizeConfig.widthMultiplier * 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${widget.item.productName ?? 'Mantarlı Pizza'}',
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontSize: SizeConfig.textMultiplier * 2.3)),
                Spacer(),
                Text('${widget.item.price * widget.item.piece} ₺',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).primaryColor,
                        fontSize: SizeConfig.textMultiplier * 2.4)),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: SizeConfig.heightMultiplier * 8,
                      width: SizeConfig.widthMultiplier * 2,
                      child: CircleButton(
                        constraints: BoxConstraints(
                            maxHeight: SizeConfig.heightMultiplier * 4,
                            maxWidth: SizeConfig.widthMultiplier * 4),
                        child: Icon(
                          Icons.remove,
                          size: SizeConfig.heightMultiplier * 3,
                        ),
                        color: Colors.grey.shade500,
                        onPressed: () => controller.decreaseOrderTimePiece(
                            context, widget.item.id),
                      ),
                    ),
                    Container(
                      width: SizeConfig.widthMultiplier * 5,
                      height: SizeConfig.heightMultiplier * 4,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 1),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(
                            SizeConfig.imagesSizeMultiplier * 3),
                      ),
                      child: Text('${widget.item.piece}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2,
                          )),
                    ),
                    Container(
                      height: SizeConfig.heightMultiplier * 8,
                      width: SizeConfig.widthMultiplier * 2,
                      child: CircleButton(
                        constraints: BoxConstraints(
                            maxHeight: SizeConfig.heightMultiplier * 4,
                            maxWidth: SizeConfig.widthMultiplier * 4),
                        child: Icon(
                          Icons.add,
                          size: SizeConfig.heightMultiplier * 3,
                        ),
                        color: Theme.of(context).accentColor,
                        onPressed: () => controller.increaseOrderItemPiece(
                            context, widget.item.id),
                      ),
                    ),
                    Spacer()
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
