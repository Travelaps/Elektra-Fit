import 'package:flutter/material.dart';

import '../../../global/global-models.dart';

class SpaGroupActivityDetail extends StatefulWidget {
  const SpaGroupActivityDetail({super.key, required this.item});

  final SpaGroupActivityModel item;

  @override
  State<SpaGroupActivityDetail> createState() => _SpaGroupActivityDetailState();
}

class _SpaGroupActivityDetailState extends State<SpaGroupActivityDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("sads")),
      body: SingleChildScrollView(),
    );
  }
}
