import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget CLoading() {
  return Container(
      alignment: Alignment.center,
      height: 50,
      width: 50,
      decoration: const BoxDecoration(),
      child: Lottie.asset(
        "assets/animation/loading.json",
        fit: BoxFit.cover,
        reverse: true,
      ));
}
