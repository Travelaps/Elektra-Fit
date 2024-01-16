import 'package:flutter/material.dart';

import '../global/enum/banner-enum.dart';

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

  void show() {
    // Burada Flushbar kullanımı yerine istediğiniz başka bir widget veya işlevi çağırabilirsiniz.
    // Örneğin:
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => YourCustomScreen()));

    // veya

    // yourCustomFunction();
  }
}

void kShowBanner(BannerType bannerType, String text, BuildContext context, {int? durationSeconds, Function()? onDismissed, Color? color}) {
  switch (bannerType) {
    case BannerType.ERROR:
      return DefaultNotificationBanner(
        iconPath: 'assets/icon/banner-icon/error.png',
        text: text,
        context: context,
        color: color ?? Colors.red,
        durationSeconds: durationSeconds,
      ).show();

    case BannerType.SUCCESS:
      return DefaultNotificationBanner(
        iconPath: 'assets/icon/banner-icon/check.png',
        text: text,
        context: context,
        color: Color.fromARGB(255, 9, 184, 14),
        durationSeconds: durationSeconds,
      ).show();

    case BannerType.MESSAGE:
      return DefaultNotificationBanner(
        iconPath: 'assets/icon/banner-icon/info.png',
        text: text,
        context: context,
        color: Color.fromARGB(255, 50, 101, 225),
        durationSeconds: durationSeconds,
      ).show();
  }
}
