import 'package:flutter/material.dart';

import '../../controllers/ingredient/ingredient_controller.dart';
import '../../core/components/buttons/elevated_button.dart';
import '../../core/components/widgets/adding_item.dart';
import '../../core/components/widgets/filter.dart';
import '../../core/components/widgets/header/header.dart';
import '../../core/components/widgets/pop_up_widget/pop_up_widget.dart';
import '../../core/components/widgets/text_field_item.dart';
import '../../core/util/size_config.dart';
import '../../main/widgets/background_image.dart';
import '../../main/widgets/main_nav_bar.dart';
import '../../models/ingredient/ingredient_model.dart';
import 'ingredients_page.dart';

class AddIngredientPage extends StatefulWidget {
  static const routeName = '/add-ingredient';
  final Ingredient ingredient;

  AddIngredientPage({this.ingredient});

  @override
  _AddIngredientPageState createState() => _AddIngredientPageState();
}

class _AddIngredientPageState extends State<AddIngredientPage> {
  final ingController = IngredientController();
  TextEditingController nameController;
  TextEditingController price;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController.fromValue(
      TextEditingValue(text: widget.ingredient?.ingredientName ?? ''),
    );
    price = TextEditingController.fromValue(
      TextEditingValue(text: widget.ingredient?.price ?? ''),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = TextStyle(fontSize: SizeConfig.textMultiplier * 3.5);

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
              width: SizeConfig.widthMultiplier * 74,
              margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.heightMultiplier * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Header(
                      title: widget.ingredient != null
                          ? 'EDIT INGREDIENT'
                          : 'ADD INGREDIENT',
                      type: widget.ingredient != null ? 'edit' : '',
                      action: () {
                        return PopUpDialog(
                            // ignore: lines_longer_than_80_chars
                            content: Text(
                              'Are you sure you want to remove the '
                              'ingredient?',
                            ),
                            leftButtonText: 'Cancel',
                            title: 'Are you sure?',
                            rightButtonText: 'Delete',
                            rightAction: () {
                              ingController.removeIngredient(context,
                                  ingredientId: widget.ingredient.ingredientId);

                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  IngredientsPage.routeName, (route) => false);
                            }).show(context);
                      }),
                  SizedBox(height: SizeConfig.heightMultiplier * 7),
                  Container(
                    height: SizeConfig.heightMultiplier * 78,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Text(
                                    'Ingredient Picture',
                                    style: size,
                                  ),
                                  SizedBox(
                                      height: SizeConfig.heightMultiplier * 2),
                                  AddingItem(
                                    width: SizeConfig.widthMultiplier * 10,
                                    height: SizeConfig.heightMultiplier * 18,
                                    title: Text(''),
                                    function: () {},
                                    imgUrl: widget.ingredient != null
                                        ? widget.ingredient.ingredientImgUrl
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: SizeConfig.widthMultiplier * 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Ingredient Name',
                                        style: size,
                                      ),
                                      SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier * 2),
                                      TextFieldItem(
                                        initialValue: nameController,
                                        width: SizeConfig.widthMultiplier * 27,
                                        height:
                                            SizeConfig.heightMultiplier * 10,
                                        radius:
                                            SizeConfig.imagesSizeMultiplier * 2,
                                        vPadding:
                                            SizeConfig.heightMultiplier * 4,
                                        hPadding:
                                            SizeConfig.heightMultiplier * 2,
                                        fontSize: SizeConfig.textMultiplier * 4,
                                        bottomMargin:
                                            SizeConfig.heightMultiplier * 3,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Price',
                                        style: size,
                                      ),
                                      SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier * 2),
                                      TextFieldItem(
                                        initialValue: price,
                                        width: SizeConfig.widthMultiplier * 15,
                                        height:
                                            SizeConfig.heightMultiplier * 10,
                                        radius:
                                            SizeConfig.imagesSizeMultiplier * 2,
                                        vPadding:
                                            SizeConfig.heightMultiplier * 4,
                                        hPadding:
                                            SizeConfig.heightMultiplier * 2,
                                        fontSize: SizeConfig.textMultiplier * 4,
                                        bottomMargin:
                                            SizeConfig.heightMultiplier * 3,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: SizeConfig.heightMultiplier * 17,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              AppElevatedButton(
                                fontSize: SizeConfig.textMultiplier * 5,
                                buttonColor: Theme.of(context).primaryColor,
                                width: SizeConfig.widthMultiplier * 25,
                                height: SizeConfig.heightMultiplier * 10,
                                inColor: Theme.of(context).canvasColor,
                                radius: SizeConfig.imagesSizeMultiplier * 1.5,
                                function: () {},
                                child: Text('Save'),
                              )
                            ],
                          ),
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
