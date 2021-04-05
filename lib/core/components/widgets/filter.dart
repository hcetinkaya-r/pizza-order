import 'package:flutter/material.dart';

import '../../util/size_config.dart';

class Filter extends StatelessWidget {
  const Filter({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: SizeConfig.heightMultiplier * 100,
        width: SizeConfig.widthMultiplier * 100,
        color: Colors.white.withOpacity(.6));
  }
}
