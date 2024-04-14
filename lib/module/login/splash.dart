import 'package:elektra_fit/global/index.dart';
import 'package:elektra_fit/widget/Cloading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(context, RouteAnimation.createRoute(Login(), 0, 1));
    });
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [config.primaryColor, config.buttonSecondColor], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Image.asset("assets/image/start-logo.png", fit: BoxFit.contain),
      ),
    );
  }
}
