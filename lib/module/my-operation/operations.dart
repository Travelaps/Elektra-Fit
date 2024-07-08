import 'package:elektra_fit/global/index.dart';
import 'package:flutter/material.dart';

class MyOperations extends StatefulWidget {
  const MyOperations({super.key});

  @override
  State<MyOperations> createState() => _MyOperationsState();
}

class _MyOperationsState extends State<MyOperations> {
  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(title: Text("My Operations".tr()), actions: [
          Padding(
              padding: paddingAll10,
              child: InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MyOperationDetail())),
                  child: Icon(Icons.menu, color: Colors.white, size: W / 14)))
        ]),
        body: const Reservation());
  }
}
