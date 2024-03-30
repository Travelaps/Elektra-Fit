import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:elektra_fit/global/index.dart';
import 'package:flutter/material.dart';

import '../../../widget/index.dart';

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

    List<Step> getStepper() => [
          Step(
              state: currentContext$.value > 0 ? StepState.complete : StepState.disabled,
              isActive: currentContext$.value >= 0,
              title: const Text("Tarih"),
              content: selectedDateStep(service: service, W: W),
              subtitle: StreamBuilder(
                  stream: service.selectDateAvailability$.stream,
                  builder: (context, snapshot) {
                    return Text("${DateFormat("dd MMM yyyy").format(service.selectDateAvailability$.value)}", style: kProxima17);
                  })),
          Step(state: currentContext$.value > 1 ? StepState.complete : StepState.disabled, title: const Text("Hizmet"), content: spaInfo(W: W, service: service), isActive: currentContext$.value >= 1),
          Step(
              state: currentContext$.value > 2 ? StepState.complete : StepState.disabled,
              title: const Text("Saat"),
              content: Container(
                width: W,
                child: Wrap(
                  children: service.availabilityHours$.value?.map((e) {
                        return Container(
                          child: Text("${e?.workHours}", style: kMontserrat16),
                        );
                      }).toList() ??
                      [],
                ),
              ),
              isActive: currentContext$.value >= 2)
        ];

    return StreamBuilder(
        stream: currentContext$.stream,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(title: Text("Booking".tr())),
            body: Stepper(
              elevation: 0,
              margin: EdgeInsets.zero,
              controlsBuilder: (context, details) {
                final isLastStep = currentContext$.value == getStepper().length - 1;
                final isFirstStep = currentContext$.value == 0;
                return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  if (!isFirstStep)
                    CButton(
                      title: "Back".tr(),
                      func: () {
                        currentContext$.add(currentContext$.value - 1);
                      },
                    ),
                  CButton(
                      title: isLastStep ? "Finish".tr() : "Continue".tr(),
                      func: () {
                        if (isLastStep) {
                          print('step last');
                        } else {
                          service.availability(service.selectDateAvailability$.value);
                          currentContext$.add(currentContext$.value + 1);
                        }
                      }),
                ]);
              },
              type: StepperType.horizontal,
              steps: getStepper(),
              currentStep: currentContext$.value,
              onStepTapped: (value) => currentContext$.add(value),
            ),
          );
        });
  }
}

class spaInfo extends StatelessWidget {
  const spaInfo({
    super.key,
    required this.W,
    required this.service,
  });

  final double W;
  final ProfileService service;

  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;
    return StreamBuilder(
        stream: service.spaInfo$.stream,
        builder: (context, snapshot) {
          if (service.spaInfo$.value == null) {
            Center(
                child: CircularProgressIndicator(
              color: config.primaryColor,
            ));
          } else if (service.spaInfo$.value!.isEmpty) {
            Center(child: Text("no found", style: kProxima17));
          }
          return Container(
            height: H * 0.6,
            child: ListView.builder(
              itemCount: service.spaInfo$.value?.length,
              itemBuilder: (context, index) {
                var item = service.spaInfo$.value?[index]?.hotelinfos;
                if (item != null) {
                  return Text(item.name ?? "", style: kProxima17);
                }
              },
            ),
          );
        });
  }
}

class selectedDateStep extends StatelessWidget {
  selectedDateStep({
    super.key,
    required this.service,
    required this.W,
  });

  final ProfileService service;
  final double W;
  DateTime? selectedDate;
  final controller = BoardDateTimeController();

  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;

    return StreamBuilder(
        stream: service.selectDateAvailability$.stream,
        builder: (context, snapshot) {
          return SingleChildScrollView(
            child: SizedBox(
              height: H * 0.68,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      final picked = showDatePicker(
                        context: context,
                        firstDate: date,
                        lastDate: DateTime.now().add(Duration(days: 350)),
                      );
                      if (picked != selectedDate) {
                        service.selectDateAvailability$.add(selectedDate!);
                      }
                    },
                    child: Row(
                      children: [
                        Icon(Icons.date_range_outlined),
                        Text(service.selectDateAvailability$.value != null ? DateFormat("dd MMM yyyy").format(service.selectDateAvailability$.value) : "Lutfen Tarih Seçiniz", style: kProxima17)
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
