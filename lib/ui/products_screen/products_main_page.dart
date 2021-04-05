import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/components/widgets/card_item.dart';
import '../../core/components/widgets/filter.dart';
import '../../core/util/size_config.dart';
import '../../main/widgets/background_image.dart';
import '../../main/widgets/main_nav_bar.dart';
import '../categories_screen/categories_page.dart';
import '../ingredients_screen/ingredients_page.dart';
import 'sub_products_page.dart';

class ProductsMainPage extends StatelessWidget {
  static const routeName = '/products-main';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          BackgroundImage(),
          Filter(),
          MainNavBar(),
          Positioned(
            left: SizeConfig.widthMultiplier * 25,
            child: Container(
              height: SizeConfig.heightMultiplier * 85,
              width: SizeConfig.widthMultiplier * 72,
              margin: EdgeInsets.only(top: SizeConfig.heightMultiplier * 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, CategoriesPage.routeName),
                    child: CardItem(
                      title: Text(
                        'CATEGORIES',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: SizeConfig.textMultiplier * 4),
                      ),
                      width: SizeConfig.widthMultiplier * 30,
                      height: SizeConfig.heightMultiplier * 13,
                      isTrue: false,
                      isMain: true,
                      button: Container(),
                    ),
                  ),
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, SubProductsPage.routeName),
                    child: CardItem(
                      title: Text(
                        'PRODUCTS',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: SizeConfig.textMultiplier * 4),
                      ),
                      width: SizeConfig.widthMultiplier * 30,
                      height: SizeConfig.heightMultiplier * 13,
                      isTrue: false,
                      isMain: true,
                      button: Container(),
                    ),
                  ),
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, IngredientsPage.routeName),
                    child: CardItem(
                      title: Text(
                        'INGREDIENTS',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: SizeConfig.textMultiplier * 4),
                      ),
                      width: SizeConfig.widthMultiplier * 30,
                      height: SizeConfig.heightMultiplier * 13,
                      isTrue: false,
                      isMain: true,
                      button: Container(),
                    ),
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
