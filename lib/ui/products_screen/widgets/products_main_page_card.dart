import 'package:flutter/material.dart';

import '../../../core/util/size_config.dart';

class ProductsMainPageCard extends StatelessWidget {
  final String title;
  final Function route;

  const ProductsMainPageCard({this.title, this.route});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: route,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(SizeConfig.imagesSizeMultiplier * 2)),
        margin: EdgeInsets.symmetric(vertical: SizeConfig.widthMultiplier * 3),
        color: Theme.of(context).canvasColor.withOpacity(0.8),
        elevation: 4,
        shadowColor: Colors.grey.shade100,
        child: Container(
          alignment: Alignment.center,
          width: SizeConfig.heightMultiplier * 30,
          height: SizeConfig.widthMultiplier * 8,
          child: Text(
            title,
            style: TextStyle(fontSize: SizeConfig.textMultiplier * 3),
          ),
        ),
      ),
    );
  }
}
