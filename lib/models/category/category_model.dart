import 'package:flutter/material.dart';

enum CategoryModelStatus {
  Ended,
  Loading,
  Error,
}

class Category {
  String categoryId;
  String categoryName;
  String categoryImgUrl;
  List<String> productIds;

  Category({
    @required this.categoryId,
    @required this.categoryName,
    @required this.categoryImgUrl,
    this.productIds,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json['categoryId'] ?? 0,
        categoryName: json['categoryName'] ?? 'null',
        categoryImgUrl: json['categoryImgUrl'] ?? 'assets/images/null.png',
        productIds: json['productIds'] == null
            ? []
            : List<String>.from(json['productIds'].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        'categoryId': categoryId,
        'categoryName': categoryName,
        'categoryImgUrl': categoryImgUrl,
        'productIds': List<dynamic>.from(productIds.map((e) => e)),
      };

      @override
      String toString() {
      return toJson().toString();
       }
}

class CategoryModel extends ChangeNotifier {
  final List<Category> _categories = [];
  Category _selectedCategory;

  List<Category> get categories => [..._categories];

  Category get selectedCategory => _selectedCategory;

  CategoryModelStatus _status;
  String _errorCode;
  String _errorMessage;

  String get errorCode => _errorCode;

  String get errorMessage => _errorMessage;

  CategoryModelStatus get status => _status;

  List<String> get categoryNames =>
      _categories.map((e) => e.categoryName).toList();

  CategoryModel.instance() {
    ;
  }

  void setStatus(CategoryModelStatus status) {
    _status = status;
    notifyListeners();
  }

  Category findById(String categoryId) {
    return _categories.firstWhere((ctg) => ctg.categoryId == categoryId);
  }

  void addCategory(Category category) {
    setStatus(CategoryModelStatus.Loading);

    _categories.add(category);

    setStatus(CategoryModelStatus.Ended);
  }

  void addCategoryFromJson(Map<String, dynamic> data) {
    setStatus(CategoryModelStatus.Loading);

    _categories.add(Category.fromJson(data));

    setStatus(CategoryModelStatus.Ended);
  }

  void removeCategory(String categoryId) {
    setStatus(CategoryModelStatus.Loading);

    _categories.removeWhere((ctg) => ctg.categoryId == categoryId);

    setStatus(CategoryModelStatus.Ended);
  }

  void createSelectedCategoryName(String cateId) async {
    setStatus(CategoryModelStatus.Loading);

    _selectedCategory = findById(cateId);

    setStatus(CategoryModelStatus.Ended);
  }
}
