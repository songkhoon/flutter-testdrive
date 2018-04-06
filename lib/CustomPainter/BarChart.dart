import 'dart:math';
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:testdrive/CustomPainter/SingleBar.dart';

class BarChartStateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new BarChartState();
}

class BarChartState extends State<BarChartStateful>
    with TickerProviderStateMixin {
  final Random random = new Random();
  AnimationController animation;
  BarChartTween tween;

  @override
  void initState() {
    super.initState();
    animation = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    tween =
        new BarChartTween(new BarChart.empty(), new BarChart.random(random));
    animation.forward();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text("Bar Chart"),
      ),
      body: new Center(
        child: new CustomPaint(
          size: new Size(200.0, 100.0),
          painter: new BarChartPainter(tween.animate(animation)),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: changeData,
        child: new Icon(Icons.refresh),
      ),
    );
  }

  void changeData() {
    setState(() {
      tween = new BarChartTween(tween.evaluate(animation), new BarChart.random(random));
      animation.forward(from: 0.0);
    });
  }
}

class BarChart {
  static const int barCount = 5;
  final List<Bar> bars;

  BarChart(this.bars) {
    assert(bars.length == barCount);
  }

  factory BarChart.empty() {
    return new BarChart(
        new List.filled(barCount, new Bar(0.0, Colors.transparent)));
  }

  factory BarChart.random(Random random) {
    final Color color = ColorPalette.primary.random(random);
    return new BarChart(new List.generate(
        barCount, (i) => new Bar(random.nextDouble() * 100.0, color)));
  }

  static BarChart lerp(BarChart begin, BarChart end, double t) {
    return new BarChart(new List.generate(
        barCount, (i) => Bar.lerp(begin.bars[i], end.bars[i], t)));
  }
}

class BarChartTween extends Tween<BarChart> {
  BarChartTween(BarChart begin, BarChart end) : super(begin: begin, end: end);

  @override
  BarChart lerp(double t) {
    return BarChart.lerp(begin, end, t);
  }
}

class Bar {
  final double height;
  final Color color;

  Bar(this.height, this.color);

  static Bar lerp(Bar begin, Bar end, double t) {
    return new Bar(lerpDouble(begin.height, end.height, t),
        Color.lerp(begin.color, end.color, t));
  }
}

class BarChartPainter extends CustomPainter {
  static const barWidthFraction = 0.75;
  final Animation<BarChart> animation;

  BarChartPainter(this.animation): super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    void drawBar(Bar bar, double x, double width, Paint paint) {
      paint.color = bar.color;
      canvas.drawRect(
          new Rect.fromLTWH(x, size.height - bar.height, width, bar.height),
          paint);
    }

    final paint = new Paint()..style = PaintingStyle.fill;
    final chart = animation.value;
    final barDistance = size.width / (1 + chart.bars.length);
    final barWidth = barDistance * barWidthFraction;
    var x = barDistance - barWidth / 2;
    for (final bar in chart.bars) {
      drawBar(bar, x, barWidth, paint);
      x += barDistance;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
