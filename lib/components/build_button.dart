// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:makeup_browser/assets/colors.dart';
import 'package:makeup_browser/assets/spacing.dart';

class BuildButton extends StatefulWidget {
  bool loading;
  var height, width;
  String? text;
  VoidCallback? onPressed;
  Color backgrounDColor;
  Color textcolor, borderColor;
  BuildButton({
    super.key,
    this.loading = false,
    this.height = size50,
    this.borderColor = white,
    this.width = double.infinity,
    this.textcolor = Colors.white,
    this.backgrounDColor = primary_color,
    required this.onPressed,
    required this.text,
  });

  @override
  State<BuildButton> createState() => _BuildButtonState();
}

class _BuildButtonState extends State<BuildButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        // border: Border.all(color: widget.borderColor),
        borderRadius: BorderRadius.circular(9),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: ElevatedButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.backgrounDColor,
            ),
            child: widget.loading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )
                : Text(
                    widget.text.toString(),
                    style: TextStyle(
                        color: widget.textcolor,
                        // fontFamily: "Outfit",
                        fontSize: size15,
                        fontWeight: FontWeight.w500),
                  )),
      ),
    );
  }
}
