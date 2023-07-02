import 'package:flutter/material.dart';

import '../colors.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {Key? key,
      required this.text,
      required this.onPress,
      this.textColor,
      this.buttonStyle,
      this.backGroundColor,
      this.boarderColor,
      this.radius,
      this.fontSize,
      // this.gradient =
      //     const LinearGradient(colors: [Colors.redAccent, Colors.deepOrange]),
      this.gradient,
      this.enableBorder,
      this.width,
      this.icon,
      this.borderRadius,
      this.outerPadding,
      this.textStyle,
      this.height,
      this.buttonPadding,
      this.innerPadding})
      : super(key: key);

  final String text;
  final Function()? onPress;
  final Color? textColor;
  final Color? backGroundColor;
  final Color? boarderColor;
  final ButtonStyle? buttonStyle;
  final double? radius;
  final double? fontSize;
  final Gradient? gradient;
  final bool? enableBorder;
  final double? width;
  final double? height;
  final Icon? icon;
  final BorderRadius? borderRadius;
  final EdgeInsets? outerPadding;
  final TextStyle? textStyle;
  final double? buttonPadding;
  final EdgeInsets? innerPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: outerPadding ?? const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Container(
        padding: innerPadding ?? const EdgeInsets.all(0),
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius:
              borderRadius ?? BorderRadius.all(Radius.circular(radius ?? 10.0)),
        ),
        child: ElevatedButton(
          style: buttonStyle ??
              ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                  (states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.grey;
                    } else {
                      return backGroundColor ?? AppColors.buttonColor;
                    }
                  },
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                ),
                shadowColor: MaterialStateProperty.all(Colors.transparent),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: borderRadius ??
                        BorderRadius.all(Radius.circular(radius ?? 10.0)),
                    side: BorderSide(color: boarderColor ?? Colors.white),
                  ),
                ),
                foregroundColor: MaterialStateProperty.resolveWith(
                  (states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.grey;
                    } else {
                      return Colors.white;
                    }
                  },
                ),
              ),
          onPressed: onPress,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: textStyle ??
                TextStyle(fontSize: 14, color: AppColors.blackColor),
          ),
        ),
      ),
    );
  }
}
