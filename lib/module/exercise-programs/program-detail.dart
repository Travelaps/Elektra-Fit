import 'dart:async';

import 'package:flutter/material.dart';

import '../../global/index.dart';

class SportDetails extends StatefulWidget {
  const SportDetails({Key? key}) : super(key: key);

  @override
  State<SportDetails> createState() => _SportDetailsState();
}

class _SportDetailsState extends State<SportDetails> {
  List<BehaviorSubject<Duration>> durations = [];
  final BehaviorSubject<Duration> totalDuration$ = BehaviorSubject<Duration>.seeded(Duration.zero);
  final BehaviorSubject<int> currentExerciseIndex$ = BehaviorSubject.seeded(-1);
  final BehaviorSubject<bool> isRunning$ = BehaviorSubject.seeded(false);
  Stopwatch stopwatch = Stopwatch();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Her hareket için ayrı süre takibi yapıyoruz
    for (int i = 0; i < member$.value!.first.program.length; i++) {
      durations.add(BehaviorSubject<Duration>.seeded(Duration.zero));
    }
  }

  void _startTimer(int index) {
    // Eğer başka bir egzersiz başlatılıyorsa, süreyi sıfırla
    if (currentExerciseIndex$.value != index) {
      stopwatch.reset();
      durations[index].add(Duration.zero);
      currentExerciseIndex$.add(index);
    }

    // Zamanlayıcıyı başlat
    stopwatch.start();
    isRunning$.add(true);
    _updateDuration(index);
  }

  void _updateDuration(int index) {
    _timer?.cancel(); // Daha önceki bir zamanlayıcıyı iptal edin
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!stopwatch.isRunning) {
        timer.cancel();
      } else {
        final duration = stopwatch.elapsed;
        durations[index].add(duration);

        final total = durations.map((subject) => subject.value).reduce((a, b) => a + b);
        totalDuration$.add(total);
      }
    });
  }

  void _pauseTimer() {
    if (stopwatch.isRunning) {
      stopwatch.stop();
      isRunning$.add(false);
    }
  }

  void _stopTimer(int index) {
    if (stopwatch.isRunning) {
      stopwatch.stop();
      durations[index].add(stopwatch.elapsed);
      final total = durations.map((subject) => subject.value).reduce((a, b) => a + b);
      totalDuration$.add(total);
      isRunning$.add(false);
      if (index < durations.length - 1) {
        currentExerciseIndex$.add(index + 1);
      } else {
        currentExerciseIndex$.add(-1);
      }
    }
  }

  @override
  void dispose() {
    for (var subject in durations) {
      subject.close();
    }
    totalDuration$.close();
    currentExerciseIndex$.close();
    isRunning$.close();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double H = MediaQuery.of(context).size.height;
    final double W = MediaQuery.of(context).size.width;

    return StreamBuilder(
      stream: member$.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || member$.value == null) {
          return Center(child: CircularProgressIndicator(color: config.primaryColor));
        }

        return StreamBuilder(
            stream: Rx.combineLatest2(totalDuration$, isRunning$, (a, b) => null),
            builder: (context, snapshot) {
              final totalDuration = totalDuration$.value ?? Duration.zero;

              return Scaffold(
                appBar: AppBar(title: Text("My Program".tr()), actions: [
                  Padding(
                      padding: paddingAll8,
                      child: Text("${totalDuration.inMinutes}:${(totalDuration.inSeconds % 60).toString().padLeft(2, '0')}",
                          style: kMontserrat18.copyWith(color: Colors.white))),
                ]),
                body: SingleChildScrollView(
                  child: Column(
                    children: member$.value!.map((e) {
                      var program = e.program;
                      return SizedBox(
                        height: H * 0.9,
                        child: ListView.builder(
                          itemCount: program.length,
                          itemBuilder: (context, index) {
                            return StreamBuilder(
                              stream: currentExerciseIndex$,
                              builder: (context, snapshot) {
                                int currentExerciseIndex = currentExerciseIndex$.value ?? -1;
                                bool isActive = currentExerciseIndex == index;
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
                                    BoxShadow(
                                        color: isActive && isRunning$.value ? config.primaryColor.withOpacity(0.7) : Colors.grey.withOpacity(0.6),
                                        spreadRadius: 3,
                                        blurRadius: 10,
                                        offset: const Offset(0, 3))
                                  ]),
                                  margin: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: const BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                                            child: CachedNetworkImage(
                                              height: W / 1.4,
                                              width: W,
                                              imageUrl: program[index].exercisephotourl ??
                                                  "https://images.pexels.com/photos/841131/pexels-photo-841131.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) => Center(child: CircularProgressIndicator(color: config.primaryColor)),
                                              errorWidget: (context, url, error) => const Icon(Icons.error),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            left: 0,
                                            child: Container(
                                              width: W,
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(0.6),
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                ),
                                              ),
                                              child: Text(
                                                program[index].exercisename,
                                                style: kMontserrat18.copyWith(color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(5),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: program[index].p!.map((item) {
                                            bool isNotes = item.notes != null;
                                            return Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          "${item.dayoftheweek}",
                                                          style: kMontserrat18.copyWith(fontSize: 22),
                                                        ),
                                                        const Icon(Icons.calendar_month_outlined),
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text("${item.quantity}", style: kMontserrat18),
                                                        Text("X", style: kMontserrat18.copyWith(color: config.primaryColor)),
                                                        Text("${item.repeatnumber}", style: kMontserrat18),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                if (isNotes) Text(item.notes ?? "", style: kProxima17),
                                              ],
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      if (index != program.length - 1)
                                        StreamBuilder<Duration>(
                                          stream: durations[index],
                                          builder: (context, snapshot) {
                                            final duration = snapshot.data ?? Duration.zero;
                                            return Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    "Süre: ${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}",
                                                    style: kMontserrat18.copyWith(color: Colors.black87),
                                                  ),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          if (isRunning$.value && isActive) {
                                                            // Eğer aktif ve çalışıyorsa duraklat
                                                            _pauseTimer();
                                                          } else if (!isRunning$.value && isActive) {
                                                            // Eğer aktif ama duraklatılmışsa kaldığı yerden devam et
                                                            _startTimer(index);
                                                          } else {
                                                            // Yeni bir egzersiz başlat
                                                            _startTimer(index);
                                                          }
                                                        },
                                                        child: Container(
                                                          padding: const EdgeInsets.all(8),
                                                          decoration: BoxDecoration(
                                                            color: config.primaryColor,
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: Icon(
                                                            isActive && isRunning$.value ? Icons.pause : Icons.play_arrow,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: W / 30),
                                                      InkWell(
                                                        onTap: () {
                                                          _stopTimer(index);
                                                          if (index < durations.length - 1) {
                                                            _startTimer(index + 1);
                                                          }
                                                        },
                                                        child: Container(
                                                          padding: const EdgeInsets.all(8),
                                                          decoration: BoxDecoration(
                                                            color: config.primaryColor,
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: const Icon(Icons.stop, color: Colors.white),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      if (index == program.length - 1)
                                        InkWell(
                                          onTap: () {
                                            _stopTimer(index);
                                          },
                                          child: Container(
                                            width: W,
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: config.primaryColor,
                                              borderRadius:
                                                  const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                            ),
                                            child: Text(
                                              "Finish".tr(),
                                              style: kMontserrat18.copyWith(color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            });
      },
    );
  }
}
