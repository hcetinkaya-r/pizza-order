import 'package:flutter/material.dart';

import '../../../controllers/order/order_controller.dart';
import '../../../core/components/buttons/elevated_button.dart';
import '../../../core/util/size_config.dart';
import '../../../models/sub_product/sub_product_model.dart';
import '../edit_order_page.dart';

// ignore: must_be_immutable
class OrderCard extends StatefulWidget {
  SubProduct subProduct;
  OrderCardItem orderItem;
  OrderCard({
    this.orderItem,
    this.subProduct,
  });

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConfig.widthMultiplier * 2),
      ),
      color: Theme.of(context).canvasColor.withOpacity(.8),
      elevation: 4,
      shadowColor: Colors.grey.shade400,
      child: Container(
        width: SizeConfig.widthMultiplier * 25,
        height: SizeConfig.heightMultiplier * 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: SizeConfig.textMultiplier * 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Quantity',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: SizeConfig.textMultiplier * 4),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          InkWell(
                            onTap: () => setState(() {
                              widget.orderItem.piece++;
                            }),
                            child: Icon(
                              Icons.keyboard_arrow_up,
                              color: Theme.of(context).accentColor,
                              size: SizeConfig.textMultiplier * 4,
                            ),
                          ),
                          Text(
                            '${widget.orderItem.piece}',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: SizeConfig.textMultiplier * 4),
                          ),
                          InkWell(
                            onTap: () => setState(() {
                              if (widget.orderItem.piece > 1) {
                                widget.orderItem.piece--;
                              }
                            }),
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: Theme.of(context).accentColor,
                              size: SizeConfig.textMultiplier * 4,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.textMultiplier * 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: SizeConfig.textMultiplier * 4),
                      ),
                      Text(
                        '${widget.orderItem.price * widget.orderItem.piece} ₺',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: SizeConfig.textMultiplier * 4),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      var orderController = OrderController();
                      var addedIngredient = List.generate(
                          widget.orderItem.addedIngredients.length,
                          (index) => widget.orderItem.addedIngredients[index]
                              .ingredientName);
                      var removedIngredient = List.generate(
                          widget.orderItem.removedIngredients.length,
                          (index) => widget.orderItem.removedIngredients[index]
                              .ingredientName);

                      orderController.addOrderItem(context,
                          addedIngredients: addedIngredient,
                          removedIngredients: removedIngredient,
                          piece: widget.orderItem.piece,
                          price: widget.orderItem.price,
                          subProduct: widget.subProduct);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 2.5,
                      ),
                      primary: Theme.of(context).accentColor,
                      minimumSize: Size(SizeConfig.widthMultiplier * 18.6,
                          SizeConfig.heightMultiplier * 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                              SizeConfig.imagesSizeMultiplier * 1.5),
                        ),
                      ),
                    ),
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 3),
                  AppElevatedButton(
                    fontSize: SizeConfig.textMultiplier * 2.5,
                    textColor: Colors.black,
                    inColor: Colors.black,
                    buttonColor: Colors.grey,
                    width: SizeConfig.widthMultiplier * 18.6,
                    height: SizeConfig.heightMultiplier * 8,
                    radius: SizeConfig.imagesSizeMultiplier * 1.5,
                    child: Text(
                      'Cancel',
                    ),
                    function: () => Navigator.pop(context),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
