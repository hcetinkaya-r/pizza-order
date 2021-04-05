import 'package:flutter/material.dart';

enum ProductModelStatus {
  Ended,
  Loading,
  Error,
}

class Product {
  String productId;
  String productCategory;
  List<String> subProductIds;
  String productName;
  String productImgUrl;

  Product({
    @required this.productId,
    @required this.productCategory,
    @required this.subProductIds,
    @required this.productName,
    @required this.productImgUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      productId: json['productId'] ?? 0,
      productCategory: json['productCategory'] ?? 0,
      subProductIds: json['subProductIds'] == null
          ? []
          : List<String>.from(json['subProductIds'].map((x) => (x))),
      productName: json['productName'] ?? 'null',
      productImgUrl: json['productImgUrl'] ?? 'assets/images/null.png');

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'productCategory': productCategory,
        'subProductIds': subProductIds,
        'productName': productName,
        'productImgUrl': productImgUrl,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class ProductModel extends ChangeNotifier {
  final List<Product> _products = [];
  static List<Product> _selectedProducts = [];
  static List<Product> _editingProducts = [];
  static final List<Product> _editedProduct = [];

  Product selectedProduct;

  List<Product> get products => [..._products];

  List<Product> get selectedProducts => [..._selectedProducts];
  List<Product> get editingProducts => [..._editingProducts];
  List<Product> get editedProducts => [..._editedProduct];

  bool isVisible = false;
  ProductModelStatus _status;
  String _errorCode;
  String _errorMessage;

  String get errorCode => _errorCode;

  String get errorMessage => _errorMessage;

  ProductModelStatus get status => _status;

  ProductModel.instance() {
    ;
  }

  Product findById(String productId) {
    return _products.firstWhere((prod) => prod.productId == productId);
  }

  void setStatus(ProductModelStatus status) {
    _status = status;
    notifyListeners();
  }

  void addProduct(Product product) {
    setStatus(ProductModelStatus.Loading);

    _products.add(product);

    setStatus(ProductModelStatus.Ended);
  }

  void removeProduct(String productId) {
    setStatus(ProductModelStatus.Loading);

    _products.removeWhere((prd) => prd.productId == productId);

    setStatus(ProductModelStatus.Ended);
  }

  void addProductFromJson(Map<String, dynamic> data) {
    setStatus(ProductModelStatus.Loading);

    _products.add(Product.fromJson(data));

    setStatus(ProductModelStatus.Ended);
  }

  void addEditingListItem(Product prod) {
    setStatus(ProductModelStatus.Loading);
    _editingProducts.insert(0, prod);
    setStatus(ProductModelStatus.Ended);
  }

  void addEditedListItem(Product prod) {
    setStatus(ProductModelStatus.Loading);
    _editedProduct.insert(0, prod);
    setStatus(ProductModelStatus.Ended);
  }

  void createSelectedProducts(String categoryId, {String type}) async {
    if (status != ProductModelStatus.Loading) {
      setStatus(ProductModelStatus.Loading);
      type == 'edit'
          ? _editingProducts = await _products
              .where((sp) => sp.productCategory == categoryId)
              .toList()
          : _selectedProducts = await _products
              .where((sp) => sp.productCategory == categoryId)
              .toList();

      setStatus(ProductModelStatus.Ended);
    } else {
      return;
    }
  }

  void setSelectedProduct(String productId) async {
    setStatus(ProductModelStatus.Loading);

    selectedProduct = findById(productId);

    setStatus(ProductModelStatus.Ended);
  }

  void clearEditingProducts() {
    _editingProducts.clear();
  }

  // ignore: avoid_positional_boolean_parameters
  void setVisible(bool visibility) {
    setStatus(ProductModelStatus.Loading);
    isVisible = visibility;
    setStatus(ProductModelStatus.Ended);
  }
}
