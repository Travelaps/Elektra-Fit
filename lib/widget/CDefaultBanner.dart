import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class DefaultNotificationBanner {
  final String iconPath;
  final String text;
  final Color color;
  final BuildContext context;
  final int? durationSeconds;

  DefaultNotificationBanner({
    required this.iconPath,
    required this.text,
    required this.color,
    required this.context,
    this.durationSeconds,
  });

  Flushbar show() {
    Flushbar flushbar = Flushbar(
      animationDuration: const Duration(milliseconds: 600),
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP,
      icon: Padding(padding: const EdgeInsets.only(left: 15), child: Image.asset(iconPath)),
      onTap: (flushbar) => flushbar.dismiss(),
      messageText: Padding(
        padding: const EdgeInsets.only(left: 8, right: 9),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      duration: Duration(seconds: durationSeconds == null ? 2 : durationSeconds!),
      backgroundColor: color,
      boxShadows: [
        BoxShadow(color: Colors.black.withOpacity(0.2), offset: Offset(0.0, 2.0), blurRadius: 3.0),
      ],
    )..show(context);
    return flushbar;
  }
}

// Flushbar kShowBanner(BannerType bannerType, String text, BuildContext context, {int? durationSeconds, Function()? onDismissed, Color? color}) {
//   switch (bannerType) {
//     case BannerType.ERROR:
//       return DefaultNotificationBanner(iconPath: 'assets/icon/banner-icon/error.png', text: text, context: context, color: color ?? Colors.red, durationSeconds: durationSeconds).show();
//
//     case BannerType.SUCCESS:
//       return DefaultNotificationBanner(
//         iconPath: 'assets/icon/banner-icon/check.png',
//         text: text,
//         context: context,
//         color: const Color.fromARGB(255, 9, 184, 14),
//         durationSeconds: durationSeconds,
//       ).show();
//
//     case BannerType.MESSAGE:
//       return DefaultNotificationBanner(
//         iconPath: 'assets/icon/banner-icon/info.png',
//         text: text,
//         context: context,
//         color: const Color.fromARGB(255, 50, 101, 225),
//         durationSeconds: durationSeconds,
//       ).show();
//   }
// }
