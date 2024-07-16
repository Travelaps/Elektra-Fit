import 'dart:ui' as ui;

import 'package:elektra_fit/module/login/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'global/index.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final Locale deviceLocale = await getDeviceLocale();
  GetIt.I.registerSingleton<LoginService>(LoginService());
  GetIt.I.registerSingleton<HomeService>(HomeService());
  GetIt.I.registerSingleton<ProfileService>(ProfileService());
  GetIt.I.registerSingleton<MyOperationsService>(MyOperationsService());
  runApp(
    EasyLocalization(
        startLocale: deviceLocale,
        supportedLocales: [Locale('tr'), Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('tr'),
        child: MyApp()),
  );
}

Future<Locale> getDeviceLocale() async {
  return ui.window.locale.languageCode == "tr" ? const Locale("tr") : const Locale("en");
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      themeAnimationStyle: AnimationStyle(duration: const Duration(seconds: 1)),
      theme: ThemeData(
        brightness: Brightness.light,
        iconTheme: const IconThemeData(color: Colors.black87),
        appBarTheme: AppBarTheme(
            iconTheme: const IconThemeData(color: Colors.white),
            color: config.primaryColor,
            titleTextStyle: kAxiforma18,
            elevation: 0,
            toolbarHeight: 50,
            centerTitle: true,
            systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.black87)),
      ),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle().copyWith(statusBarColor: Colors.black));
        return child!;
      },
      home: SplashScreen(),
    );
  }
}
