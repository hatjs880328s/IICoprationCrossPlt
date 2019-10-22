import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:matcher/matcher.dart';

/// 动画demo页面
class AnimationPage03 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AnimationPageState();
  }

}

class _AnimationPageState extends State<AnimationPage03> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  CurvedAnimation curve;
  bool isForward = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    curve = CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    animation.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Animation Demo'),
        ),
        body: Stack(children: <Widget>[
          ListView(children: <Widget>[
            // Padding(
            //     padding: EdgeInsets.all(5.0),
            //     child: Row(children: <Widget>[
            //       Expanded(
            //           flex: 1, child: Center(child: Text('FadeTransition'))),
            //       Expanded(
            //           flex: 1, child: Center(child: Text('ScaleTransition')))
            //     ])),
            // Row(children: <Widget>[
            //   Expanded(
            //       flex: 1,
            //       child: FadeTransition(
            //           opacity: animation, child: FlutterLogo(size: 100.0))),
            //   Expanded(
            //       flex: 1,
            //       child: ScaleTransition(
            //           scale: animation, child: FlutterLogo(size: 100.0)))
            // ]),
            // Padding(
            //     padding: EdgeInsets.all(5.0),
            //     child: Row(children: <Widget>[
            //       Expanded(
            //           flex: 1,
            //           child: Center(child: Text('RotationTransition'))),
            //       Expanded(
            //           flex: 1, child: Center(child: Text('AnimatedOpacity')))
            //     ])),
            // Row(children: <Widget>[
            //   Expanded(
            //       flex: 1,
            //       child: RotationTransition(
            //           turns: animation, child: FlutterLogo(size: 100.0))),
            //   Expanded(
            //       flex: 1,
            //       child: AnimatedOpacity(
            //           opacity: animation.value,
            //           duration: Duration(milliseconds: 2000),
            //           child: FlutterLogo(size: 100.0)))
            // ]),
            Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(children: <Widget>[
                  // Expanded(
                  //     flex: 1,
                  //     child: Center(child: Text('Transform.translate'))),
                  Expanded(
                      flex: 1, child: Center(child: Text('Transform.rotate')))
                ])),
            Row(children: <Widget>[
              // Expanded(
              //     flex: 1,
              //     child: Transform.translate(
              //         offset: Offset(100.0 * curve.value, 0.0),
              //         child: FlutterLogo(size: 100.0))),
              Expanded(
                  flex: 1,
                  child: Transform.rotate(
                      angle: curve.value * pi, child: FlutterLogo(size: 100.0)))
            ]),
            // Padding(
            //     padding: EdgeInsets.all(5.0),
            //     child: Row(children: <Widget>[
            //       Expanded(
            //           flex: 1, child: Center(child: Text('Transform.scale'))),
            //       Expanded(flex: 1, child: Center(child: Text('Position')))
            //     ])),
            // Row(children: <Widget>[
            //   Expanded(
            //       flex: 1,
            //       child: Transform.scale(
            //           scale: curve.value, child: FlutterLogo(size: 100.0))),
            // ])
          ]),
          // posWid()
        ]),
        floatingActionButton: new FloatingActionButton(
            tooltip: 'Animation',
            child: new Icon(Icons.lightbulb_outline),
            onPressed: () {
              isForward ? controller.reverse() : controller.forward();
              isForward = !isForward;
            }));
  }

  Widget posWid() {
    return Positioned(
        bottom: 16 + 314 * animation.value,
        right: 16 + 84 * animation.value,
        child: Container(child: FlutterLogo(size: 100.0)));
  }
}