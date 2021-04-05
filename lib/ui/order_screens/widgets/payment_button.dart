import 'package:flutter/material.dart';

import '../../../core/util/size_config.dart';

class PaymentButton extends StatelessWidget {
  final String imgUrl;
  final String method;

  const PaymentButton({this.imgUrl, this.method});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(SizeConfig.imagesSizeMultiplier * 2),
        ),
        child: Container(
          height: SizeConfig.heightMultiplier * 15,
          width: SizeConfig.widthMultiplier * 8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Image(
                  image: AssetImage(imgUrl),
                  width: SizeConfig.widthMultiplier * 5,
                  height: SizeConfig.heightMultiplier * 8,
                ),
              ),
              Text(method),
            ],
          ),
        ),
      ),
    );
  }
}
