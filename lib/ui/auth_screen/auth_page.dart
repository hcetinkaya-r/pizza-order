import 'package:flutter/material.dart';

import '../../core/util/size_config.dart';
import '../../main/widgets/background_image.dart';
import 'widgets/auth_card.dart';

class AuthPage extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    SizeConfig.fromContext(context);
    return Stack(
      children: <Widget>[
        BackgroundImage(
          type: 'auth_page',
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
        ),
        Positioned(
            left: SizeConfig.widthMultiplier * 4,
            top: SizeConfig.heightMultiplier * 5,
            bottom: SizeConfig.heightMultiplier * 5,
            child: AuthCard()),
      ],
    );
  }
}
