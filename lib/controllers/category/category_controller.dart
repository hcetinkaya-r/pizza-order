import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/service/services.dart';
import '../../models/category/category_model.dart';
import '../../models/product/product_model.dart';

class CategoryController {
  CategoryController();

  final ApiServices _services = ApiServices();

  Future<bool> init(BuildContext context) async {
    var categoryModel = Provider.of<CategoryModel>(context, listen: false);
    if (categoryModel.categories.isEmpty) {
      var data = await _services.getResponse('categories');
      List<dynamic> categoriesJson = data;
      for (var category in categoriesJson) {
        await categoryModel.addCategoryFromJson(category);
      }
    }
    setSelectedCategory(context, categoryModel.categories[0].categoryId);
    return true;
  }

  List<Category> categories(BuildContext context) {
    var categoryModel = Provider.of<CategoryModel>(context, listen: false);
    return categoryModel.categories;
  }

  void setSelectedCategory(BuildContext context, String categoryId) async {
    var categoryModel = Provider.of<CategoryModel>(context, listen: false);

    await categoryModel.createSelectedCategoryName(categoryId);
  }

  Category getCategory(BuildContext context, String categoryId) {
    var categoryModel = Provider.of<CategoryModel>(context, listen: false);

    return categoryModel.findById(categoryId);
  }

  List<String> getCategoryNames(BuildContext context) {
    var categoryModel = Provider.of<CategoryModel>(context, listen: false);
    var productModel = Provider.of<ProductModel>(context, listen: false);

    var dropDownList = <String>[];

    for (var item in categoryModel.categories) {
      if (item.productIds.isEmpty) {
        dropDownList.add(item.categoryName);
      } else {
        var list = productModel.products
            .where((sp) => sp.productCategory == item.categoryId)
            .toList();
        for (var prodItem in list) {
          dropDownList.add(prodItem.productName);
        }
      }
    }
    return dropDownList;
  }

  String getSelectedCateName(BuildContext context) {
    var categoryModel = Provider.of<CategoryModel>(context, listen: false);
    return categoryModel.selectedCategory?.categoryName ?? '';
  }

  void addCategory(
      {BuildContext context,
      String categoryId,
      String categoryName,
      String categoryImgUrl,
      String productIds}) {
    var categoryModel = Provider.of<CategoryModel>(context, listen: false);
    var category = Category(
      categoryId: categoryId,
      categoryName: categoryName,
      categoryImgUrl: categoryImgUrl,
      productIds: productIds ?? [],
    );
    categoryModel.addCategory(category);
  }

  void removeCategory(BuildContext context, {String categoryId}) {
    var categoryModel = Provider.of<CategoryModel>(context, listen: false);

    categoryModel.removeCategory(categoryId);
  }
}
