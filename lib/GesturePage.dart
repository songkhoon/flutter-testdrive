import 'package:flutter/material.dart';

class GesturePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _GesturePageState();
  }
}

class _GesturePageState extends State<GesturePage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    animation = new Tween(begin: 0.0, end: 100.0).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.value = 0.9;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Gesture Page"),
      ),
      body: new Center(
        child: animatedListenerWidget(),
      ),
    );
  }

  Widget _logoAnimatedState() {
    return new LogoAnimatedState(
      child: new LogoWidget(),
      animation: animation,
    );
  }

  Listener animatedListenerWidget() {
    return new Listener(
      child: gestureDetector(),
      onPointerDown: (e) {
        if (animation.status == AnimationStatus.completed) {
          controller.reverse();
        } else if (animation.status == AnimationStatus.reverse) {
          controller.reverse();
        } else {
          controller.forward();
        }
      },
      onPointerUp: (e) {
        controller.stop();
      },
    );
  }

  GestureDetector gestureDetector() {
    return new GestureDetector(
      child: _logoAnimatedState(),
      onTap: () {
        print("tap");
      },
      onLongPress: () {
        print("long press");
      },
      onTapDown: (tapDetail) {
        print("tab down: ${tapDetail.globalPosition}");
      },
      onTapUp: (tapDetail) {
        print("tap up: ${tapDetail.globalPosition}");
      },
      onTapCancel: () {
        print("tap cancel");
      },
      onPanDown: (panDetail) {
        print("pan down: ${panDetail}");
      },
      onPanStart: (dragDetail) {
        print("pas start: ${dragDetail}");
      },
      onPanEnd: (dragDetail) {
        print("pad end: ${dragDetail}");
      },
      onPanCancel: () {
        print("pan cancel");
      },
      onPanUpdate: (tapDetail) {
        print("pan update: ${tapDetail}");
      },
    );
  }
}

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: const FlutterLogo(),
      width: 200.0,
      height: 200.0,
    );
  }
}

class LogoAnimatedState extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  LogoAnimatedState({this.child, this.animation});

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return new Container(
          child: child,
          width: animation.value,
          height: animation.value,
        );
      },
      child: child,
    );
  }
}
