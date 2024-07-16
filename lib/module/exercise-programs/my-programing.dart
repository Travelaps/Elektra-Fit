import 'package:flutter/material.dart';

import '../../global/index.dart';

class ExerciseProgramsList extends StatefulWidget {
  const ExerciseProgramsList({Key? key}) : super(key: key);

  @override
  State<ExerciseProgramsList> createState() => _ExerciseProgramsListState();
}

class _ExerciseProgramsListState extends State<ExerciseProgramsList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double W = MediaQuery.of(context).size.width;
    return Scaffold(appBar: AppBar(title: Text('My Exercise Programs'.tr())), body: myPrograms(context, W));
  }

  Padding myPrograms(BuildContext context, double W) {
    return Padding(
      padding: paddingAll10,
      child: member$.value == null || member$.value!.isEmpty
          ? Center(child: CircularProgressIndicator(color: config.primaryColor))
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, childAspectRatio: 1.5),
              itemCount: member$.value!.length,
              itemBuilder: (context, index) {
                var item = member$.value![index];
                return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SportDetails()));
                    },
                    child: Stack(children: [
                      ClipRRect(
                          borderRadius: borderRadius10,
                          child: CachedNetworkImage(
                              imageUrl: item.program.first.exercisephotourl ??
                                  "https://www.skechers.com.tr/blog/wp-content/uploads/2023/03/fitnes-770x513.jpg",
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity)),
                      Positioned.fill(
                          child: Container(
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [Colors.transparent, Colors.black.withOpacity(0.6)]),
                                  borderRadius: borderRadius10),
                              child: Padding(
                                  padding: paddingAll5,
                                  child: Text('Program'.tr(), style: kAxiforma20.copyWith(color: Colors.white), textAlign: TextAlign.center)))),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          padding: paddingAll5,
                          decoration: BoxDecoration(color: config.primaryColor, shape: BoxShape.circle),
                          child: Icon(Icons.navigate_next_outlined, color: Colors.white, size: 30),
                        ),
                      )
                    ]));
              },
            ),
    );
  }
}
