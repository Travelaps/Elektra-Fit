import 'package:flutter/material.dart';

class MemberType extends StatefulWidget {
  const MemberType({Key? key}) : super(key: key);

  @override
  State<MemberType> createState() => _MemberTypeState();
}

class _MemberTypeState extends State<MemberType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Member Types")),
      body: SingleChildScrollView(
        child: Column(children: []),
      ),
    );
  }
}
