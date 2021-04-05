import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/service/services.dart';
import '../../models/dimension/dimension_model.dart';
import '../../models/product/product_model.dart';
import '../../models/sub_product/sub_product_model.dart';

class SubProductController {
  SubProductController();

  final ApiServices _services = ApiServices();

  Future<bool> init(BuildContext context) async {
    var subProductModel = Provider.of<SubProductModel>(context, listen: false);
    subProductModel.setStatus(SubProductModelStatus.Loading);
    if (subProductModel.subProducts.isEmpty) {
      var data = await _services.getResponse('subproducts');
      List<dynamic> subProductsJson = data;
      for (var subProduct in subProductsJson) {
        await subProductModel.addSubProductFromJson(subProduct);
      }
    }
    subProductModel.setStatus(SubProductModelStatus.Ended);
    return true;
  }

  List<SubProduct> subProducts(BuildContext context) {
    var subProductModel = Provider.of<SubProductModel>(context, listen: false);
    return subProductModel.subProducts;
  }

  void getSubProductsGrid(BuildContext context, List<String> _subProductId,
      {String type}) async {
    var productModel = Provider.of<ProductModel>(context, listen: false);
    var subProductModel = Provider.of<SubProductModel>(context, listen: false);

    await subProductModel.createSelectedSubProducts(_subProductId);

    if (productModel.isVisible) {
      productModel.setVisible(false);
    }
    subProductModel.setVisible(true);
  }

  void addSubProduct({
    BuildContext context,
    String productId,
    String subProductId,
    String subProductImgUrl,
    String subProductName,
    List<String> ingredients,
    double price,
    List<Dimension> dimensions,
  }) {
    var subProductModel = Provider.of<SubProductModel>(context, listen: false);
    try {
      var subProduct = SubProduct(
        subProductId: subProductId,
        subProductImgUrl: subProductImgUrl,
        subProductName: subProductName,
        ingredients: ingredients,
        price: price,
        dimension: dimensions,
      );
      subProductModel.addSubProduct(subProduct);
    } catch (e) {
      ;
    }
  }

  SubProduct getSubProduct(BuildContext context, String subProductId) {
    var subProductModel = Provider.of<SubProductModel>(context, listen: false);
    subProductModel.createSelectedSubProduct(subProductId);
    return subProductModel.findById(subProductId);
  }

  Future<bool> setSelectedSubProduct(
      BuildContext context, String subProductId) async {
    var subProductModel = Provider.of<SubProductModel>(context, listen: false);

    await subProductModel.createSelectedSubProduct(subProductId);
    return true;
  }

  void removeSubProduct(BuildContext context, {String subProductId}) {
    var subProductModel = Provider.of<SubProductModel>(context, listen: false);

    subProductModel.removeSubProduct(subProductId: subProductId);
  }

  void addIngredient(
      BuildContext context, String subProductId, String ingredientId) {
    var subProductModel = Provider.of<SubProductModel>(context, listen: false);
    try {
      subProductModel.addIngredient(subProductId, ingredientId);
    } catch (e) {
      ;
    }
  }

  void removeIngredient(
      BuildContext context, String subProductId, String ingredient) {
    var subProductModel = Provider.of<SubProductModel>(context, listen: false);
    try {
      subProductModel.removeIngredient(subProductId, ingredient);
    } catch (e) {
      ;
    }
  }

  void addDimension(
      BuildContext context, String subProductId, String size, double price) {
    var subProductModel = Provider.of<SubProductModel>(context, listen: false);

    var dimension = Dimension(size: size, price: price);

    subProductModel.addDimension(dimension);
  }

  void removeDimension(
      BuildContext context, String subProductId, Dimension dimension) {
    var subProductModel = Provider.of<SubProductModel>(context, listen: false);

    subProductModel.removeDimension(subProductId, dimension);
  }

  void setVisibility(BuildContext context) {
    var productModel = Provider.of<ProductModel>(context, listen: false);
    var subProductModel = Provider.of<SubProductModel>(context, listen: false);
    productModel.setVisible(true);
    subProductModel.setVisible(false);
  }
}
