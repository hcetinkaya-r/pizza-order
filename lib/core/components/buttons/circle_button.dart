import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'normal_button.dart';

class CircleButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color color;
  final BoxConstraints constraints;

  const CircleButton(
      {Key key, this.child, this.onPressed, this.color, this.constraints})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NormalButton(
      child: child,
      onPressed: onPressed,
      type: CircleBorder(),
      color: color,
      constraints: constraints,
    );
  }
}
