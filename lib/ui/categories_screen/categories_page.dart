import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/components/widgets/adding_item.dart';
import '../../core/components/widgets/filter.dart';
import '../../core/components/widgets/header/header.dart';
import '../../core/util/size_config.dart';
import '../../main/widgets/background_image.dart';
import '../../main/widgets/main_nav_bar.dart';
import '../../models/product/product_model.dart';
import '../menu_screen/widgets/categories_grid.dart';
import 'add_category_page.dart';

class CategoriesPage extends StatelessWidget {
  static const routeName = '/categories';

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
              height: SizeConfig.heightMultiplier * 95,
              width: SizeConfig.widthMultiplier * 76,
              margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.heightMultiplier * 2),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Header(
                      title: 'CATEGORIES',
                      type: 'search',
                      action: () {},
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AddingItem(
                          width: SizeConfig.widthMultiplier * 9.5,
                          height: SizeConfig.heightMultiplier * 17.5,
                          title: Container(
                            margin: EdgeInsets.only(top: 40),
                            child: Text(
                              'Add Category',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 2,
                              ),
                            ),
                          ),
                          function: () {
                            var productModel = Provider.of<ProductModel>(
                                context,
                                listen: false);

                            productModel.clearEditingProducts();
                            Navigator.pushNamed(
                                context, AddCategoryPage.routeName);
                          },
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.widthMultiplier * 1,
                              vertical: SizeConfig.heightMultiplier * 2),
                          height: SizeConfig.heightMultiplier * 24,
                          width: SizeConfig.widthMultiplier * 65,
                          alignment: Alignment.centerRight,
                          child: CategoriesGrid(type: 'edit'),
                        ),
                      ],
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
