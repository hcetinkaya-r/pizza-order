// import model

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../models/order/order_model.dart';
import '../../models/sub_product/sub_product_model.dart';

class OrderController {
  OrderController();

  Future<void> addOrderItem(
    BuildContext context, {
    SubProduct subProduct,
    double price,
    int piece,
    List<String> addedIngredients,
    List<String> removedIngredients,
  }) async {
    var orderModel = Provider.of<OrderModel>(context, listen: false);
    var rand = Random();
    var orderItem = OrderItem(
      id: rand.nextInt(999).toString(),
      imgUrl: subProduct.subProductImgUrl,
      productName: subProduct.subProductName,
      piece: piece,
      price: price,
      addedIngredients: addedIngredients,
      removedIngredients: removedIngredients,
    );
    await orderModel.addOrderItem(orderItem);
  }

  Future<void> increaseOrderItemPiece(
      BuildContext context, String orderItemId) async {
    var orderModel = Provider.of<OrderModel>(context, listen: false);

    await orderModel.increaseOrderItemPiece(orderItemId);
  }

  Future<void> decreaseOrderTimePiece(
      BuildContext context, String orderItemId) async {
    var orderModel = Provider.of<OrderModel>(context, listen: false);
    await orderModel.decreaseOrderItemPiece(orderItemId);
  }

  OrderItem getOrderItem(BuildContext context, String itemId) {
    var orderModel = Provider.of<OrderModel>(context, listen: false);

    return orderModel.orderItemFindById(itemId);
  }

  Order getOrder(BuildContext context, int orderId) {
    var orderModel = Provider.of<OrderModel>(context, listen: false);

    return orderModel.findById(orderId);
  }
}
