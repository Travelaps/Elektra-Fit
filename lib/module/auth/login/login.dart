import 'package:elektra_fit/global/global-variables.dart';
import 'package:elektra_fit/module/auth/register/register.dart';
import 'package:elektra_fit/widget/CButton.dart';
import 'package:elektra_fit/widget/CTextFromField.dart';
import 'package:elektra_fit/widget/tabBar.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  BehaviorSubject<bool> isVisibility$ = BehaviorSubject.seeded(false);
  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return Scaffold(
      body: StreamBuilder(
          stream: isVisibility$.stream,
          builder: (context, snapshot) {
            return Container(
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
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 10, right: 10, bottom: 10),
                child: Column(
                  children: [
                    Expanded(flex: 7, child: Container()),
                    CTextFormField(_email, "Email", prefixIcon: Icon(Icons.email)),
                    SizedBox(height: W / 40),
                    CTextFormField(_password, "Password",
                        obscureText: isVisibility$.value,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        prefixIcon: Icon(Icons.lock, color: isDarkMode$.value ? Colors.white : Colors.black),
                        suffixIconColor: isDarkMode$.value ? Colors.white : Colors.black,
                        onchange: (value) {
                          _password.text = value;
                        },
                        suffixIcon: IconButton(
                            onPressed: () {
                              isVisibility$.add(!isVisibility$.value);
                            },
                            icon: isVisibility$.value ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility)),
                        validator: (value) {
                          if (value!.isEmpty) return _password.text;
                          return null;
                        }),
                    SizedBox(height: W / 40),
                    CButton(
                        title: "Login",
                        func: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CTabBar()));
                        },
                        width: W),
                    SizedBox(height: W / 40),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Don't have an account ?",
                            style: kProxima16.copyWith(color: Colors.white),
                          ),
                          SizedBox(width: W / 40),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Register(),
                                  ));
                            },
                            child: Text(
                              "Sign Up",
                              style: kAxiforma19.copyWith(color: config.primaryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: W / 10),
                    // Expanded(child: Container()),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
