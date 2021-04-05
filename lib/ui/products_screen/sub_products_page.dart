import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/components/widgets/adding_item.dart';
import '../../core/components/widgets/filter.dart';
import '../../core/components/widgets/header/header.dart';
import '../../core/util/size_config.dart';
import '../../main/widgets/background_image.dart';
import '../../main/widgets/main_nav_bar.dart';
import '../../models/sub_product/sub_product_model.dart';
import '../menu_screen/widgets/sub_products_grid.dart';
import 'add_sub_product_page.dart';

class SubProductsPage extends StatelessWidget {
  static const routeName = '/subProducts';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          BackgroundImage(),
          Filter(),
          MainNavBar(),
          Positioned(
            left: SizeConfig.widthMultiplier * 24,
            child: Container(
              alignment: Alignment.topLeft,
              width: SizeConfig.widthMultiplier * 76,
              height: SizeConfig.heightMultiplier * 93,
              margin: EdgeInsets.only(top: SizeConfig.heightMultiplier * 3),
              child: Column(
                children: [
                  Container(
                    width: SizeConfig.widthMultiplier * 74,
                    height: SizeConfig.heightMultiplier * 10,
                    margin:
                        EdgeInsets.only(right: SizeConfig.widthMultiplier * 5),
                    child: Header(
                      title: 'PRODUCTS',
                      type: 'search',
                      action: () {},
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.heightMultiplier * 2),
                        child: AddingItem(
                          width: SizeConfig.widthMultiplier * 20,
                          height: SizeConfig.heightMultiplier * 21,
                          title: Text(
                            'Add Product',
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 2),
                          ),
                          function: () {
                            var subProductModel = Provider.of<SubProductModel>(
                                context,
                                listen: false);

                            subProductModel.clearSelectedSubProduct();
                            Navigator.pushNamed(
                                context, AddSubProductPage.routeName);
                          },
                        ),
                      ),
                      Container(
                          child: SubProductsGrid(
                              isMenuPage: false, isProductPage: true)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
