import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/category/category_controller.dart';
import '../../../controllers/product/product_controller.dart';
import '../../../core/util/size_config.dart';
import '../../../models/category/category_model.dart';
import '../../categories_screen/add_category_page.dart';
import '../_components/category_item/category_item.dart';

class CategoriesGrid extends StatefulWidget {
  final CategoryItem categoryItem;
  final String type;

  const CategoriesGrid({this.categoryItem, this.type});

  @override
  _CategoriesGridState createState() => _CategoriesGridState();
}

class _CategoriesGridState extends State<CategoriesGrid> {
  int selectedIndex;
  final _categoryController = CategoryController();
  final _productController = ProductController();

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryModel>(builder: (ctx, cat, child) {
      return cat.status == CategoryModelStatus.Ended
          ? GridView.builder(
              itemCount: cat.categories.length,
              scrollDirection: Axis.horizontal,
              primary: true,
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.heightMultiplier * 1,
                  horizontal: SizeConfig.widthMultiplier * 1),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: SizeConfig.heightMultiplier * 100,
                childAspectRatio: 1,
                mainAxisSpacing: SizeConfig.widthMultiplier * 2,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: widget.type == 'edit'
                      ? () async {
                          _productController.getProductsGrid(
                              context, cat.categories[index].categoryId,
                              type: 'edit');
                          return Navigator.pushNamed(context,
                              await '${AddCategoryPage.routeName}/${cat.categories[index].categoryId}');
                        }
                      : () {
                          _productController.getProductsGrid(
                              context, cat.categories[index].categoryId);
                          _categoryController.setSelectedCategory(
                              context, cat.categories[index].categoryId);
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                  child: CategoryItem(
                    category: cat.categories[index],
                    isSelected: index == selectedIndex,
                  ),
                );
              })
          : cat.status == CategoryModelStatus.Loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container();
    });
  }
}
