import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:testdrive/CustomPainter/SingleBar.dart';

class MultipleBarChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MultipleBarChartState();
}

class MultipleBarChartState extends State<MultipleBarChart>
    with TickerProviderStateMixin {
  final size = const Size(200.0, 100.0);
  final random = new Random();
  AnimationController animation;
  BarChartTween tween;

  @override
  void initState() {
    super.initState();
    animation = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    tween = new BarChartTween(
        new BarChart.empty(), new BarChart.random(size, random));
    animation.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text("Multiple Bar Chart"),
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
      tween = new BarChartTween(
          tween.evaluate(animation), new BarChart.random(size, random));
      animation.forward(from: 0.0);
    });
  }
}

class Bar {
  final double x;
  final double width;
  final double height;
  final Color color;

  Bar get collapsed => new Bar(x, 0.0, 0.0, color);

  Bar(this.x, this.width, this.height, this.color);

  static Bar lerp(Bar begin, Bar end, double t) {
    return new Bar(
        lerpDouble(begin.x, end.x, t),
        lerpDouble(begin.width, end.width, t),
        lerpDouble(begin.height, end.height, t),
        Color.lerp(begin.color, end.color, t));
  }
}

class BarChart {
  final List<Bar> bars;

  BarChart(this.bars);

  factory BarChart.empty() {
    return new BarChart(<Bar>[]);
  }

  factory BarChart.random(Size size, Random random) {
    const barWidthFraction = 0.75;
    const minBarDistance = 20.0;
    final barCount = random.nextInt((size.width / minBarDistance).floor()) + 1;
    final barDistance = size.width / (1 + barCount);
    final barWidth = barDistance * barWidthFraction;
    final startX = barDistance - barWidth / 2;
    final color = ColorPalette.primary.random(random);
    final bars = new List.generate(
        barCount,
        (i) => new Bar(
              startX + i * barDistance,
              barWidth,
              random.nextDouble() * size.height,
              color,
            ));
    return new BarChart(bars);
  }

  static BarChart lerp(BarChart begin, BarChart end, double t) {
    final barCount = max(begin.bars.length, end.bars.length);
    final bars = new List.generate(
        barCount,
        (i) => Bar.lerp(begin._barOrNull(i) ?? end.bars[i].collapsed,
            end._barOrNull(i) ?? begin.bars[i].collapsed, t));
    return new BarChart(bars);
  }

  Bar _barOrNull(int index) => (index < bars.length ? bars[index] : null);
}

class BarChartTween extends Tween<BarChart> {
  BarChartTween(BarChart begin, BarChart end) : super(begin: begin, end: end);

  @override
  BarChart lerp(double t) => BarChart.lerp(begin, end, t);
}

class BarChartPainter extends CustomPainter {
  final Animation<BarChart> animation;

  BarChartPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint()..style = PaintingStyle.fill;
    final chart = animation.value;
    for (final bar in chart.bars) {
      paint.color = bar.color;
      canvas.drawRect(
          new Rect.fromLTWH(
              bar.x, size.height - bar.height, bar.width, bar.height),
          paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
