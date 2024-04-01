import 'package:elektra_fit/global/index.dart';
import 'package:flutter/material.dart';

class Reservation extends StatefulWidget {
  const Reservation({super.key});

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  final service = GetIt.I<ProfileService>();
  BehaviorSubject<int> currentContext$ = BehaviorSubject.seeded(0);

  @override
  void initState() {
    service.spaInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(title: Text("Booking".tr())),
        body: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  padding: paddingAll10,
                  margin: marginAll5,
                  decoration: BoxDecoration(border: borderAll, borderRadius: borderRadius10),
                  child: Row(
                    children: [
                      Icon(Icons.date_range_outlined, size: W / 15),
                      Text(service.selectDateAvailability$.value == null ? "No date selected" : DateFormat("dd MMM yyyy").format(service.selectDateAvailability$.value!), style: kProxima17),
                    ],
                  ),
                ),
              ),
              // StreamBuilder(
              //     stream: service.spainfos$,
              //     builder: (context, snapshot) {
              //       if (service.spainfos$.value == null) {
              //         return Center(child: CircularProgressIndicator(color: Colors.red));
              //       } else if (service.spainfos$.value?.length == 0) {
              //         return Center(child: Text("no found"));
              //       }
              //       return Container(
              //         child: Wrap(
              //           children: service.spainfos$.value!.map((e) {
              //             return Container(
              //               child: ListView.builder(
              //                 itemCount: e!.length,
              //                 itemBuilder: (context, index) {},
              //               ),
              //             );
              //           }).toList(),
              //         ),
              //       );
              //     })
            ],
          ),
        ));
  }
}
