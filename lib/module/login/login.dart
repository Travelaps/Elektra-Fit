import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../global/index.dart';
import '../../widget/index.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  BehaviorSubject<bool> isVisibility$ = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isSaved$ = BehaviorSubject.seeded(false);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final service = GetIt.I<LoginService>();

  void loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email.text = prefs.getString('email') ?? '';
      _password.text = prefs.getString('password') ?? '';
      isSaved$.value = prefs.getBool('rememberMe') ?? false;
    });
  }

  void savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isSaved$.value) {
      prefs.setString('email', _email.text);
      prefs.setString('password', _password.text);
    } else {
      prefs.remove('email');
      prefs.remove('password');
    }
    prefs.setBool('rememberMe', isSaved$.value);
  }

  @override
  void initState() {
    loadPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(scaffoldKey.currentContext!).unfocus();
        },
        child: StreamBuilder(
            stream: Rx.combineLatest3(isVisibility$, isSaved$, isLoading$, (a, b, c) => null),
            builder: (context, snapshot) {
              return Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 10, right: 10, bottom: 10),
                child: isLoading$.value
                    ? Center(child: CircularProgressIndicator(color: config.primaryColor))
                    : Column(children: [
                        Expanded(child: SizedBox(height: H * 0.59, width: W, child: Image.asset("assets/image/start4.png", fit: BoxFit.cover))),
                        CTextFormField(_email, "Email".tr(), prefixIcon: const Icon(Icons.email)),
                        SizedBox(height: W / 40),
                        CTextFormField(_password, "Password".tr(),
                            obscureText: isVisibility$.value,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            prefixIcon: Icon(Icons.lock, color: Colors.black87),
                            suffixIconColor: Colors.black87,
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
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              focusColor: Colors.black,
                              activeColor: config.primaryColor,
                              hoverColor: Colors.red,
                              value: isSaved$.value,
                              onChanged: (value) {
                                isSaved$.add(!isSaved$.value);
                              }
                            ),
                            Text("Remember me".tr(), style: kProxima16)
                          ]
                        ),
                        SizedBox(height: W / 70),
                        CButton(
                          title: "Login".tr(),
                          func: () {
                            isLoading$.add(true);
                            try {
                              service.postLogin(_email.text, _password.text).then((value) {
                                isLoading$.add(false);
                                if (value!.result) {
                                  savePreferences();
                                  Navigator.popUntil(context, (route) => route.isFirst);
                                  Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => CTabBar()));
                                } else {
                                  final errorMessage = value.message.contains('Kullanıcı Bulunamadı!') ? 'Kullanıcı Bulunamadı!' : value.message;
                                  kShowBanner(BannerType.ERROR, errorMessage, context);
                                }
                              });
                            } catch (e) {
                              final errorMessage = e.toString().contains('Kullanıcı Bulunamadı!') ? 'Kullanıcı Bulunamadı!' : e.toString();
                              kShowBanner(BannerType.ERROR, errorMessage, context);
                            }
                          },
                          width: W
                        ),
                  SizedBox(height: W / 30),
                      ]),
              );
            }),
      ),
    );
  }
}
