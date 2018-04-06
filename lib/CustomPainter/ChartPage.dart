import 'dart:math';
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

class ChartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ChartPageState();
}

class ChartPageState extends State<ChartPage> with TickerProviderStateMixin {
  final random = new Random();
  int dataset = 50;
  AnimationController animation;
  Tween<double> tween;
  double startHeight;
  double currentHeight;
  double endHeight;

  @override
  void initState() {
    super.initState();
    animation = new AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    tween = new Tween<double>(begin: 0.0, end: dataset.toDouble());
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
        title: const Text("Chart Page"),
      ),
      body: new Center(
        child: new Container(
          color: Colors.orange,
          child: new CustomPaint(
            size: new Size(100.0, 100.0),
            painter: new BarChartPainter(tween.animate(animation)),
          ),
        )
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: changeData,
        child: new Icon(Icons.refresh),
      ),
    );
  }

  void changeData() {
    setState(() {
      dataset = random.nextInt(100);
      tween = new Tween<double>(begin: tween.evaluate(animation), end: dataset.toDouble());
      animation.forward(from: 0.0);
    });
  }
}

class BarChartPainter extends CustomPainter {
  static const barWidth = 10.0;

  final Animation<double> animation;

  BarChartPainter(this.animation): super(repaint: animation);
  // BarChartPainter(Animation<double> animation): animation = animation, super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final double barHeight = animation.value;
    final paint = new Paint()
      ..color = Colors.blue[400]
      ..style = PaintingStyle.fill;
    canvas.drawRect(
        new Rect.fromLTWH((size.width - barWidth) / 2.0,
            size.height - barHeight, barWidth, barHeight),
        paint);
  }

  @override
  bool shouldRepaint(BarChartPainter oldDelegate) => false;
}
