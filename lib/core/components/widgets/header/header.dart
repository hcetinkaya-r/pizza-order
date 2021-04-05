import 'package:flutter/material.dart';

import '../../../util/size_config.dart';
import '../../buttons/elevated_button.dart';

class Header extends StatelessWidget {
  const Header({@required this.title, @required this.type, this.action});

  final String title;
  final Function action;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.widthMultiplier * 72,
      height: SizeConfig.heightMultiplier * 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppElevatedButton(
            fontSize: SizeConfig.textMultiplier * 1.5,
            buttonColor: Theme.of(context).primaryColor,
            width: SizeConfig.widthMultiplier * 10,
            height: SizeConfig.heightMultiplier * 6,
            inColor: Theme.of(context).canvasColor,
            radius: SizeConfig.imagesSizeMultiplier * 1,
            function: () => Navigator.maybePop(context),
            child: Text('Back'),
          ),
          Text(
            '$title',
            style: TextStyle(
                color: Colors.black, fontSize: SizeConfig.textMultiplier * 4.5),
          ),
          type == 'search'
              ? IconButton(
                  onPressed: action,
                  icon: Icon(Icons.search),
                  color: Theme.of(context).primaryColor,
                  iconSize: SizeConfig.imagesSizeMultiplier * 3,
                )
              : type == 'edit'
                  ? AppElevatedButton(
                      fontSize: SizeConfig.textMultiplier * 1.5,
                      buttonColor: Colors.blueGrey,
                      width: SizeConfig.widthMultiplier * 10,
                      height: SizeConfig.heightMultiplier * 6,
                      inColor: Theme.of(context).canvasColor,
                      radius: SizeConfig.imagesSizeMultiplier * 1,
                      function: action,
                      child: Text('Delete'),
                    )
                  : Container(),
        ],
      ),
    );
  }
}
