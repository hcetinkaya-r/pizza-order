import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/components/widgets/card_item.dart';
import '../../core/components/widgets/filter.dart';
import '../../core/components/widgets/header/header.dart';
import '../../core/util/size_config.dart';
import '../../main/widgets/background_image.dart';
import '../../main/widgets/main_nav_bar.dart';
import '../../models/user/user_model.dart';
import 'add_user_page.dart';

class UserPage extends StatelessWidget {
  static const routeName = '/user';

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
                  Header(
                    title: 'USERS',
                    type: 'search',
                    action: () {},
                  ),
                  Container(
                    width: SizeConfig.widthMultiplier * 30,
                    height: SizeConfig.heightMultiplier * 85,
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, AddUserPage.routeName),
                          child: CardItem(
                            title: Text(
                              'Add User',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: SizeConfig.textMultiplier * 4),
                            ),
                            width: SizeConfig.widthMultiplier * 30,
                            height: SizeConfig.heightMultiplier * 10,
                            isTrue: true,
                            button: Icon(
                              Icons.add,
                              size: SizeConfig.imagesSizeMultiplier * 4,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        Consumer<UserModel>(
                          builder: (ctx, user, child) => Expanded(
                            child: ListView.builder(
                              itemCount: user.users.length,
                              itemBuilder: (ctx, index) => InkWell(
                                onTap: () => Navigator.pushNamed(context,
                                    '${AddUserPage.routeName}/${user.users[index].userId}'),
                                child: CardItem(
                                  width: SizeConfig.widthMultiplier * 30,
                                  height: SizeConfig.heightMultiplier * 10,
                                  title: Container(
                                    width: SizeConfig.widthMultiplier * 25,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          user.users[index].userName,
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize:
                                                  SizeConfig.textMultiplier *
                                                      3),
                                        ),
                                        Text(
                                          user.users[index].userType
                                              .toString()
                                              .split('.')
                                              .last,
                                          style: TextStyle(
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontSize:
                                                  SizeConfig.textMultiplier *
                                                      2),
                                        ),
                                      ],
                                    ),
                                  ),
                                  isTrue: true,
                                  button: Container(),
                                ),
                              ),
                            ),
                          ),
                        )
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
