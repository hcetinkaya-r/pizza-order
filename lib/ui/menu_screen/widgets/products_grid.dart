import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/category/category_controller.dart';
import '../../../controllers/product/product_controller.dart';
import '../../../controllers/sub_product/sub_product_controller.dart';
import '../../../core/util/size_config.dart';
import '../../../models/product/product_model.dart';
import '../_components/product_item/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final Product product;

  const ProductsGrid({this.product});

  @override
  Widget build(BuildContext context) {
    var subProductController = SubProductController();
    var productController = ProductController();
    var cateController = CategoryController();
    return Container(
      child: Consumer<ProductModel>(builder: (ctx, prod, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: SizeConfig.heightMultiplier * 15,
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(left: SizeConfig.textMultiplier * 2),
                child: Text(
                  cateController.getSelectedCateName(context),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: SizeConfig.textMultiplier * 5,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 1,
                  vertical: SizeConfig.heightMultiplier * 2),
              height: SizeConfig.heightMultiplier * 65,
              width: SizeConfig.widthMultiplier * 53,
              alignment: Alignment.centerRight,
              child: prod.status == ProductModelStatus.Ended
                  ? GridView.builder(
                      itemCount: prod.selectedProducts.length,
                      scrollDirection: Axis.vertical,
                      primary: true,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: SizeConfig.heightMultiplier * 25,
                        childAspectRatio: 1,
                        crossAxisSpacing: SizeConfig.widthMultiplier * 1,
                        mainAxisSpacing: SizeConfig.heightMultiplier * 2,
                      ),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          subProductController.getSubProductsGrid(
                              context, prod.products[index].subProductIds);
                          productController.setSelectedProduct(
                              context, prod.products[index].productId);
                        },
                        child: ProductItem(
                          prod.selectedProducts[index],
                        ),
                      ),
                    )
                  : prod.status == ProductModelStatus.Loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(),
            ),
          ],
        );
      }),
    );
  }
}
