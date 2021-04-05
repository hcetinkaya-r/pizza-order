import 'package:flutter/material.dart';

import '../../util/size_config.dart';

class AddingItem extends StatelessWidget {
  final double width;
  final double height;
  final Widget title;
  final String imgUrl;

  final Function function;

  const AddingItem(
      {this.width, this.height, this.title, this.function, this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Card(
        color: Theme.of(context).canvasColor.withOpacity(0.8),
        elevation: 4,
        shadowColor: Colors.grey.shade400,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(SizeConfig.imagesSizeMultiplier * 3),
        ),
        child: Container(
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imgUrl != null
                  ? Container(
                      height: height - SizeConfig.heightMultiplier * 4,
                      child: Image.asset(
                        imgUrl,
                        fit: BoxFit.contain,
                      ),
                    )
                  : Icon(
                      Icons.add,
                      color: Theme.of(context).primaryColor,
                      size: SizeConfig.imagesSizeMultiplier * 4,
                    ),
              title,
            ],
          ),
        ),
      ),
    );
  }
}
