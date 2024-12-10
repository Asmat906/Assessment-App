// FormField
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:makeup_browser/assets/spacing.dart';

class textField extends StatelessWidget {
  String? hint;
  var height;
  List<TextInputFormatter>? inputformater;
  int? maxlength;
  var counterText;
  Widget? prefix, suffix, suffixWidget, prefixWidget;
  bool obscures;
  int? minline, maxline;
  var keyboardtype;
  Widget? labell;
  Function(String)? onchanged;
  FormFieldValidator<String>? validator;
  TextEditingController? controller;
  textField({
    this.hint,
    this.labell,
    this.counterText,
    this.keyboardtype,
    this.inputformater,
    this.maxlength,
    this.controller,
    this.obscures = false,
    this.prefix,
    this.onchanged,
    this.minline,
    this.maxline,
    this.height = 55.0,
    this.prefixWidget,
    this.suffixWidget,
    this.suffix,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        child: TextFormField(
            keyboardType: keyboardtype,
            obscureText: obscures,
            obscuringCharacter: "*",
            onChanged: onchanged,
            controller: controller,
            validator: validator,
            minLines: minline,
            style: const TextStyle(fontWeight: FontWeight.w300),
            inputFormatters: inputformater,
            maxLength: maxlength,
            maxLines: maxline,
            decoration: InputDecoration(
              counterText: counterText,
              suffixIcon: suffix,
              prefixIcon: prefix,
              label: labell,
              hintText: hint,
              suffix: suffixWidget,
              prefix: prefixWidget,
              fillColor: whiteColor,
              filled: true,
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: grey),
                  borderRadius: BorderRadius.circular(8)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: white),
                  borderRadius: BorderRadius.circular(8)),
            ))).paddingOnly(top: size10, bottom: size20);
  }
}
