import 'package:flutter/material.dart';

import '../dimension/dimension_model.dart';

enum SubProductModelStatus {
  Ended,
  Loading,
  Error,
}

class SubProduct {
  String subProductId;
  String subProductImgUrl;
  String subProductName;
  List<String> ingredients;
  double price;
  List<Dimension> dimension;

  SubProduct({
    this.subProductId,
    this.subProductImgUrl,
    this.subProductName,
    this.ingredients,
    this.price,
    this.dimension,
  });

  factory SubProduct.fromJson(Map<String, dynamic> json) => SubProduct(
        subProductId: json['subProductId'] ?? 0,
        subProductImgUrl: json['subProductImgUrl'] ?? 'assets/images/null.png',
        subProductName: json['subProductName'] ?? 'null',
        ingredients: json['ingredients'] == null
            ? []
            : List<String>.from(json['ingredients'].map((x) => (x))),
        price: double.parse(json['price']) ?? 0,
        dimension: json['dimension'] == null
            ? []
            : List<Dimension>.from(
                json['dimension'].map((x) => Dimension.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'subProductId': subProductId,
        'subProductImgUrl': subProductImgUrl,
        'subProductName': subProductName,
        'ingredients': ingredients,
        'price': price.toString(),
        'dimension': List<dynamic>.from(dimension.map((e) => e.toJson())),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class SubProductModel extends ChangeNotifier {
  final List<SubProduct> _subProducts = [];
  static List<SubProduct> _selectedSubProducts = [];
  SubProduct _selectedSubProduct;
  Dimension _dimension;
  static List<Dimension> _dimensions;

  static final List<SubProduct> _editingSubProducts = [];
  static final List<SubProduct> _editedSubProducts = [];

  bool isVisible = false;

  SubProductModelStatus _status;
  String _errorCode;
  String _errorMessage;

  List<SubProduct> get subProducts => [..._subProducts];

  List<SubProduct> get selectedSubProducts => [..._selectedSubProducts];

  SubProduct get selectedSubProduct => _selectedSubProduct;
  Dimension get dimension => _dimension;
  List<Dimension> get dimensions => [..._dimensions];

  String get errorCode => _errorCode;

  String get errorMessage => _errorMessage;

  SubProductModelStatus get status => _status;

  List<SubProduct> get products => [..._subProducts];

  List<SubProduct> get editingSubProducts => [..._editingSubProducts];

  List<SubProduct> get editedSubProducts => [..._editedSubProducts];

  List<String> get subProductNames =>
      _subProducts.map((e) => e.subProductName).toList();

  SubProductModel.instance() {
    ;
  }

  SubProduct findById(String subProductId) {
    return _subProducts
        .firstWhere((subProd) => subProd.subProductId == subProductId);
  }

  void setStatus(SubProductModelStatus status) {
    _status = status;
    notifyListeners();
  }

  void addSubProduct(SubProduct subProduct) {
    setStatus(SubProductModelStatus.Loading);

    _subProducts.add(subProduct);

    setStatus(SubProductModelStatus.Ended);
  }

  void removeSubProduct({String subProductId}) {
    setStatus(SubProductModelStatus.Loading);

    _subProducts.removeWhere((subPrd) => subPrd.subProductId == subProductId);

    setStatus(SubProductModelStatus.Ended);
  }

  void addSubProductFromJson(Map<String, dynamic> data) {
    setStatus(SubProductModelStatus.Loading);
    _subProducts.add(SubProduct.fromJson(data));

    setStatus(SubProductModelStatus.Ended);
  }

  void clearSelectedSubProduct() {
    _selectedSubProduct = SubProduct(
        dimension: [], ingredients: [], price: 0, subProductName: '');
  }

  void addEditingListItem(SubProduct subProd) {
    setStatus(SubProductModelStatus.Loading);
    _editingSubProducts.insert(0, subProd);

    setStatus(SubProductModelStatus.Ended);
  }

  void addEditedListItem(SubProduct subProd) {
    setStatus(SubProductModelStatus.Loading);
    _editedSubProducts.insert(0, subProd);
    setStatus(SubProductModelStatus.Ended);
  }

  void createSelectedSubProduct(String subProductId) async {
    try {
      var element = await findById(subProductId).toJson();
      _selectedSubProduct = SubProduct.fromJson(element);
      // ignore: avoid_catching_errors
    } on StateError {
      clearSelectedSubProduct();
    }
  }

  void createSelectedSubProducts(List<String> subProductId) async {
    setStatus(SubProductModelStatus.Loading);

    _selectedSubProducts = await _subProducts
        .where((element) => subProductId.contains(element.subProductId))
        .toList();

    setStatus(SubProductModelStatus.Ended);
  }

  void addIngredient(String subProductId, String ingredientId) {
    setStatus(SubProductModelStatus.Loading);

    var subProduct = findById(subProductId);
    subProduct.ingredients.add(ingredientId);

    setStatus(SubProductModelStatus.Ended);
  }

  void removeIngredient(String subProductId, String ingredient) {
    setStatus(SubProductModelStatus.Loading);

    var subProduct = findById(subProductId);
    subProduct.ingredients.removeWhere((ingr) => ingr == ingredient);

    setStatus(SubProductModelStatus.Ended);
  }

  void addDimension(Dimension dimension) {
    setStatus(SubProductModelStatus.Loading);
    selectedSubProduct.dimension.insert(0, dimension);

    setStatus(SubProductModelStatus.Ended);
  }

  void removeDimension(String subProductId, Dimension dimension) {
    setStatus(SubProductModelStatus.Loading);
    selectedSubProduct.dimension.removeWhere((dms) => dms == dimension);
    setStatus(SubProductModelStatus.Ended);
  }

  // ignore: avoid_positional_boolean_parameters
  void setVisible(bool visibility) {
    setStatus(SubProductModelStatus.Loading);
    isVisible = visibility;
    setStatus(SubProductModelStatus.Ended);
  }
}
