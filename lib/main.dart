import 'package:elektra_fit/module/auth/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'global/global-variables.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: isDarkMode$.stream,
      builder: (context, snapshot) {
        return MaterialApp(
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
                systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.black87)),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            iconTheme: const IconThemeData(color: Colors.white),
            appBarTheme: AppBarTheme(
                iconTheme: const IconThemeData(color: Colors.white),
                color: config.primaryColor,
                titleTextStyle: const TextStyle(fontFamily: 'Axiforma', fontSize: 18),
                elevation: 0,
                centerTitle: true,
                toolbarHeight: 50,
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
      },
    );
  }
}
