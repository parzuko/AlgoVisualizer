import 'package:algo_visual/config/palette.dart';
import 'package:flutter/cupertino.dart';

class NumberViewer extends CustomPainter {
  final double barWidth;
  int elementValue;
  final int elementIndex;
  final int maxVal;

  NumberViewer({
    this.barWidth,
    this.elementValue,
    this.elementIndex,
    this.maxVal,
  });

  final multiplyer = {
    500: 1,
    400: 1,
    300: .99,
    200: .99,
    100: 2,
  };

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = insertionPalette(elementValue);
    paint.strokeWidth = barWidth;
    paint.strokeCap = StrokeCap.butt;

    // if (this.maxVal < 250) {
    //   this.elementValue += 10;
    // }

    canvas.drawLine(
        Offset(elementIndex * barWidth,
            elementValue.ceilToDouble() * multiplyer[maxVal]),
        Offset(elementIndex * barWidth, 0),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  Color insertionPalette(int value) {
    if (this.elementValue < maxVal * .20) {
      return Palette.insertion_1;
    } else if (this.elementValue < maxVal * .40) {
      return Palette.insertion_2;
    } else if (this.elementValue < maxVal * .60) {
      return Palette.insertion_3;
    } else if (this.elementValue < maxVal * .80) {
      return Palette.insertion_4;
    } else {
      return Palette.insertion_5;
    }
  }
}
