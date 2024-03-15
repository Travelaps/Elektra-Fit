import 'package:easy_localization/easy_localization.dart';
import 'package:elektra_fit/module/profile/profile-service.dart';
import 'package:elektra_fit/widget/Cloading.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Measurements extends StatefulWidget {
  const Measurements({super.key});

  @override
  State<Measurements> createState() => _MeasurementsState();
}

class _MeasurementsState extends State<Measurements> {
  final service = GetIt.I<ProfileService>();

  @override
  void initState() {
    service.spaMemberBodyAnality();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("My Measurements".tr()),
      ),
      body: SingleChildScrollView(
          child: StreamBuilder(
              stream: service.spaMemberBody$.stream,
              builder: (context, snapshot) {
                if (service.spaMemberBody$.value == null) {
                  return Center(child: CLoading());
                } else if (service.spaMemberBody$.value!.isEmpty) {
                  return Center(child: Text("asdas"));
                }

                return Container(
                  color: Colors.red,
                  width: W,
                  height: W / 3,
                );
              })),
    );
  }
}
