import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/components/widgets/card_item.dart';
import '../../core/components/widgets/filter.dart';
import '../../core/components/widgets/header/header.dart';
import '../../core/util/size_config.dart';
import '../../main/widgets/background_image.dart';
import '../../main/widgets/main_nav_bar.dart';
import '../../models/ingredient/ingredient_model.dart';
import '../order_screens/widgets/ingredient_card.dart';
import 'add_ingredient_page.dart';

class IngredientsPage extends StatelessWidget {
  static const routeName = '/ingredients';

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
              width: SizeConfig.widthMultiplier * 74,
              margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.heightMultiplier * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: SizeConfig.heightMultiplier * 10,
                    width: SizeConfig.widthMultiplier * 74,
                    child: Header(
                      title: 'INGREDIENTS',
                      type: 'search',
                      action: () {},
                    ),
                  ),
                  Container(
                    width: SizeConfig.widthMultiplier * 40,
                    height: SizeConfig.heightMultiplier * 85,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, AddIngredientPage.routeName),
                          child: CardItem(
                            title: Text(
                              'Add Ingredient',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: SizeConfig.textMultiplier * 4),
                            ),
                            width: SizeConfig.widthMultiplier * 40,
                            height: SizeConfig.heightMultiplier * 10,
                            isTrue: true,
                            button: Icon(
                              Icons.add,
                              size: SizeConfig.imagesSizeMultiplier * 4,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        Consumer<IngredientModel>(
                          builder: (ctx, ing, child) => Expanded(
                            child: ListView.builder(
                              itemCount: ing.ingredients.length,
                              itemBuilder: (ctx, index) => InkWell(
                                onTap: () => Navigator.pushNamed(context,
                                    '${AddIngredientPage.routeName}/'
                                    '${ing.ingredients[index].ingredientId}'),
                                child: IngredientCard(
                                  ingredient: ing.ingredients[index],
                                  isInclude: true,
                                  button: Container(),
                                ),
                              ),
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
        ],
      ),
    );
  }
}
