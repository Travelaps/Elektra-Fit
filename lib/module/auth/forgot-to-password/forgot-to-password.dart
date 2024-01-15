import 'package:elektra_fit/global/global-variables.dart';
import 'package:elektra_fit/widget/CButton.dart';
import 'package:elektra_fit/widget/CTextFromField.dart';
import 'package:flutter/material.dart';

class ForgotToPassword extends StatefulWidget {
  const ForgotToPassword({Key? key}) : super(key: key);

  @override
  State<ForgotToPassword> createState() => _ForgotToPasswordState();
}

class _ForgotToPasswordState extends State<ForgotToPassword> {
  TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double H = MediaQuery.of(context).size.height;
    double W = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 10, right: 10, bottom: 10),
        width: W,
        height: H,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              isDarkMode$.value ? Colors.black.withOpacity(0.3) : Colors.white70.withOpacity(0.2),
              BlendMode.overlay,
            ),
            image: AssetImage("assets/image/started.png"),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Expanded(child: Container()),
            SizedBox(height: W * 1.4),
            Text("Reset to password", style: kMontserrat18.copyWith(color: Colors.white)),
            SizedBox(height: W / 30),
            CTextFormField(_email, "Email"),
            SizedBox(height: W / 30),
            CButton(title: "Reset", func: () {}, width: W),
            SizedBox(height: W / 30),
          ],
        ),
      )),
    );
  }
}
