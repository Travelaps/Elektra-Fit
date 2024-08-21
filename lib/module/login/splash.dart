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
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(milliseconds: 500), () {

      setState(() {
        _visible = true;
      });
    });

    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(context, RouteAnimation.createRoute(const Login(), 0, 1));
    });
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
          gradient: LinearGradient(
            colors: [
              // config.primaryColor,
              // config.primaryColor.withOpacity(0.8),
              config.primaryColor.withOpacity(0.6),
              config.primaryColor.withOpacity(0.4),
              config.primaryColor.withOpacity(0.2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Stack(
          children: [
            Center(
                child: AnimatedOpacity(
                    opacity: _visible ? 1.0 : 0.0,
                    duration: Duration(seconds: 1),
                    child: Image.asset("assets/image/start-logo.png", fit: BoxFit.contain))),
            Positioned(
              bottom: 50.0,
              left: 0,
              right: 0,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
