import 'package:flutter/material.dart';

import '../widget/index.dart';
import 'index.dart';

kShowBanner(BannerType bannerType, String text, BuildContext context, {int? durationSeconds, Function()? onDismissed, Color? color}) {
  switch (bannerType) {
    case BannerType.ERROR:
      return DefaultNotificationBanner(iconPath: 'assets/icon/banner-icon/error.png', text: text, context: context, color: color ?? Colors.red, durationSeconds: durationSeconds).show();
    case BannerType.SUCCESS:
      return DefaultNotificationBanner(iconPath: 'assets/icon/banner-icon/check.png', text: text, context: context, color: Color.fromARGB(255, 9, 184, 14), durationSeconds: durationSeconds).show();
    case BannerType.MESSAGE:
      return DefaultNotificationBanner(iconPath: 'assets/icon/banner-icon/info.png', text: text, context: context, color: Color.fromARGB(255, 50, 101, 225), durationSeconds: durationSeconds).show();
  }
}
