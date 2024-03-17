import 'package:flutter/material.dart';

import '../../../global/index.dart';

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
                  return Center(child: CircularProgressIndicator(color: config.primaryColor));
                } else if (service.spaMemberBody$.value!.isEmpty) {
                  return const Center(child: Text(" no found measurements"));
                }
                return SizedBox(
                    height: H * 0.89,
                    width: W,
                    child: ListView.builder(
                      itemCount: service.spaMemberBody$.value?.length,
                      itemBuilder: (context, index) {
                        var item = service.spaMemberBody$.value?[index];

                        return Column(
                          children: [
                            Wrap(children: [
                              if (item!.weight != null) itemMeasurement(item.age.toString(), "Age"),
                              if (item.weight != null) itemMeasurement("${item.height.toString()} cm", "Height"),
                              if (item.weight != null) itemMeasurement("${item.weight.toString()} kg", "Weight"),
                              if (item.arm != null) itemMeasurement("${item.arm.toString()} cm ", "Arm"),
                              if (item.calf != null) itemMeasurement("${item.calf.toString()} cm", "Calf"),
                              if (item.hips != null) itemMeasurement("${item.hips.toString()} cm", "Hips"),
                              if (item.thigh != null) itemMeasurement("${item.thigh.toString()} cm", "Thigh"),
                              if (item.totalBodyFatMass != null) itemMeasurement("${item.totalBodyFatMass.toString()} kg", "Total Body Fat Mass"),
                              if (item.totalBodyWater != null) itemMeasurement("${item.totalBodyWater.toString()} L", "Total Body Water"),
                              if (item.totalMuscleMass != null) itemMeasurement("${item.totalMuscleMass.toString()} kg", "Total Muscle Mass"),
                              if (item.lastUpdateDate != null) itemMeasurement(DateFormat("dd MMM").format(item.lastUpdateDate!), "Last Update Date"),
                            ]),
                            Divider()
                          ],
                        );
                      },
                    ));
              })),
    );
  }

  Container itemMeasurement(String? item, String text) {
    return Container(
      margin: marginAll5,
      padding: paddingAll10,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.6), spreadRadius: 3, blurRadius: 10, offset: Offset(0, 3))]),
      child: Column(
        children: [
          Text(text, style: kMontserrat18),
          Text(item!, style: kProxima17),
        ],
      ),
    );
  }
}
