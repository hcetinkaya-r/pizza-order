import 'dart:math';

import 'package:flutter/material.dart';

enum OrderModelStatus {
  Ended,
  Loading,
  Error,
}

enum OrderType{package,inPlace}

enum PaymentMethod { cash, creditCard, swish, none, cashier}



/*enum PaymentMethod {
  @JsonValue('cash')
  CASH,
  @JsonValue('creditCard')
  CREDIT_CARD,
  @JsonValue('swish')
  SWISH,
  @JsonValue('none')
  NONE
}*/

/*@JsonSerializable()
class Payment {
  final String name;
  final PaymentMethod paymentMethod;

  Payment(this.name, this.paymentMethod);
}*/

class OrderItem {
  String id;
  String imgUrl;
  String productName;
  List<String> addedIngredients;
  List<String> removedIngredients;
  double price;
  int piece;

  OrderItem(
      {this.id,
      this.imgUrl,
      this.productName,
      this.piece,
      this.price,
      this.addedIngredients,
      this.removedIngredients});
}

class Order {
  int orderId;
  List<OrderItem> products;
  double totalPrice;
  PaymentMethod paymentMethod;
  DateTime orderTime;

  Order(
      {@required this.orderId,
      this.products,
      this.totalPrice = 0,
      this.paymentMethod = PaymentMethod.none,
      this.orderTime});

  factory Order.fromJson(Map<String, dynamic> json) =>
      Order(
          orderId: json['orderId'] ?? 0,
          products: json['products'] == null
              ? []
              : List<String>.from(json['products'].map((x) => (x))),
          totalPrice: double.parse(json['totalPrice']) ?? 0,
          paymentMethod: json['paymentMethod'],
          orderTime: json['orderTime']) ??
      DateTime.now();

  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'products': products,
        'totalPrice': totalPrice.toString(),
        'paymentMethod': paymentMethod,
        'orderTime': orderTime.millisecondsSinceEpoch
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class OrderModel extends ChangeNotifier {
  final List<Order> _orders = [];
  Order activeOrder;

  OrderModelStatus _status;
  String _errorCode;
  String _errorMessage;

  String get errorCode => _errorCode;

  String get errorMessage => _errorMessage;

  OrderModelStatus get status => _status;

  List<Order> get orders {
    return [..._orders];
  }

  OrderModel.instance() {
    //TODO Add code here
    ;
  }

  void addOrderItem(OrderItem orderItem) {
    setStatus(OrderModelStatus.Loading);

    if (activeOrder == null) {
      var rand = Random();
      activeOrder = Order(
          orderId: rand.nextInt(15),
          orderTime: DateTime.now(),
          products: [orderItem]);

      _orders.add(activeOrder);
      calculateTotalPrice();
    } else {
      activeOrder.products.add(orderItem);
      calculateTotalPrice();
    }
  }

  void deleteOrderItem(String orderItemId) {
    setStatus(OrderModelStatus.Loading);
    activeOrder.products
        .removeWhere((orderItem) => orderItem.id == orderItemId);
    calculateTotalPrice();
  }

  void increaseOrderItemPiece(String orderItemId) {
    setStatus(OrderModelStatus.Loading);

    var orderItem = orderItemFindById(orderItemId);

    orderItem.piece++;

    calculateTotalPrice();
  }

  void decreaseOrderItemPiece(String orderItemId) {
    setStatus(OrderModelStatus.Loading);

    var orderItem = orderItemFindById(orderItemId);
    orderItem.piece > 1 ? orderItem.piece-- : null;

    calculateTotalPrice();
  }

  void calculateTotalPrice() {
    var totalPrice = 0.0;

    for (var orderItem in activeOrder.products) {
      totalPrice += orderItem.price * orderItem.piece;
    }

    activeOrder.totalPrice = totalPrice;
    setStatus(OrderModelStatus.Ended);
  }

  Order findById(int id) {
    return _orders.firstWhere((order) => order.orderId == id);
  }

  OrderItem orderItemFindById(String id) {
    return activeOrder.products.firstWhere((product) => product.id == id);
  }

  void setStatus(OrderModelStatus _orderModelStatus) {
    _status = _orderModelStatus;
    notifyListeners();
  }
}
