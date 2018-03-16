import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _AnimationState();
  }
}

class _AnimationState extends State<AnimationPage> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    animation = new Tween(begin: 0.0, end: 100.0).animate(controller)
      ..addStatusListener((state) {
        print("state: $state");
        if (state == AnimationStatus.completed) {
          controller.reverse();
        } else if (state == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Animation Page"),
        ),
        body: new Center(
          child: _listView(),
        ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _listView() {
    return new ListView(
      children: <Widget>[
        _animatedLogo(),
        _animatedWidgetMethod(),
        _growTransition(),
      ],
    );
  }

  // need to setState on addListener
  Widget _animatedLogo() {
    animation.addListener(() {
      setState(() {});
    });
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      height: animation.value,
      width: animation.value,
      child: new FlutterLogo(),
    );
  }

  Widget _animatedWidgetMethod() {
    return new AnimatedLogo(
      animation: animation,
    );
  }

  Widget _growTransition() {
    return new GrowTransition(
      child: new LogoWidget(),
      animation: animation,
    );
  }
}

class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Container(
      margin: new EdgeInsets.symmetric(vertical: 10.0),
      height: animation.value,
      width: animation.value,
      child: new FlutterLogo(),
    );
  }
}

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.symmetric(vertical: 10.0),
      child: new FlutterLogo(),
    );
  }
}

class GrowTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  GrowTransition({this.child, this.animation});

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return new Container(
          height: animation.value,
          width: animation.value,
          child: child,
        );
      },
      child: child,
    );
  }
}
