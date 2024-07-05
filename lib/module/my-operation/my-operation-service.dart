import 'package:flutter/material.dart';

class MyOperation extends StatefulWidget {
  const MyOperation({super.key});

  @override
  State<MyOperation> createState() => _MyOperationState();
}

class _MyOperationState extends State<MyOperation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("My Operation".tr())),
      body: Center(
        child: Text("My Operation"),
      ),
    );
  }
}
