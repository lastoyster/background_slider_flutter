import 'package:flutter/material.dart';
import 'package:background_slider_flutter';

class CustomThumbShape extends SliderComponentShape {
  final double thumbRadius;
  final double thumbHeight;
  final Color thumbColor;
  final Color borderColor;

  const CustomThumbShape({
    required this.thumbRadius,
    required this.thumbHeight,
    required this.thumbColor,
    required this.borderColor,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double>? activationAnimation,
    required Animation<double> enableAnimation,
    bool? isDiscrete,
    TextPainter? labelPainter,
    RenderBox? parentBox,
    SliderThemeData? sliderTheme,
    TextDirection? textDirection,
    double? value,
    double? textScaleFactor,
    Size? sizeWithOverflow,
  }) {
    final canvas = context.canvas;

    // Draw the outer border
    final outerRadius = thumbRadius + thumbHeight / 2;
    final outerPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = thumbHeight;
    canvas.drawCircle(center, outerRadius, outerPaint);

    // Draw the inner circle
    final innerPaint = Paint()..color = thumbColor;
    canvas.drawCircle(center, thumbRadius, innerPaint);
  }
}