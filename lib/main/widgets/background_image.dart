import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final String type;

  const BackgroundImage({
    Key key,
    this.type = 'standart_page',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [Colors.black, Colors.black12],
          begin: Alignment.bottomCenter,
          end: Alignment.center,
        ).createShader(bounds),
        blendMode: BlendMode.darken,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/background.png',
              ),
              fit: BoxFit.cover,
              //colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
            ),
          ),
        ),
      ),
    );
  }
}
