import "dart:ui" as ui;

import 'package:elektra_fit/global/index.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Future<Locale> getDeviceLocale() async {
  return ui.window.locale.languageCode == "tr" ? const Locale("tr") : const Locale("en");
}

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
        children: [
          Lottie.asset('assets/animations/arrow_animation.json', width: 170, height: 170),
          Image.asset('assets/images/cullinan2.png', width: 170, height: 170)
        ],
      ));
    },
  );
}

String getLevelDescription(int? level) {
  String levelName = '';
  switch (level) {
    case 1:
      levelName = 'Beginner'.tr();
      break;
    case 2:
      levelName = 'Intermediate'.tr();
      break;
    case 3:
      levelName = 'Advanced'.tr();
      break;
    case 4:
      levelName = 'Expert'.tr();
      break;
    case 5:
      levelName = 'Professional'.tr();
      break;
    default:
      levelName = '';
  }
  return levelName;
}

Color getLevelDescriptionColor(int? level) {
  Color color = Colors.black;

  switch (level) {
    case 1:
      color = Colors.green;
      break;
    case 2:
      color = Colors.orange;
      break;
    case 3:
      color = Colors.yellow;
      break;
    case 4:
      color = Colors.deepPurple;
      break;
    case 5:
      color = Colors.blue;
      break;
    default:
      color = Colors.grey;
  }

  return color;
}
