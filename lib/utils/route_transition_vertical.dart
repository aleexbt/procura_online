import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SharedZaxisPageTransitionVertical implements CustomTransition {
  static final transitionsBuilder = (
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      SharedAxisTransition(
        transitionType: SharedAxisTransitionType.vertical,
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        child: child,
      );

  @override
  Widget buildTransition(
    BuildContext context,
    Curve curve,
    Alignment alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      transitionsBuilder(context, animation, secondaryAnimation, child);
}
