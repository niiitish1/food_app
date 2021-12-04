import 'package:flutter/material.dart';

class FadeInRoute extends PageRouteBuilder {
  final Widget page;
  FadeInRoute({required this.page, String? routeName})
      : super(
            settings: RouteSettings(name: routeName),
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                page,
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animaton,
              Animation<double> secondaryAnimation,
              Widget child,
            ) =>
                FadeTransition(
                  opacity: animaton,
                  child: child,
                ),
            transitionDuration: Duration(seconds: 1));
}
