import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  List<TextInputFormatter>? inputFormatters,
}) {
  var border = OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black45));

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
      labelText: label.isNotEmpty ? label : null,
      labelStyle: const TextStyle(color: Colors.black87, fontFamily: "Proxima", fontSize: 17),
    ),
    readOnly: readOnly ?? false,
    onFieldSubmitted: onfieldSubmitted != null ? (v) => onfieldSubmitted(v) : (v) => null,
    validator: validator != null ? (v) => validator(v) : (v) => null,
    onChanged: onchange != null ? (value) => onchange(value) : null,
    inputFormatters: inputFormatters,
  );
}

class PhoneNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;

    final StringBuffer newText = StringBuffer();
    int usedSubstringIndex = 0;

    if (newTextLength >= 3) {
      newText.write(newValue.text.substring(0, 3) + ' ');
      if (newValue.selection.end >= 3) selectionIndex += 1;
      usedSubstringIndex += 3;
    }
    if (newTextLength >= 6) {
      newText.write(newValue.text.substring(3, 6) + ' ');
      if (newValue.selection.end >= 6) selectionIndex += 1;
      usedSubstringIndex += 3;
    }
    if (newTextLength >= 8) {
      newText.write(newValue.text.substring(6, 8) + ' ');
      if (newValue.selection.end >= 8) selectionIndex += 1;
      usedSubstringIndex += 2;
    }

    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
