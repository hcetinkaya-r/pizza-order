import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/util/size_config.dart';
import '../../models/user/user_model.dart';
import '../../ui/auth_screen/auth_page.dart';
import '../../ui/menu_screen/menu_page.dart';
import '../../ui/order_screens/open_orders_page.dart';
import '../../ui/products_screen/products_main_page.dart';
import '../../ui/users_screen/user_page.dart';

class MainNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<UserModel>(context, listen: false);
    return Container(
      height: SizeConfig.heightMultiplier * 100,
      width: SizeConfig.widthMultiplier * 22,
      color: Theme.of(context).canvasColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Image(
              image: AssetImage(
                'assets/logo/logo.png',
              ),
              width: SizeConfig.widthMultiplier * 24,
              height: SizeConfig.heightMultiplier * 23),
          Container(
            height: SizeConfig.heightMultiplier * 60,
            margin: EdgeInsets.only(left: SizeConfig.widthMultiplier * 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainNavBarListTile(
                  imgUrl: 'assets/icons/menu.png',
                  title: 'MENU',
                  route: () => Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          MenuPage(),
                      transitionDuration: Duration(seconds: 0),
                    ),
                  ),
                ),
                MainNavBarListTile(
                  imgUrl: 'assets/icons/orders.png',
                  title: 'ORDERS',
                  route: () => Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          OpenOrdersPage(),
                      transitionDuration: Duration(seconds: 0),
                    ),
                  ),
                ),
                prov.user.userType == UserType.Admin
                    ? MainNavBarListTile(
                        imgUrl: 'assets/icons/products.png',
                        title: 'PRODUCTS',
                        route: () => Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                ProductsMainPage(),
                            transitionDuration: Duration(seconds: 0),
                          ),
                        ),
                      )
                    : Container(),
                prov.user.userType == UserType.Admin
                    ? MainNavBarListTile(
                        imgUrl: 'assets/icons/users.png',
                        title: 'USERS',
                        route: () => Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                UserPage(),
                            transitionDuration: Duration(seconds: 0),
                          ),
                        ),
                      )
                    : Container(),
                Spacer(),
                ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Theme.of(context).errorColor,
                  ),
                  title: Text(
                    'LOG OUT',
                    style: TextStyle(color: Theme.of(context).errorColor),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: SizeConfig.heightMultiplier * 1.8,
                      horizontal: SizeConfig.widthMultiplier * 1.8),
                  onTap: () => Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          AuthPage(),
                      transitionDuration: Duration(seconds: 0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MainNavBarListTile extends StatelessWidget {
  final String imgUrl;
  final String title;
  final Function route;
  const MainNavBarListTile({this.imgUrl, this.title, this.route});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2),
      leading: Container(
        width: SizeConfig.widthMultiplier * 3,
        height: SizeConfig.heightMultiplier * 3,
        child: Image.asset(
          imgUrl,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: SizeConfig.textMultiplier * 3),
      ),
      onTap: route,
    );
  }
}
