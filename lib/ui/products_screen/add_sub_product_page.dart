import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/category/category_controller.dart';
import '../../controllers/ingredient/ingredient_controller.dart';
import '../../controllers/sub_product/sub_product_controller.dart';
import '../../core/components/buttons/elevated_button.dart';
import '../../core/components/widgets/adding_item.dart';
import '../../core/components/widgets/card_item.dart';
import '../../core/components/widgets/filter.dart';
import '../../core/components/widgets/header/header.dart';
import '../../core/components/widgets/pop_up_widget/pop_up_widget.dart';
import '../../core/components/widgets/text_field_item.dart';
import '../../core/util/size_config.dart';
import '../../main/widgets/background_image.dart';
import '../../main/widgets/main_nav_bar.dart';
import '../../models/category/category_model.dart';
import '../../models/dimension/dimension_model.dart';
import '../../models/ingredient/ingredient_model.dart';
import '../../models/sub_product/sub_product_model.dart';
import '../order_screens/widgets/ingredient_card.dart';
import 'sub_products_page.dart';

class AddSubProductPage extends StatefulWidget {
  static const routeName = '/add-subProduct';
  final String subProductId;

  const AddSubProductPage({this.subProductId});

  @override
  _AddSubProductPageState createState() => _AddSubProductPageState();
}

class _AddSubProductPageState extends State<AddSubProductPage> {
  final ingController = IngredientController();
  final categoryController = CategoryController();
  final controller = SubProductController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          BackgroundImage(),
          Filter(),
          MainNavBar(),
          Positioned(
            left: SizeConfig.widthMultiplier * 23,
            child: FutureBuilder(
              future: controller.setSelectedSubProduct(
                  context, widget.subProductId),
              builder: (ctx, snapshot) {
                return snapshot.hasData
                    ? Container(
                        height: SizeConfig.heightMultiplier * 96,
                        width: SizeConfig.widthMultiplier * 76,
                        margin: EdgeInsets.only(
                            top: SizeConfig.heightMultiplier * 2),
                        child: Consumer<SubProductModel>(
                          builder: (ctx, subProd, child) => Container(
                            child: Column(
                              children: <Widget>[
                                Header(
                                    title: widget.subProductId != null
                                        ? 'EDIT PRODUCT'
                                        : 'ADD PRODUCT',
                                    type: widget.subProductId != null
                                        ? 'edit'
                                        : '',
                                    action: () {
                                      return PopUpDialog(
                                          content: Text(
                                            'Are you sure you want to '
                                            'remove the product?',
                                          ),
                                          leftButtonText: 'Cancel',
                                          title: 'Are you sure?',
                                          rightButtonText: 'Delete',
                                          rightAction: () {
                                            subProd.removeSubProduct(
                                                subProductId:
                                                    widget.subProductId);
                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                                    SubProductsPage.routeName,
                                                    (route) => false);
                                          }).show(context);
                                    }),
                                Container(
                                  width: SizeConfig.widthMultiplier * 74,
                                  height: SizeConfig.heightMultiplier * 74,
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          SubProductSectionWidget(
                                            subProduct: subProd,
                                          ),
                                          SizeSectionWidget(
                                              subProdMod: subProd),
                                        ],
                                      ),
                                      IngredientAndCategorySection(
                                          ingredients: ingController
                                              .ingredients(context)),
                                    ],
                                  ),
                                ),
                                Buttons(subProdMod: subProd),
                              ],
                            ),
                          ),
                        ),
                      )
                    : snapshot.hasError
                        ? Center(
                            child: Text('${snapshot.error}'),
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  const Buttons({this.subProdMod});

  final SubProductModel subProdMod;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.widthMultiplier * 74,
      height: SizeConfig.heightMultiplier * 12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          AppElevatedButton(
            fontSize: SizeConfig.textMultiplier * 5,
            buttonColor: Theme.of(context).accentColor,
            width: SizeConfig.widthMultiplier * 20,
            height: SizeConfig.heightMultiplier * 10,
            inColor: Theme.of(context).canvasColor,
            radius: SizeConfig.imagesSizeMultiplier * 2,
            function: () {
              subProdMod.addDimension(
                Dimension(
                  size: '',
                  price: 0,
                ),
              );
            },
            child: Text('Add'),
          ),
          Container(
            height: SizeConfig.heightMultiplier * 25,
            child: AppElevatedButton(
              fontSize: SizeConfig.textMultiplier * 5,
              buttonColor: Theme.of(context).primaryColor,
              width: SizeConfig.widthMultiplier * 30,
              height: SizeConfig.heightMultiplier * 12,
              inColor: Theme.of(context).canvasColor,
              radius: SizeConfig.imagesSizeMultiplier * 2,
              function: () {},
              child: Text('Save'),
            ),
          )
        ],
      ),
    );
  }
}

class SubProductSectionWidget extends StatelessWidget {
  const SubProductSectionWidget({this.subProduct});

  final SubProductModel subProduct;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.heightMultiplier * 43,
      width: SizeConfig.widthMultiplier * 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Text(
                  'Product Picture',
                  style: TextStyle(fontSize: SizeConfig.textMultiplier * 3),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 3,
                ),
                AddingItem(
                  width: SizeConfig.widthMultiplier * 10,
                  height: SizeConfig.heightMultiplier * 18,
                  title: Text(''),
                  imgUrl: subProduct.selectedSubProduct == null
                      ? null
                      : subProduct.selectedSubProduct.subProductImgUrl,
                  function: () {},
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Product Name',
                  style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 3,
                  ),
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 3),
                TextFieldItem(
                  initialValue: subProduct.selectedSubProduct == null
                      ? TextEditingController.fromValue(
                          TextEditingValue(text: ''))
                      : TextEditingController.fromValue(TextEditingValue(
                          text: subProduct.selectedSubProduct.subProductName)),
                  width: SizeConfig.widthMultiplier * 20,
                  height: SizeConfig.heightMultiplier * 11.6,
                  radius: SizeConfig.imagesSizeMultiplier * 2,
                  vPadding: SizeConfig.heightMultiplier * 4,
                  hPadding: SizeConfig.heightMultiplier * 2,
                  fontSize: SizeConfig.textMultiplier * 4,
                  bottomMargin: SizeConfig.heightMultiplier * 3,
                ),
                Text(
                  'Price',
                  style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 3,
                  ),
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 3),
                TextFieldItem(
                  initialValue: subProduct.selectedSubProduct == null
                      ? TextEditingController.fromValue(
                          TextEditingValue(text: ''))
                      : TextEditingController.fromValue(TextEditingValue(
                          text:
                              subProduct.selectedSubProduct.price.toString())),
                  width: SizeConfig.widthMultiplier * 20,
                  height: SizeConfig.heightMultiplier * 11.6,
                  radius: SizeConfig.imagesSizeMultiplier * 2,
                  vPadding: SizeConfig.heightMultiplier * 4,
                  hPadding: SizeConfig.heightMultiplier * 2,
                  fontSize: SizeConfig.textMultiplier * 4,
                  bottomMargin: SizeConfig.heightMultiplier * 3,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SizeSectionWidget extends StatelessWidget {
  final SubProductModel subProdMod;

  const SizeSectionWidget({this.subProdMod});

  @override
  Widget build(BuildContext context) {
    var _sizeController = List<TextEditingController>.generate(
        subProdMod.selectedSubProduct.dimension.length,
        (index) => TextEditingController.fromValue(TextEditingValue(
            text: subProdMod.selectedSubProduct.dimension[index].size
                .toString())));

    var _priceController = List<TextEditingController>.generate(
        subProdMod.selectedSubProduct.dimension.length,
        (index) => TextEditingController.fromValue(TextEditingValue(
            text: subProdMod.selectedSubProduct.dimension[index].price
                .toString())));

    return Container(
      width: SizeConfig.widthMultiplier * 45,
      height: SizeConfig.heightMultiplier * 30,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Add Size',
              style: TextStyle(fontSize: SizeConfig.textMultiplier * 4),
            ),
          ),
          Container(
            width: SizeConfig.widthMultiplier * 45,
            height: SizeConfig.heightMultiplier * 25,
            child: ListView.builder(
              itemCount: subProdMod.selectedSubProduct?.dimension?.length ?? 0,
              itemBuilder: (ctx, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Size Name',
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 3),
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 1,
                        ),
                        TextFieldItem(
                          initialValue:
                              subProdMod.selectedSubProduct.dimension == null
                                  ? TextEditingController.fromValue(
                                      TextEditingValue(text: ''))
                                  : _sizeController[index],
                          width: SizeConfig.widthMultiplier * 20,
                          height: SizeConfig.heightMultiplier * 10,
                          radius: SizeConfig.imagesSizeMultiplier * 2,
                          vPadding: SizeConfig.heightMultiplier * 4,
                          hPadding: SizeConfig.heightMultiplier * 2,
                          fontSize: SizeConfig.textMultiplier * 4,
                          bottomMargin: SizeConfig.heightMultiplier * 3,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(),
                        Text(
                          'Size Price',
                          style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 3,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 1,
                        ),
                        TextFieldItem(
                          initialValue:
                              subProdMod.selectedSubProduct.dimension == null
                                  ? TextEditingController.fromValue(
                                      TextEditingValue(text: ''))
                                  : _priceController[index],
                          width: SizeConfig.widthMultiplier * 20,
                          height: SizeConfig.heightMultiplier * 10,
                          radius: SizeConfig.imagesSizeMultiplier * 2,
                          vPadding: SizeConfig.heightMultiplier * 4,
                          hPadding: SizeConfig.heightMultiplier * 2,
                          fontSize: SizeConfig.textMultiplier * 4,
                          bottomMargin: SizeConfig.heightMultiplier * 3,
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class IngredientAndCategorySection extends StatefulWidget {
  const IngredientAndCategorySection({this.ingredients, this.categories});

  final List<Ingredient> ingredients;
  final List<Category> categories;

  @override
  _IngredientAndCategorySectionState createState() =>
      _IngredientAndCategorySectionState();
}

class _IngredientAndCategorySectionState
    extends State<IngredientAndCategorySection> {
  String _currentCatSelectedValue;
  String _currentIngSelectedValue;

  @override
  Widget build(BuildContext context) {
    var categoryController = CategoryController();
    var ingredientController = IngredientController();
    return Container(
      width: SizeConfig.widthMultiplier * 22,
      height: SizeConfig.heightMultiplier * 64,
      child: Column(
        children: <Widget>[
          CardItem(
            title: Text(''),
            width: SizeConfig.widthMultiplier * 22,
            height: SizeConfig.heightMultiplier * 10,
            isTrue: false,
            isMain: false,
            button: Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 1,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    hint: Text(
                      'Choose Category',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: SizeConfig.textMultiplier * 2),
                    ),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Theme.of(context).accentColor,
                      size: SizeConfig.imagesSizeMultiplier * 2,
                    ),
                    value: _currentCatSelectedValue,
                    items: categoryController
                        .getCategoryNames(context)
                        .map(
                          (val) => DropdownMenuItem(
                            value: val,
                            child: Text(val),
                          ),
                        )
                        .toList(),
                    onChanged: (value) =>
                        setState(() => _currentCatSelectedValue = value),
                  ),
                ),
              ),
            ),
          ),
          CardItem(
            title: Text(''),
            width: SizeConfig.widthMultiplier * 22,
            height: SizeConfig.heightMultiplier * 10,
            isTrue: false,
            isMain: false,
            button: Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 1),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    hint: Text(
                      'Choose Ingredient',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: SizeConfig.textMultiplier * 2),
                    ),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Theme.of(context).accentColor,
                      size: SizeConfig.imagesSizeMultiplier * 2.5,
                    ),
                    value: _currentIngSelectedValue,
                    /*??
                        ingredientController.getIngredientNames(context)[0],*/
                    items: ingredientController
                        .getIngredientNames(context)
                        .map(
                          (val) => DropdownMenuItem(
                            value: val,
                            child: Text(val),
                          ),
                        )
                        .toList(),
                    onChanged: (value) =>
                        setState(() => _currentIngSelectedValue = value),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.ingredients.length,
              itemBuilder: (ctx, index) => IngredientCard(
                ingredient: widget.ingredients[index],
                isInclude: true,
                button: Container(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
