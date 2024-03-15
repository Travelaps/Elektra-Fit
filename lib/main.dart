import 'package:easy_localization/easy_localization.dart';
import 'package:elektra_fit/module/auth/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'global/global-variables.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(supportedLocales: [Locale('tr'), Locale('en')], path: 'assets/translations', fallbackLocale: const Locale('en'), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        brightness: Brightness.light,
        iconTheme: const IconThemeData(color: Colors.black87),
        appBarTheme: AppBarTheme(
            iconTheme: const IconThemeData(color: Colors.white),
            color: config.primaryColor,
            titleTextStyle: const TextStyle(fontFamily: 'Axiforma', fontSize: 18),
            elevation: 0,
            toolbarHeight: 50,
            centerTitle: true,
            systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.white)),
      ),
      themeMode: isDarkMode$.value ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
        return child!;
      },
      home: Login(),
    );
  }
}
