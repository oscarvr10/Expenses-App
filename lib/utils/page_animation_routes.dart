import 'package:flutter/material.dart';

class PageAnimationRoutes extends PageRouteBuilder {
  final Widget widget;
  final double axisX;
  final double axisY;
  final Curve curveAnimation;

  PageAnimationRoutes(
      {required this.widget,
      required this.axisX,
      required this.axisY,
      required this.curveAnimation})
      : super(
          transitionDuration: const Duration(milliseconds: 600),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondAnimation,
              Widget child) {
            animation =
                CurvedAnimation(parent: animation, curve: curveAnimation);
            return ScaleTransition(
              alignment: Alignment(axisX, axisY),
              scale: animation,
              child: child,
            );
          },
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondAnimation) {
            return widget;
          },
        );
}
