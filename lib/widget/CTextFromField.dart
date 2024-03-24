import 'package:flutter/material.dart';

import '../global/global-variables.dart';

Widget CTextFormField(
  TextEditingController cont,
  String label, {
  Function? validator,
  Function? onchange,
  Widget? prefixIcon,
  Widget? suffixIcon,
  TextStyle? textMode,
  bool enabled = true,
  bool multiLine = false,
  bool obscureText = false,
  Color? suffixIconColor,
  TextInputType? keyboardType,
  String hint = "",
  Color? prefixIconColor,
  VoidCallback? ontap,
  Function? onfieldSubmitted,
  bool? readOnly,
  FocusNode? focusNode,
  TextInputAction? textInputAction,
}) {
  var border = OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: config.primaryColor));

  return TextFormField(
    focusNode: focusNode,
    onTap: ontap,
    controller: cont,
    style: textMode,
    keyboardType: keyboardType ?? TextInputType.text,
    textAlignVertical: TextAlignVertical.center,
    textAlign: TextAlign.left,
    textInputAction: textInputAction,
    enabled: enabled,
    expands: multiLine,
    obscureText: obscureText,
    maxLines: multiLine ? null : 1,
    cursorColor: Colors.white54,
    minLines: multiLine ? null : 1,
    showCursor: true,
    decoration: InputDecoration(
      hintText: hint,
      isDense: true,
      border: border,
      enabledBorder: border,
      fillColor: Colors.white12,
      filled: true,
      prefixIcon: prefixIcon ?? null,
      suffixIcon: suffixIcon ?? null,
      prefixIconColor: Colors.black87,
      suffixIconColor: Colors.black87,
      labelText: label != "" ? label : null,
      labelStyle: const TextStyle(color: Colors.black87, fontFamily: "Montserrat", fontSize: 17),
    ),
    readOnly: readOnly ?? false,
    onFieldSubmitted: onfieldSubmitted != null ? (v) => onfieldSubmitted(v) : (v) => null,
    validator: validator != null ? (v) => validator(v) : (v) => null,
    onChanged: onchange != null ? (value) => onchange(value) : null,
  );
}
