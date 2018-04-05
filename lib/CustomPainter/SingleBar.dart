import 'dart:math';
import 'dart:ui' show lerpDouble;
import "package:flutter/material.dart";

class SingleBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new SingleBarState();
}

class SingleBarState extends State<SingleBar> with TickerProviderStateMixin {
  final random = new Random();
  AnimationController animation;
  BarTween tween;

  @override
  void initState() {
    super.initState();
    animation = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    tween = new BarTween(new Bar.empty(), new Bar.random(random));
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
      appBar: new AppBar(title: const Text("Single Bar")),
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
      tween = new BarTween(tween.evaluate(animation), new Bar.random(random));
      animation.forward(from: 0.0);
    });
  }
}

class Bar {
  final double height;
  final Color color;

  Bar(this.height, this.color);

  factory Bar.empty() => new Bar(0.0, Colors.transparent);

  factory Bar.random(Random random) {
    return new Bar(
      random.nextDouble() * 100.0,
      ColorPalette.primary.random(random),
    );
  }

  static Bar lerp(Bar begin, Bar end, double t) {
    return new Bar(
      lerpDouble(begin.height, end.height, t),
      Color.lerp(begin.color, end.color, t),
    );
  }
}

class ColorPalette {
  final List<Color> _colors;

  static final ColorPalette primary = new ColorPalette(<Color>[
    Colors.blue[400],
    Colors.red[400],
    Colors.green[400],
    Colors.yellow[400],
    Colors.purple[400],
    Colors.orange[400],
    Colors.teal[400],
  ]);

  int get length => _colors.length;

  ColorPalette(List<Color> colors) : _colors = colors {
    assert(colors.isNotEmpty);
  }

  Color operator [](int index) => _colors[index % length];

  Color random(Random random) => this[random.nextInt(length)];
}

class BarTween extends Tween<Bar> {
  BarTween(Bar begin, Bar end) : super(begin: begin, end: end);

  @override
  Bar lerp(double t) => Bar.lerp(begin, end, t);
}

class BarChartPainter extends CustomPainter {
  static const barWidth = 10.0;
  final Animation<Bar> animation;

  BarChartPainter(Animation<Bar> animation)
      : animation = animation,
        super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final bar = animation.value;
    final paint = new Paint()
      ..color = bar.color
      ..style = PaintingStyle.fill;
    canvas.drawRect(
        new Rect.fromLTWH((size.width - barWidth) / 2.0,
            size.height - bar.height, barWidth, bar.height),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
