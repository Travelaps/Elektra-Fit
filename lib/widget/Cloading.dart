import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget CLoading() {
  return Container(alignment: Alignment.center, height: 200, width: 200, decoration: const BoxDecoration(), child: Lottie.asset("assets/animations/loading2.json", fit: BoxFit.cover, reverse: true));
}

class RouteAnimation {
  static Route createRoute(Widget routePage, double dx, double dy) {
    return PageRouteBuilder(
      reverseTransitionDuration: const Duration(milliseconds: 400),
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (context, animation, secondaryAnimation) => routePage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = Offset(dx, dy);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
