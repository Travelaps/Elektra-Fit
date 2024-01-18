import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget CLoading() {
  return Container(
      alignment: Alignment.center,
      height: 200,
      width: 200,
      decoration: const BoxDecoration(),
      child: Lottie.asset(
        "assets/animations/loadings.json",
        fit: BoxFit.cover,
        reverse: true,
      ));
}
