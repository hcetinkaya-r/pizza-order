import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../controllers/ingredient/ingredient_controller.dart';
import '../../core/components/buttons/elevated_button.dart';
import '../../core/components/widgets/filter.dart';
import '../../core/util/size_config.dart';
import '../../main/widgets/background_image.dart';
import '../../main/widgets/main_nav_bar.dart';
import '../../models/ingredient/ingredient_model.dart';
import '../../models/sub_product/sub_product_model.dart';
import 'widgets/choose_size_button.dart';
import 'widgets/ingredient_card.dart';
import 'widgets/order_card.dart';

class EditOrderPage extends StatefulWidget {
  static const routeName = '/edit-order';
  final SubProduct subProduct;

  const EditOrderPage({Key key, this.subProduct}) : super(key: key);

  @override
  _EditOrderPageState createState() => _EditOrderPageState();
}

class OrderCardItem {
  double price;
  int piece;
  List<Ingredient> addedIngredients;
  List<Ingredient> removedIngredients;
  OrderCardItem(
      {this.price = 0,
      this.piece = 1,
      this.addedIngredients,
      this.removedIngredients});
}

class _EditOrderPageState extends State<EditOrderPage> {
  int selectedIndex = 0;
  List<Ingredient> ingredients = [];
  IngredientController controller = IngredientController();
  OrderCardItem orderItem;
  @override
  void initState() {
    super.initState();
    ingredients = controller.ingredients(context);
    for (var product in widget.subProduct.ingredients) {
      ingredients.removeWhere((element) => element.ingredientId == product);
      ingredients.insert(0, controller.getIngredient(context, product));
    }
    orderItem = OrderCardItem(
        price: widget.subProduct.dimension.isNotEmpty
            ? widget.subProduct.dimension[selectedIndex].price
            : 0.0,
        addedIngredients: [],
        removedIngredients: [],
        piece: 1);
  }

  void addIngredient(Ingredient ingredient) {
    setState(() {
      orderItem.addedIngredients.add(ingredient);
      orderItem.price += ingredient.price;
    });
  }

  void removeIngredient(Ingredient ingredient) {
    setState(() {
      orderItem.removedIngredients.add(ingredient);
    });
  }

  void restore(Ingredient ingredient) {
    setState(() {
      if (orderItem.addedIngredients.contains(ingredient)) {
        orderItem.addedIngredients
            .removeWhere((ing) => ing.ingredientId == ingredient.ingredientId);
        orderItem.price -= ingredient.price;
      } else {
        orderItem.removedIngredients
            .removeWhere((ing) => ing.ingredientId == ingredient.ingredientId);
      }
    });
  }

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
              width: SizeConfig.widthMultiplier * 73,
              height: SizeConfig.heightMultiplier * 100,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: SizeConfig.widthMultiplier * 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                top: SizeConfig.heightMultiplier * 9,
                                left: SizeConfig.widthMultiplier * 7),
                            child: Column(
                              children: [
                                Container(
                                  width: SizeConfig.widthMultiplier * 12,
                                  height: SizeConfig.heightMultiplier * 12,
                                  child: Image.asset(
                                    widget.subProduct.subProductImgUrl,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Text(
                                  widget.subProduct.subProductName,
                                  style: TextStyle(
                                      fontSize: SizeConfig.textMultiplier * 4,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade800),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: SizeConfig.heightMultiplier * 25,
                            width: SizeConfig.widthMultiplier * 38.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical:
                                          SizeConfig.heightMultiplier * 2),
                                  child: Text(
                                    'Choose Size',
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.textMultiplier * 4.05,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                      itemCount:
                                          widget.subProduct.dimension.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () => setState(() {
                                            selectedIndex = index;
                                            orderItem.price = widget.subProduct
                                                .dimension[selectedIndex].price;
                                            for (var ingredient
                                                in orderItem.addedIngredients) {
                                              orderItem.price +=
                                                  ingredient.price;
                                            }
                                          }),
                                          child: ChooseSizeButton(
                                              sizeName: widget.subProduct
                                                  .dimension[index].size,
                                              price: widget.subProduct
                                                  .dimension[index].price,
                                              isSelected:
                                                  index == selectedIndex),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.heightMultiplier * 5),
                      height: SizeConfig.heightMultiplier * 70,
                      width: SizeConfig.widthMultiplier * 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              child: OrderCard(
                            orderItem: orderItem,
                            subProduct: widget.subProduct,
                          )),
                          Container(
                            height: SizeConfig.heightMultiplier * 70,
                            width: SizeConfig.widthMultiplier * 40,
                            child: ListView.builder(
                              itemCount: ingredients.length,
                              itemBuilder: (ctx, index) => IngredientCard(
                                ingredient: ingredients[index],
                                isInclude: index - 1 >=
                                    widget.subProduct.ingredients.length,
                                button: index <=
                                        widget.subProduct.ingredients.length
                                    ? !orderItem.removedIngredients
                                            .contains(ingredients[index])
                                        ? InkWell(
                                            onTap: () => removeIngredient(
                                                ingredients[index]),
                                            child: Icon(
                                              Icons.cancel_outlined,
                                              size:
                                                  SizeConfig.textMultiplier * 3,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ))
                                        : InkWell(
                                            onTap: () =>
                                                restore(ingredients[index]),
                                            child: Icon(
                                              Icons.compare_arrows,
                                              size:
                                                  SizeConfig.textMultiplier * 3,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ))
                                    : !orderItem.addedIngredients
                                            .contains(ingredients[index])
                                        ? AppElevatedButton(
                                            elevation: 0,
                                            fontSize:
                                                SizeConfig.textMultiplier * 1.3,
                                            buttonColor:
                                                Theme.of(context).accentColor,
                                            textColor: Colors.black,
                                            width: SizeConfig.widthMultiplier *
                                                6.6,
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    5.1,
                                            radius: SizeConfig
                                                    .imagesSizeMultiplier *
                                                1.6,
                                            child: Text(
                                              'Add',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            function: () => addIngredient(
                                                ingredients[index]),
                                          )
                                        : InkWell(
                                            onTap: () =>
                                                restore(ingredients[index]),
                                            child: Icon(
                                              Icons.compare_arrows,
                                              size:
                                                  SizeConfig.textMultiplier * 3,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
