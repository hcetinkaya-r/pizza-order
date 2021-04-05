import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/service/services.dart';
import '../../models/category/category_model.dart';
import '../../models/product/product_model.dart';
import '../../models/sub_product/sub_product_model.dart';

class ProductController {
  ProductController();

  final ApiServices _services = ApiServices();

  Future<bool> init(BuildContext context) async {
    var productModel = Provider.of<ProductModel>(context, listen: false);
    var categoryModel = Provider.of<CategoryModel>(context, listen: false);
    if (productModel.products.isEmpty) {
      var data = await _services.getResponse('products');
      List<dynamic> productsJson = data;
      for (var product in productsJson) {
        await productModel.addProductFromJson(product);
      }
    }
    getProductsGrid(context, categoryModel.categories[0].categoryId);

    return true;
  }

  List<SubProduct> getSubProducts(BuildContext context, String productId) {
    var subProductModel = Provider.of<SubProductModel>(context, listen: false);

    var subProd = subProductModel.findById(productId);
    var subProds = subProductModel.subProducts;

    var subProdsList = subProds
        .where(
            (subProds) => subProd.subProductId.contains(subProds.subProductId))
        .toList();
    return subProdsList;
  }

  List<Product> products(BuildContext context) {
    var productModel = Provider.of<ProductModel>(context, listen: false);
    return productModel.products;
  }

  void getProductsGrid(BuildContext context, String categoryId,
      {String type}) async {
    var productModel = Provider.of<ProductModel>(context, listen: false);
    var subProductModel = Provider.of<SubProductModel>(context, listen: false);

    await productModel.createSelectedProducts(categoryId, type: type);

    if (type == null) {
      if (subProductModel.isVisible) {
        subProductModel.setVisible(false);
      }
      productModel.setVisible(true);
    }
  }

  void setSelectedProduct(BuildContext context, String productId) async {
    var productModel = Provider.of<ProductModel>(context, listen: false);

    await productModel.setSelectedProduct(productId);
  }

  String getSelectedProductName(BuildContext context) {
    var productModel = Provider.of<ProductModel>(context, listen: false);
    return productModel.selectedProduct?.productName ?? '';
  }

  void addProduct({
    BuildContext context,
    String productId,
    String productCategory,
    List<String> subProductIds,
    String productName,
    String productImgUrl,
  }) {
    var productModel = Provider.of<ProductModel>(context, listen: false);
    try {
      var product = Product(
        productId: productId,
        productCategory: productCategory,
        subProductIds: subProductIds,
        productName: productName,
        productImgUrl: productImgUrl,
      );
      productModel.addProduct(product);
    } catch (e) {
      ;
    }
  }

  void removeProduct({BuildContext context, String productId}) {
    var productModel = Provider.of<ProductModel>(context, listen: false);

    productModel.removeProduct(productId);
  }
}
