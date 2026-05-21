import 'package:flutter/material.dart';

import '../../constants/figma_size.dart';

class FlippedImage extends StatelessWidget {
  final String imagePath;
  final double widthFactor;
  final double? bottom;
  final double? left;
  final double? right;
  final double? top;
  final BoxFit fit;
  final bool flip;

  const FlippedImage({
    super.key,
    this.imagePath = 'assets/images/1.png',
    this.widthFactor = 0.4,
    this.bottom ,
    this.left = -50,
    this.right,
    this.top = 500,
    this.fit = BoxFit.cover,
    this.flip = true,
  });

  @override
  Widget build(BuildContext context) {

    final media = MediaQuery.of(context);
    final isLandscape = media.orientation == Orientation.landscape;

    Widget image = Image.asset(
      imagePath,
      width: isLandscape ? FigmaSize.width(context, 500) : FigmaSize.width(context, 400),
      fit: fit,
    );

    if (flip) {
      image = Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(3.1415926535),
        child: image,
      );
    }

    return Positioned(
      bottom: bottom,
      left: FigmaSize.responsiveWidth(context, left!),
      right: right,
      top: FigmaSize.responsiveHeight(context, top!),
      child: IgnorePointer(child: image),
    );
  }
}