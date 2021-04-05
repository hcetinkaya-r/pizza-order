import 'package:flutter/material.dart';

enum IngredientModelStatus {
  Ended,
  Loading,
  Error,
}

class Ingredient {
  String ingredientId;
  String ingredientName;
  double price;
  String ingredientImgUrl;
  bool selected;

  Ingredient({
    this.ingredientId,
    this.ingredientName,
    this.price,
    this.ingredientImgUrl,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        ingredientId: json['ingredientId'] ?? 0,
        ingredientName: json['ingredientName'] ?? 'null',
        price: double.parse(json['price']) ?? 0,
        ingredientImgUrl: json['ingredientImgUrl'] ?? 'assets/images/null.png',
      );

  Map<String, dynamic> toJson() => {
        'ingredientId': ingredientId,
        'ingredientName': ingredientName,
        'price': price.toString(),
        'ingredientImgUrl': ingredientImgUrl
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class IngredientModel extends ChangeNotifier {
  final List<Ingredient> _ingredients = [];
  Ingredient _selectedIngredient;
  IngredientModelStatus _status;
  String _errorCode;
  String _errorMessage;

  List<Ingredient> get ingredients => [..._ingredients];

  Ingredient get selectedIngredient => _selectedIngredient;

  String get errorCode => _errorCode;

  String get errorMessage => _errorMessage;

  IngredientModelStatus get status => _status;

  List<String> get ingredientNames =>
      _ingredients.map((e) => e.ingredientName).toList();

  IngredientModel.instance() {
    ;
  }

  Ingredient findById(String id) {
    return _ingredients.firstWhere((ing) => ing.ingredientId == id);
  }

  void setStatus(IngredientModelStatus status) {
    _status = status;
    notifyListeners();
  }

  void addIngredient(Ingredient ingredient) {
    setStatus(IngredientModelStatus.Loading);

    _ingredients.add(ingredient);

    setStatus(IngredientModelStatus.Ended);
  }

  void addIngredientFromJson(Map<String, dynamic> data) {
    setStatus(IngredientModelStatus.Loading);

    _ingredients.add(Ingredient.fromJson(data));
    setStatus(IngredientModelStatus.Ended);
  }

  void editIngredient(Ingredient ingredient) {
    var _ingredient = findById(ingredient.ingredientId);

    _ingredient.ingredientImgUrl =
        ingredient.ingredientImgUrl ?? _ingredient.ingredientImgUrl;
    _ingredient.ingredientName =
        ingredient.ingredientName ?? _ingredient.ingredientName;
    _ingredient.price = ingredient.price ?? _ingredient.price;
  }

  void removeIngredient(String ingredientId) {
    setStatus(IngredientModelStatus.Loading);
    _ingredients.removeWhere((ing) => ing.ingredientId == ingredientId);
    setStatus(IngredientModelStatus.Ended);
  }
}
