import 'package:elektra_fit/global/global-variables.dart';
import 'package:elektra_fit/widget/CButton.dart';
import 'package:elektra_fit/widget/CTextFromField.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _name = TextEditingController();
  TextEditingController _surname = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profle"),
      ),
      body: SingleChildScrollView(
          child: Container(
        height: H * 0.84,
        padding: paddingAll10,
        child: Column(
          children: [
            SizedBox(height: W / 10),
            Container(alignment: Alignment.center, child: SizedBox(height: W / 3, width: W / 3, child: Image.asset("assets/image/profile-image.png"))),
            SizedBox(height: W / 10),
            CTextFormField(_name, "Name"),
            SizedBox(height: W / 30),
            CTextFormField(_surname, "Surname"),
            SizedBox(height: W / 30),
            CTextFormField(_email, "Email"),
            SizedBox(height: W / 30),
            CTextFormField(_phone, "Phone"),
            SizedBox(height: W / 30),
            CTextFormField(_password, "Password"),
            SizedBox(height: W / 30),
            Spacer(),
            CButton(
              width: W,
              title: "Save Changed",
              func: () {},
            )
          ],
        ),
      )),
    );
  }
}
