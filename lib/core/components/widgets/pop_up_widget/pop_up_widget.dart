import 'package:flutter/material.dart';

import '../../../util/size_config.dart';
import '../../buttons/elevated_button.dart';

/// ## Custom Popup
/// **Example Usage
///
/// PopUpDialog(
///   content: Container(
///     height: SizeConfig.heightMultiplier * 50,
///     width: SizeConfig.widthMultiplier * 100,
///     color: Colors.amber,
///     child: Text('Deneme df asdas'),
///   ),
///   title: 'Demo',
///   rightAction: () => print('bastık'),
///   rightButtonText: 'Bas',
///   leftButtonText: 'Exit',
/// ).show(context)***,

class PopUpDialog extends StatelessWidget {
  final Widget content;
  final String leftButtonText;
  final String rightButtonText;
  final String title;
  final Function rightAction;

  const PopUpDialog(
      {Key key,
      this.content,
      this.leftButtonText,
      this.title,
      this.rightButtonText,
      this.rightAction})
      : super(key: key);

  Future<bool> show(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (_) => this,
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(title),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            content,
            SizedBox(height: SizeConfig.heightMultiplier * 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: assignActions(context),
            )
          ],
        )
      ],
    );
  }

  List<Widget> assignActions(BuildContext context) {
    final allButton = <Widget>[];
    if (leftButtonText != null) {
      allButton.add(AppElevatedButton(
        fontSize: SizeConfig.textMultiplier * 3.5,
        buttonColor: Theme.of(context).accentColor,
        width: SizeConfig.widthMultiplier * 10,
        height: SizeConfig.heightMultiplier * 5,
        inColor: Colors.white,
        radius: SizeConfig.imagesSizeMultiplier * 2,
        function: () => Navigator.of(context).pop(),
        child: Text(
          leftButtonText,
          style: TextStyle(
              fontSize: SizeConfig.textMultiplier * 2.5,
              fontWeight: FontWeight.bold),
        ),
      ));
    }
    allButton.add(
      AppElevatedButton(
        fontSize: SizeConfig.textMultiplier * 3.5,
        buttonColor: Theme.of(context).errorColor,
        width: SizeConfig.widthMultiplier * 10,
        height: SizeConfig.heightMultiplier * 5,
        inColor: Colors.white,
        radius: SizeConfig.imagesSizeMultiplier * 2,
        function: rightAction,
        child: Text(
          rightButtonText,
          style: TextStyle(
              fontSize: SizeConfig.textMultiplier * 2.5,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
    return allButton;
  }
}
