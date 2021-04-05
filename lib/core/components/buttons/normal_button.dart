import 'package:flutter/material.dart';

class NormalButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final ShapeBorder type;
  final Color color;
  final BoxConstraints constraints;

  const NormalButton(
      {Key key,
      this.child,
      this.onPressed,
      this.type,
      this.color,
      this.constraints})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: constraints,
      fillColor: color,
      child: child,
      shape: type ?? RoundedRectangleBorder(),
      onPressed: onPressed,
    );
  }
}
