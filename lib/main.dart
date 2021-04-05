import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'controllers/category/category_controller.dart';
import 'controllers/ingredient/ingredient_controller.dart';
import 'controllers/order/order_controller.dart';
import 'controllers/sub_product/sub_product_controller.dart';
import 'controllers/user/user_controller.dart';
import 'models/category/category_model.dart';
import 'models/ingredient/ingredient_model.dart';
import 'models/order/order_model.dart';
import 'models/product/product_model.dart';
import 'models/sub_product/sub_product_model.dart';
import 'models/user/user_model.dart';
import 'ui/auth_screen/auth_page.dart';
import 'ui/categories_screen/add_category_page.dart';
import 'ui/categories_screen/categories_page.dart';
import 'ui/ingredients_screen/add_ingredient_page.dart';
import 'ui/ingredients_screen/ingredients_page.dart';
import 'ui/menu_screen/menu_page.dart';
import 'ui/order_screens/edit_order_page.dart';
import 'ui/order_screens/open_orders_page.dart';
import 'ui/order_screens/order_payment_page.dart';
import 'ui/products_screen/add_sub_product_page.dart';
import 'ui/products_screen/products_main_page.dart';
import 'ui/products_screen/sub_products_page.dart';
import 'ui/users_screen/add_user_page.dart';
import 'ui/users_screen/user_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => UserModel.instance()),
        ChangeNotifierProvider(create: (ctx) => CategoryModel.instance()),
        ChangeNotifierProvider(create: (ctx) => SubProductModel.instance()),
        ChangeNotifierProvider(create: (ctx) => ProductModel.instance()),
        ChangeNotifierProvider(create: (ctx) => OrderModel.instance()),
        ChangeNotifierProvider(create: (ctx) => IngredientModel.instance()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Desktop Pizzeria',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: Colors.red,
          accentColor: Colors.green,
          buttonTheme: ButtonThemeData(buttonColor: Colors.grey),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: Colors.red,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(fontSize: 40),
              primary: Colors.red,
              minimumSize: Size(348, 94.8),
              onPrimary: Colors.white,
              elevation: 10,
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(66.8),
                ),
              ),
            ),
          ),
        ),
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (context) => MenuPage());
        },
        home: AuthPage(),
        routes: {
          MenuPage.routeName: (ctx) => MenuPage(),
          UserPage.routeName: (ctx) => UserPage(),
          AddCategoryPage.routeName: (ctx) => AddCategoryPage(),
          CategoriesPage.routeName: (ctx) => CategoriesPage(),
          AddIngredientPage.routeName: (ctx) => AddIngredientPage(),
          IngredientsPage.routeName: (ctx) => IngredientsPage(),
          OpenOrdersPage.routeName: (ctx) => OpenOrdersPage(),
          OrderPaymentPage.routeName: (ctx) => OrderPaymentPage(),
          EditOrderPage.routeName: (ctx) => EditOrderPage(),
          AddSubProductPage.routeName: (ctx) => AddSubProductPage(),
          ProductsMainPage.routeName: (ctx) => ProductsMainPage(),
          SubProductsPage.routeName: (ctx) => SubProductsPage(),
          AddUserPage.routeName: (ctx) => AddUserPage(),
        },
        onGenerateRoute: (settings) {
          var subProductController = SubProductController();
          var categoryController = CategoryController();
          var ingredientController = IngredientController();
          var userController = UserController();
          var orderController = OrderController();
          if (settings.name.split('/')[1] == 'edit-order') {
            return MaterialPageRoute(
                builder: (ctx) => EditOrderPage(
                    subProduct: subProductController.getSubProduct(
                        ctx, settings.name.split('/')[2])));
          } else if (settings.name.split('/')[1] == 'add-category') {
            return MaterialPageRoute(
                builder: (ctx) => AddCategoryPage(
                      category: categoryController.getCategory(
                          ctx, settings.name.split('/')[2]),
                    ));
          } else if (settings.name.split('/')[1] == 'add-ingredient') {
            return MaterialPageRoute(
              builder: (ctx) => AddIngredientPage(
                ingredient: ingredientController.getIngredient(
                    ctx, settings.name.split('/')[2]),
              ),
            );
          } else if (settings.name.split('/')[1] == 'add-subProduct') {
            return MaterialPageRoute(
              builder: (ctx) =>
                  AddSubProductPage(subProductId: settings.name.split('/')[2]),
            );
          } else if (settings.name.split('/')[1] == 'add-user') {
            return MaterialPageRoute(
                builder: (ctx) => AddUserPage(
                      user: userController.getUser(
                          ctx, settings.name.split('/')[2]),
                    ));
          } else if (settings.name.split('/')[1] == 'order-payment') {
            return MaterialPageRoute(
                builder: (ctx) => OrderPaymentPage(
                      order: orderController.getOrder(ctx, settings.arguments),
                    ));
          } else {
            return MaterialPageRoute(builder: (ctx) => MenuPage());
          }
        },
      ),
    );
  }
}
