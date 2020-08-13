import 'package:algo_visualizer/config/palette.dart';
import 'package:flutter/cupertino.dart';

class NumberViewer extends CustomPainter {
  final double barWidth;
  final int elementValue;
  final int elementIndex;

  NumberViewer(this.barWidth, this.elementValue, this.elementIndex);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Palette.brightText;
    paint.strokeWidth = barWidth;
    paint.strokeCap = StrokeCap.butt;
    canvas.drawLine(
        Offset(elementIndex * barWidth, elementValue.ceilToDouble()),
        Offset(elementIndex * barWidth, 500),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
