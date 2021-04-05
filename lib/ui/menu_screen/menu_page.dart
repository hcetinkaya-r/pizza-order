import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/category/category_controller.dart';
import '../../controllers/ingredient/ingredient_controller.dart';
import '../../controllers/product/product_controller.dart';
import '../../controllers/sub_product/sub_product_controller.dart';
import '../../core/components/widgets/filter.dart';
import '../../core/util/size_config.dart';
import '../../main/widgets/background_image.dart';
import '../../main/widgets/main_nav_bar.dart';
import '../../models/product/product_model.dart';
import '../../models/sub_product/sub_product_model.dart';
import 'widgets/categories_grid.dart';
import 'widgets/order_bar.dart';
import 'widgets/products_grid.dart';
import 'widgets/sub_products_grid.dart';

class MenuPage extends StatefulWidget {
  static const routeName = '/menu';

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final categoryController = CategoryController();
  final productController = ProductController();
  final subProductController = SubProductController();
  final ingredientController = IngredientController();

  Future<bool> initAllData(
      BuildContext context,
      CategoryController categoryController,
      ProductController productController,
      SubProductController subProductController,
      IngredientController ingredientController) async {
    await categoryController.init(context);
    await productController.init(context);
    await subProductController.init(context);
    await ingredientController.init(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: initAllData(context, categoryController, productController,
            subProductController, ingredientController),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                BackgroundImage(),
                Filter(),
                MainNavBar(),
                Positioned(
                  left: SizeConfig.widthMultiplier * 22,
                  child: Container(
                    width: SizeConfig.widthMultiplier * 78,
                    height: SizeConfig.heightMultiplier * 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            height: SizeConfig.heightMultiplier * 20,
                            child: CategoriesGrid()),
                        Container(
                          height: SizeConfig.heightMultiplier * 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Consumer<ProductModel>(
                                  builder: (ctx, prod, child) => prod.isVisible
                                      ? ProductsGrid()
                                      : Container()),
                              Consumer<SubProductModel>(
                                  builder: (ctx, subProd, child) =>
                                      subProd.isVisible
                                          ? SubProductsGrid(
                                              isMenuPage: true,
                                              isProductPage: false,
                                            )
                                          : Container()),
                              OrderBar(),
                            ],
                          ),
                        ),
                        Column(
                          children: [],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Center(
                child: Image.asset('assets/logo/logo.png'),
              );
            }
          }
        },
      ),
    );
  }
}
