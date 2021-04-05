import 'package:flutter/material.dart';

import '../../../../core/util/size_config.dart';
import '../../../../models/sub_product/sub_product_model.dart';

class SubProductItem extends StatelessWidget {
  final SubProduct subProduct;
  final bool isMenuPage;

  const SubProductItem({this.subProduct, this.isMenuPage = false});

  void chooseSubProduct() {}

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).canvasColor.withOpacity(.8),
      elevation: 6,
      shadowColor: Colors.grey.shade400,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          SizeConfig.widthMultiplier * 3,
        ),
      ),
      child: Container(
        child: Row(
          children: [
            SizedBox(
              width: SizeConfig.widthMultiplier * 1,
            ),
            Container(
              height: SizeConfig.heightMultiplier * 10,
              width: SizeConfig.widthMultiplier * 7,
              child: Image.asset(
                subProduct.subProductImgUrl ?? 'assets/images/null.png',
                fit: BoxFit.contain,
              ),
            ),
            Container(
              width: SizeConfig.widthMultiplier * 10.7,
              height: SizeConfig.heightMultiplier * 13,
              padding: EdgeInsets.only(left: SizeConfig.heightMultiplier * 2),
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${subProduct.subProductName}',
                    style: TextStyle(fontSize: SizeConfig.textMultiplier * 3.5),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1,
                  ),
                  Text('${subProduct.price} ₺',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).primaryColor,
                          fontSize: SizeConfig.textMultiplier * 2.8))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
