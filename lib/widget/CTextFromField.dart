import 'package:elektra_fit/global/global-variables.dart';
import 'package:flutter/material.dart';

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
  var border = OutlineInputBorder(borderSide: BorderSide(color: isDarkMode$.value ? Colors.white : Colors.black87), borderRadius: BorderRadius.circular(10));

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
    cursorColor: isDarkMode$.value ? Colors.white54 : Colors.black87,
    minLines: multiLine ? null : 1,
    showCursor: true,
    decoration: InputDecoration(
      hintText: hint,
      isDense: true,

      // focusedBorder: border,
      border: border,
      // enabledBorder: border,
      focusColor: Colors.red,
      fillColor: Colors.white54, filled: true,
      hintStyle: TextStyle(color: isDarkMode$.value ? Colors.white : Colors.black54),
      prefixIcon: prefixIcon ?? null,
      suffixIcon: suffixIcon ?? null,
      prefixIconColor: isDarkMode$.value ? Colors.white70 : Colors.black87,
      suffixIconColor: isDarkMode$.value ? Colors.white70 : Colors.black87,
      labelText: label != "" ? label : null,
      labelStyle: TextStyle(
        color: isDarkMode$.value ? Colors.white : Colors.black87,
      ),
    ),
    readOnly: readOnly ?? false,
    onFieldSubmitted: onfieldSubmitted != null ? (v) => onfieldSubmitted(v) : (v) => null,
    validator: validator != null ? (v) => validator(v) : (v) => null,
    onChanged: onchange != null ? (value) => onchange(value) : null,
  );
}
