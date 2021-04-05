import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/product/product_controller.dart';
import '../../../controllers/sub_product/sub_product_controller.dart';
import '../../../core/components/buttons/elevated_button.dart';
import '../../../core/util/size_config.dart';
import '../../../models/sub_product/sub_product_model.dart';
import '../../order_screens/edit_order_page.dart';
import '../../products_screen/add_sub_product_page.dart';
import '../_components/sub_product_item/sub_product_item.dart';

class SubProductsGrid extends StatelessWidget {
  final bool isMenuPage;
  final bool isProductPage;
  final SubProduct subProduct;

  const SubProductsGrid({this.isMenuPage, this.isProductPage, this.subProduct});

  @override
  Widget build(BuildContext context) {
    final _controller = SubProductController();
    final _prodController = ProductController();
    return Consumer<SubProductModel>(builder: (ctx, subProd, child) {
      return Container(
        height: SizeConfig.heightMultiplier * 79,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isProductPage
                ? SizedBox(height: SizeConfig.heightMultiplier * 0.1)
                : Container(
                    width: SizeConfig.widthMultiplier * 53,
                    height: SizeConfig.heightMultiplier * 15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: SizeConfig.widthMultiplier * 1.2,
                          ),
                          child: Text(
                            _prodController.getSelectedProductName(context),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.textMultiplier * 5),
                          ),
                        ),
                        isMenuPage
                            ? AppElevatedButton(
                                fontSize: SizeConfig.textMultiplier * 1.5,
                                buttonColor: Theme.of(context).primaryColor,
                                width: SizeConfig.widthMultiplier * 10,
                                height: SizeConfig.heightMultiplier * 6,
                                inColor: Theme.of(context).canvasColor,
                                radius: SizeConfig.imagesSizeMultiplier * 1,
                                function: () =>
                                    _controller.setVisibility(context),
                                child: Text('Back'),
                              )
                            : Container(),
                      ],
                    ),
                  ),
            Container(
              height: isProductPage
                  ? SizeConfig.heightMultiplier * 25
                  : SizeConfig.heightMultiplier * 64,
              width: SizeConfig.widthMultiplier * 55,
              child: subProd.status == SubProductModelStatus.Ended
                  ? GridView.builder(
                      semanticChildCount: 2,
                      itemCount: isMenuPage
                          ? subProd.selectedSubProducts.length
                          : subProd.subProducts.length,
                      scrollDirection:
                          isProductPage ? Axis.horizontal : Axis.vertical,
                      primary: true,
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.widthMultiplier * 1,
                          horizontal: SizeConfig.heightMultiplier * 1.8),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: SizeConfig.widthMultiplier * 30,
                        mainAxisExtent: isProductPage
                            ? SizeConfig.widthMultiplier * 22
                            : SizeConfig.widthMultiplier * 10,
                        childAspectRatio: 1,
                        crossAxisSpacing: SizeConfig.heightMultiplier * 1.5,
                        mainAxisSpacing: SizeConfig.widthMultiplier * 2,
                      ),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          isMenuPage
                              ? Navigator.pushNamed(context,
                                  '${EditOrderPage.routeName}/${subProd.subProducts[index].subProductId}')
                              : Navigator.pushNamed(context,
                                  '${AddSubProductPage.routeName}/${subProd.subProducts[index].subProductId}');
                        },
                        child: SubProductItem(
                          subProduct: isMenuPage
                              ? subProd.selectedSubProducts[index]
                              : subProd.subProducts[index],
                          isMenuPage: isMenuPage,
                        ),
                      ),
                    )
                  : subProd.status == SubProductModelStatus.Loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(),
            ),
          ],
        ),
      );
    });
  }
}
