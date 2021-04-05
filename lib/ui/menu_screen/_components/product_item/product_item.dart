import 'package:flutter/material.dart';

import '../../../../core/util/size_config.dart';
import '../../../../models/product/product_model.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).canvasColor.withOpacity(.8),
      elevation: 6,
      shadowColor: Colors.grey.shade400,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(SizeConfig.imagesSizeMultiplier * 2)),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Image(
                    image: AssetImage(
                      product.productImgUrl,
                    ),
                    height: SizeConfig.imagesSizeMultiplier * 6,
                    width: SizeConfig.imagesSizeMultiplier * 6,
                  ) ??
                  '',
            ),
            Container(
              width: SizeConfig.widthMultiplier * 6,
              child: Text(
                product.productName,
                style: TextStyle(
                  fontSize: SizeConfig.textMultiplier * 2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
