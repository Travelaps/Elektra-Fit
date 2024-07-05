import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
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
  BehaviorSubject<bool> isLoading$ = BehaviorSubject.seeded(false);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final service = GetIt.I<LoginService>();

  void loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email.text = prefs.getString('email') ?? '';
      _password.text = prefs.getString('password') ?? '';
      isSaved$.add(prefs.getBool('rememberMe') ?? false);
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
    _email.text = "ozkantur@gmail.com";
    _password.text = "ozkan123";
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
              return Container(
                padding: paddingAll10,
                child: Column(children: [
                  Expanded(child: SizedBox(height: H * 0.40, width: W, child: Image.asset("assets/image/start-logo.png", fit: BoxFit.contain))),
                  CTextFormField(
                    _email,
                    "Email".tr(),
                    prefixIcon: const Icon(Icons.email),
                    onchange: (value) {
                      _email.text = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your Email.'.tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: W / 40),
                  CTextFormField(_password, "Password".tr(),
                      obscureText: !isVisibility$.value,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      prefixIcon: const Icon(Icons.lock, color: Colors.black87),
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
                        if (value.isEmpty) {
                          return 'Please enter your Password.'.tr();
                        }
                        return null;
                      }),
                  SizedBox(height: W / 40),
                  Row(children: [
                    Checkbox(
                        checkColor: Colors.white,
                        focusColor: Colors.black,
                        activeColor: config.primaryColor,
                        hoverColor: Colors.red,
                        value: isSaved$.value,
                        onChanged: (value) {
                          isSaved$.add(value!);
                          savePreferences();
                        }),
                    Text("Remember me".tr(), style: kProxima16)
                  ]),
                  SizedBox(height: W / 70),
                  isLoading$.value
                      ? Center(child: CircularProgressIndicator(color: config.primaryColor))
                      : CButton(
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
                          isLoading$.add(false);
                          final errorMessage = e.toString().contains('Kullanıcı Bulunamadı!') ? 'Kullanıcı Bulunamadı!' : e.toString();
                          kShowBanner(BannerType.ERROR, errorMessage, context);
                        }
                      },
                      width: W),
                  SizedBox(height: W / 10),
                ]),
              );
            }),
      ),
    );
  }
}
