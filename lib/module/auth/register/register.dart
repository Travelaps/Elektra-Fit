import 'package:elektra_fit/global/global-variables.dart';
import 'package:elektra_fit/module/auth/login/login.dart';
import 'package:elektra_fit/widget/CButton.dart';
import 'package:elektra_fit/widget/CTextFromField.dart';
import 'package:elektra_fit/widget/tabBar.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _name = TextEditingController();
  TextEditingController _surname = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  BehaviorSubject<bool> isChecked$ = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isVisibility$ = BehaviorSubject.seeded(false);
  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return Scaffold(
      body: StreamBuilder(
          stream: Rx.combineLatest2(isVisibility$, isChecked$, (a, b) => null),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 10, right: 10, bottom: 10),
                child: Column(
                  children: [
                    SizedBox(height: W / 2),
                    Text("Create an Account", style: kMontserrat20),
                    CTextFormField(_name, "Name", prefixIcon: Icon(Icons.person)),
                    SizedBox(height: W / 40),
                    CTextFormField(_surname, "Surname", prefixIcon: Icon(Icons.person)),
                    SizedBox(height: W / 40),
                    CTextFormField(_email, "Email", prefixIcon: Icon(Icons.mail)),
                    SizedBox(height: W / 40),
                    CTextFormField(_phone, "Phone", prefixIcon: Icon(Icons.phone)),
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
                    Container(
                      width: W,
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Checkbox(
                            onChanged: (value) {
                              isChecked$.add(value!);
                            },
                            value: isChecked$.value,
                            activeColor: config.primaryColor,
                            checkColor: Colors.black87,
                          ),
                          Flexible(
                            child: Text(
                              'By continuing you accept our Privacy Policy and Term of Use',
                              style: kProxima16,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: W / 40),
                    CButton(
                      width: W,
                      title: "Register",
                      func: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CTabBar()));
                      },
                    ),
                    SizedBox(height: W / 40),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account",
                            style: kProxima16,
                          ),
                          SizedBox(width: W / 60),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                            },
                            child: Text(
                              "Log in",
                              style: kProxima16.copyWith(color: config.primaryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
