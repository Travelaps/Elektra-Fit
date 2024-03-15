import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Future<T> showAnimation<T>(BuildContext context, Future<T> func) async {
  return await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      func.then((v) {
        Navigator.pop(context, v);
      });

      return Center(
          child: Stack(
        alignment: Alignment.center,
        children: [Lottie.asset('assets/animations/arrow_animation.json', width: 170, height: 170), Image.asset('assets/images/cullinan2.png', width: 170, height: 170)],
      ));
    },
  );
}
