import 'package:flutter/material.dart';

class ForgotToPassword extends StatefulWidget {
  const ForgotToPassword({Key? key}) : super(key: key);

  @override
  State<ForgotToPassword> createState() => _ForgotToPasswordState();
}

class _ForgotToPasswordState extends State<ForgotToPassword> {
  TextEditingController _email = TextEditingController();
asda
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Text("Reset to password"),
          CTextFormField(_email, "Email"),
          CButton(title: "Reset", func: () {}),
        ],
      )),
    );
  }
}
