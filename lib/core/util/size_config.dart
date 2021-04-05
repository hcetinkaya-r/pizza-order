import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/*
SizeConfig file is a tool to adopt to different screen sizes.
It will take the origiginal design values and adopt to current 
screen size with multipliers. This will allow to keep the original 
design on every screen size including ipad amd tablet.
 */

class SizeConfig {
  static double _screenWidth;
  static double _screenHeight;
  static double _blockSizeHorizontal;
  static double _blockSizeVertical;

  static double textMultiplier;
  static double imagesSizeMultiplier;
  static double heightMultiplier;
  static double widthMultiplier;

  SizeConfig();

  SizeConfig.fromContext(BuildContext context){
    imagesSizeMultiplier = MediaQuery.of(context).size.width / 100.0;
    textMultiplier = MediaQuery.of(context).size.height / 100.0;
    heightMultiplier=  MediaQuery.of(context).size.height / 100.0;
    widthMultiplier  = MediaQuery.of(context).size.width / 100.0;
  }

  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
    } else {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
    }

    _blockSizeHorizontal = _screenWidth / 100;
    _blockSizeVertical = _screenHeight / 100;

    textMultiplier = _blockSizeVertical;
    imagesSizeMultiplier = _blockSizeHorizontal;
    heightMultiplier = _blockSizeVertical;
    widthMultiplier = _blockSizeHorizontal;

  }

  double get height => heightMultiplier;

  double get width => widthMultiplier;
}
