import 'package:easy_localization/easy_localization.dart';
import 'package:elektra_fit/global/global-variables.dart';
import 'package:flutter/material.dart';

class CButton extends StatelessWidget {
  const CButton({
    super.key,
    required this.title,
    required this.func,
    this.width,
    this.backgroundColor,
    this.height,
    this.isBorder = false,
  });

  final String title;
  final VoidCallback func;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final bool isBorder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: isDarkMode$.stream,
        builder: (context, snapshot) {
          return InkWell(
              onTap: func,
              child: Container(
                width: width ?? MediaQuery.of(context).size.width * 0.43,
                height: height ?? MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: isBorder ? Colors.transparent : config.primaryColor,
                    border: Border.all(color: config.primaryColor, width: 1)),
                child: Container(
                  alignment: Alignment.center,
                  child: isLoading$.value
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(title.tr(),
                          style: const TextStyle(color: Colors.white, fontFamily: "Montserrat", fontSize: 18), textAlign: TextAlign.center),
                ),
              ));
        });
  }
}
