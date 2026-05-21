import 'package:flutter/material.dart';
import 'app_color.dart';

class DashedLine extends StatelessWidget {
  final double height;
  final Color color;

  const DashedLine({super.key, this.height = 1, this.color = AppColor.posAddress});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 6.0;
        const dashSpace = 4.0;
        final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return Container(
              width: dashWidth,
              height: height,
              color: color,
            );
          }),
        );
      },
    );
  }
}