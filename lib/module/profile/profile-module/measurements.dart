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
      appBar: AppBar(title: Text("My Measurements".tr())),
      body: StreamBuilder(
          stream: service.spaMemberBody$.stream,
          builder: (context, snapshot) {
            if (service.spaMemberBody$.value == null) {
              return Center(child: CircularProgressIndicator(color: config.primaryColor));
            } else if (service.spaMemberBody$.value!.isEmpty) {
              return Center(child: Text("User has no measurement records", style: kProxima17));
            }
            return SizedBox(
                height: H * 0.86,
                width: W,
                child: ListView.builder(
                  itemCount: service.spaMemberBody$.value?.length,
                  itemBuilder: (context, index) {
                    var item = service.spaMemberBody$.value?[index];

                    return Container(
                      padding: paddingAll10,
                      margin: marginAll5,
                      decoration: BoxDecoration(borderRadius: borderRadius10, color: Colors.white, boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.6), spreadRadius: 3, blurRadius: 10, offset: Offset(0, 3)),
                      ]),
                      child: Column(
                        children: [
                          IntrinsicHeight(
                              child: Row(children: [
                            if (item?.height != null && item?.height != 0.0)
                              Expanded(
                                  child: Column(
                                children: [Text("Height".tr(), style: kMontserrat16), Text("${item?.height} cm", style: kProxima17)],
                              )),
                            if (item?.weight != null) VerticalDivider(),
                            if (item?.weight != null && item?.weight != 0.0)
                              Expanded(
                                  child: Column(
                                children: [Text("Weight".tr(), style: kMontserrat16), Text("${item?.weight} kg", style: kProxima17)],
                              ))
                          ])),
                          if (item?.age != null && item?.chest != null) Divider(),
                          IntrinsicHeight(
                              child: Row(children: [
                            if (item?.age != null)
                              Expanded(
                                  child: Column(
                                children: [Text("Age".tr(), style: kMontserrat16), Text("${item?.age}", style: kProxima17)],
                              )),
                            if (item?.chest != null) VerticalDivider(),
                            if (item?.chest != null)
                              Expanded(
                                  child: Column(
                                children: [Text("Chest".tr(), style: kMontserrat16), Text("${item?.waist} cm", style: kProxima17)],
                              ))
                          ])),
                          if (item?.thigh != null && item?.hips != null) Divider(),
                          IntrinsicHeight(
                              child: Row(children: [
                            if (item?.thigh != null)
                              Expanded(
                                  child: Column(
                                children: [Text("Thigh".tr(), style: kMontserrat16), Text("${item?.thigh} cm", style: kProxima17)],
                              )),
                            if (item?.hips != null) VerticalDivider(),
                            if (item?.hips != null)
                              Expanded(
                                  child: Column(
                                children: [Text("Hips".tr(), style: kMontserrat16), Text("${item?.hips} cm", style: kProxima17)],
                              ))
                          ])),
                          if (item?.calf != null && item?.waist != null) Divider(),
                          IntrinsicHeight(
                              child: Row(children: [
                            if (item?.calf != null)
                              Expanded(
                                  child: Column(
                                children: [Text("Calf".tr(), style: kMontserrat16), Text("${item?.calf} cm", style: kProxima17)],
                              )),
                            if (item?.waist != null) VerticalDivider(),
                            if (item?.waist != null)
                              Expanded(
                                  child: Column(
                                children: [Text("Waist".tr(), style: kMontserrat16), Text("${item?.waist} cm", style: kProxima17)],
                              ))
                          ])),
                          if (item?.arm != null) Divider(),
                          if (item?.arm != null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text("Arm".tr(), style: kMontserrat16), Text("${item!.calf} cm", style: kProxima17)],
                            ),
                          if (item?.totalBodyWater != null) Divider(),
                          if (item?.totalBodyWater != null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text("Total Body Water".tr(), style: kMontserrat16), Text("% ${item!.totalBodyWater}", style: kProxima17)],
                            ),
                          if (item?.totalMuscleMass != null) Divider(),
                          if (item?.totalMuscleMass != null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text("Total Muscle Mass".tr(), style: kMontserrat16), Text("% ${item!.totalMuscleMass}", style: kProxima17)],
                            ),
                          if (item?.totalBodyFatMass != null) Divider(),
                          if (item?.totalBodyFatMass != null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total Body Fat Mass".tr(), style: kMontserrat16),
                                Text("% ${item!.totalBodyFatMass}", style: kProxima17)
                              ],
                            ),
                          if (item?.bodyMassIndex != null) Divider(),
                          if (item?.bodyMassIndex != null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text("Body Mass Index".tr(), style: kMontserrat16), Text("% ${item!.bodyMassIndex}", style: kProxima17)],
                            ),
                          if (item?.lastUpdateDate != null) Divider(),
                          if (item?.lastUpdateDate != null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Last Updated Date".tr(), style: kMontserrat16),
                                Text(DateFormat("dd MMM yyyy").format(item!.lastUpdateDate!), style: kProxima17)
                              ],
                            ),
                        ],
                      ),
                    );
// Column(
//                         children: [
//                           IntrinsicHeight(
//                               child: Row(children: [
//                             if (item?.height != null && item?.height != 0.0)
//                               Expanded(
//                                   child: Column(
//                                 children: [Text("Height".tr(), style: kProxima17), Text("${item?.height} cm", style: kProxima17)],
//                               )),
//                             if (item?.weight != null) VerticalDivider(),
//                             if (item?.weight != null && item?.weight != 0.0)
//                               Expanded(
//                                   child: Column(
//                                 children: [Text("Weight".tr(), style: kProxima17), Text("${item?.weight} kg", style: kProxima17)],
//                               ))
//                           ])),
//                           if (item?.totalBodyWater != null) Divider(),
//                           if (item?.age != null)
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [Text("Age".tr(), style: kProxima17), Text(item!.age.toString(), style: kProxima17)],
//                             ),
//                           if (item?.chest != null) Divider(),
//                           if (item?.chest != null)
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [Text("Chest".tr(), style: kProxima17), Text("${item!.chest} cm", style: kProxima17)],
//                             ),
//                           if (item?.thigh != null) Divider(),
//                           if (item?.thigh != null)
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [Text("Thigh".tr(), style: kProxima17), Text("${item!.thigh} cm", style: kProxima17)],
//                             ),
//                           if (item?.hips != null) Divider(),
//                           if (item?.hips != null)
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [Text("Hips".tr(), style: kProxima17), Text("${item!.hips} cm", style: kProxima17)],
//                             ),
//                           if (item?.calf != null) Divider(),
//                           if (item?.calf != null)
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [Text("Calf".tr(), style: kProxima17), Text("${item!.calf} cm", style: kProxima17)],
//                             ),
//                           if (item?.waist != null) Divider(),
//                           if (item?.waist != null)
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [Text("Waist".tr(), style: kProxima17), Text("${item!.calf} cm", style: kProxima17)],
//                             ),
//                           if (item?.arm != null) Divider(),
//                           if (item?.arm != null)
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [Text("Arm".tr(), style: kProxima17), Text("${item!.calf} cm", style: kProxima17)],
//                             ),
//                           if (item?.totalBodyWater != null) Divider(),
//                           if (item?.totalBodyWater != null)
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [Text("Total Body Water".tr(), style: kProxima17), Text("% ${item!.totalBodyWater}", style: kProxima17)],
//                             ),
//                           if (item?.totalMuscleMass != null) Divider(),
//                           if (item?.totalMuscleMass != null)
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [Text("Total Muscle Mass".tr(), style: kProxima17), Text("% ${item!.totalMuscleMass}", style: kProxima17)],
//                             ),
//                           if (item?.totalBodyFatMass != null) Divider(),
//                           if (item?.totalBodyFatMass != null)
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [Text("Total Body Fat Mass".tr(), style: kProxima17), Text("% ${item!.totalBodyFatMass}", style: kProxima17)],
//                             ),
//                           if (item?.bodyMassIndex != null) Divider(),
//                           if (item?.bodyMassIndex != null)
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [Text("Body Mass Index".tr(), style: kProxima17), Text("% ${item!.bodyMassIndex}", style: kProxima17)],
//                             ),
//                           if (item?.lastUpdateDate != null) Divider(),
//                           if (item?.lastUpdateDate != null)
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [Text("Last Updated Date".tr(), style: kProxima17), Text(DateFormat("MMM dd yyyy").format(item!.lastUpdateDate!), style: kProxima17)],
//                             ),
//                         ],
//                       ),
                  },
                ));
          }),
    );
  }

  Container itemMeasurement(String? item, String text) {
    return Container(
      margin: marginAll5,
      padding: paddingAll10,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.6), spreadRadius: 3, blurRadius: 10, offset: Offset(0, 3))]),
      child: Column(
        children: [Text(text, style: kMontserrat18), Text(item!, style: kProxima17)],
      ),
    );
  }
}
