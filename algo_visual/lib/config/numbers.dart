import 'package:algo_visual/config/palette.dart';
import 'package:flutter/cupertino.dart';

class NumberViewer extends CustomPainter {
  final double barWidth;
  int elementValue;
  final int elementIndex;
  final int maxVal;
  final int whichColor;
  final int whichMode;

  NumberViewer({
    this.barWidth,
    this.elementValue,
    this.elementIndex,
    this.maxVal,
    this.whichColor,
    this.whichMode,
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
    paint.strokeWidth = barWidth;
    paint.strokeCap = StrokeCap.butt;
    var themes = {
      1: arcticHorizon(elementValue),
      2: summerHues(elementValue),
      3: kindergartenNotebook(elementValue),
      4: ketchupRed(elementValue),
      5: iceCream(elementValue),
    };
    paint.color = themes[whichColor];
    final modes = {
      1: {
        1: elementValue.ceilToDouble() * multiplyer[maxVal],
        2: 1.0,
        3: 0.0,
      }, //Normal Mode

      2: {
        1: 3000.0,
        2: 20.0,
        3: 0.0,
      }, //Frenzy Mode

      3: {
        1: elementValue.ceilToDouble() * multiplyer[maxVal],
        2: 1.0,
        3: 500.0,
        //Upside Down Mode
      },
    };

    canvas.drawLine(
        Offset(
            elementIndex * barWidth * modes[whichMode][2], modes[whichMode][1]),
        Offset(elementIndex * barWidth, modes[whichMode][3]),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  Color summerHues(int value) {
    if (this.elementValue < maxVal * .20) {
      return Palette.vibrant_1;
    } else if (this.elementValue < maxVal * .40) {
      return Palette.vibrant_2;
    } else if (this.elementValue < maxVal * .60) {
      return Palette.vibrant_3;
    } else if (this.elementValue < maxVal * .80) {
      return Palette.vibrant_4;
    } else {
      return Palette.vibrant_5;
    }
  }

  Color kindergartenNotebook(int value) {
    if (this.elementValue < maxVal * .20) {
      return Palette.pastel_1;
    } else if (this.elementValue < maxVal * .40) {
      return Palette.pastel_2;
    } else if (this.elementValue < maxVal * .60) {
      return Palette.pastel_3;
    } else if (this.elementValue < maxVal * .80) {
      return Palette.pastel_4;
    } else {
      return Palette.pastel_5;
    }
  }

  Color ketchupRed(int value) {
    if (this.elementValue < maxVal * .20) {
      return Palette.red_1;
    } else if (this.elementValue < maxVal * .40) {
      return Palette.red_2;
    } else if (this.elementValue < maxVal * .60) {
      return Palette.red_3;
    } else if (this.elementValue < maxVal * .80) {
      return Palette.red_4;
    } else {
      return Palette.red_5;
    }
  }

  Color iceCream(int value) {
    if (this.elementValue < maxVal * .20) {
      return Palette.iceCream_1;
    } else if (this.elementValue < maxVal * .40) {
      return Palette.iceCream_2;
    } else if (this.elementValue < maxVal * .60) {
      return Palette.iceCream_3;
    } else if (this.elementValue < maxVal * .80) {
      return Palette.iceCream_4;
    } else {
      return Palette.iceCream_5;
    }
  }

  Color arcticHorizon(int value) {
    if (this.elementValue < maxVal * .14) {
      return Palette.blue_0;
    } else if (this.elementValue < maxVal * .28) {
      return Palette.blue_1;
    } else if (this.elementValue < maxVal * .42) {
      return Palette.blue_2;
    } else if (this.elementValue < maxVal * .56) {
      return Palette.blue_3;
    } else if (this.elementValue < maxVal * .70) {
      return Palette.blue_4;
    } else if (this.elementValue < maxVal * .84) {
      return Palette.blue_5;
    } else {
      return Palette.blue_6;
    }
  }
}
