import 'package:flutter/material.dart';


class CommonInputBox extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? helperText;
  final TextStyle? suffixStyle;
  final Color? boarderColor;
  final Color? hintTextColor;
  final IconData? prefixIcon;
  final Widget? sufixIcon;
  final Widget? suffix;
  final Widget? prefix;
  final bool? isPassword;
  final bool? showPassword;
  final bool? enable;
  final bool? readOnly;
  final Function()? onPressEye;
  final int? maxLines;
  final int? minLines;
  final String label;
  final int? maxLength;
  final String? Function(String?)? validator;
  final bool? headerEnabled;
  final TextInputType? inputType;
  final Function(String)? onTextChange;
  final bool? isMandatoryField;
  final bool? obscureText;
  final bool? showCursor;
  final GestureTapCallback? onTap;
  final bool? isBorderEnabled;
  final bool? isFilledColor;
  final Color? filledColor;
  final EdgeInsets? padding;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final BorderRadius? borderRadius;
  final double? radius;
  final String? initialValue;

  const CommonInputBox(
      {super.key,
      this.controller,
      this.hintText,
      this.suffix,
      this.helperText,
      this.boarderColor,
      this.prefixIcon,
      this.sufixIcon,
      this.enable,
      this.readOnly,
      this.isPassword,
      this.onPressEye,
      this.showPassword,
      this.maxLines,
      this.minLines,
      required this.label,
      this.validator,
      this.maxLength,
      this.headerEnabled,
      this.inputType,
      this.onTextChange,
      this.isMandatoryField,
      this.obscureText,
      this.showCursor,
      this.onTap,
      this.isBorderEnabled,
      this.isFilledColor,
      this.filledColor,
      this.prefix,
      this.hintTextColor,
      this.suffixStyle,
      this.padding,
      this.hintStyle,
      this.borderRadius,
      this.radius,
      this.initialValue,
      this.labelStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? const EdgeInsets.only(left: 15.0, right: 15.0, top: 10),
      child: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Visibility(
                  visible: headerEnabled ?? true,
                  child: Text(
                    label ?? "",
                    style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                  ))),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            initialValue: initialValue,
            textAlignVertical: TextAlignVertical.center,
            onTap: onTap,
            showCursor: showCursor,
            onChanged: onTextChange,
            keyboardType: inputType,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLength: maxLength != null ? maxLength : null,
            autofocus: false,
            maxLines: isPassword ?? false ? 1 : maxLines,
            minLines: isPassword ?? false ? 1 : minLines,
            style: TextStyle(color: Colors.grey),
            controller: controller,
            readOnly: readOnly ?? false,
            obscureText: isPassword ?? false,
            decoration: InputDecoration(
              errorStyle: const TextStyle(height: 0),
              border: _buildOutlineInputBorder(context),
              errorBorder:
                  _buildOutlineInputBorder(context, isErrorEnabled: true),
              focusedErrorBorder: _buildOutlineInputBorder(context),
              contentPadding: const EdgeInsets.only(
                  left: 15, top: 10, bottom: 10, right: 15),
              counter: const Offstage(),
              fillColor: isFilledColor == true
                  ? filledColor
                  : Colors.white,
              filled: true,
              isDense: true,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 5,
                minHeight: 5,
              ),
              suffixIconConstraints: const BoxConstraints(
                minWidth: 2,
                minHeight: 2,
              ),

              enabledBorder: _buildOutlineInputBorder(context),
              focusedBorder: _buildOutlineInputBorder(context),
              disabledBorder: _buildOutlineInputBorder(context),
              // suffix: sufixIcon,
              suffixIcon: sufixIcon,
              suffix: suffix,
              prefixIcon: prefix,
              prefix: prefix,
              suffixStyle: suffixStyle,
              hintText: hintText ?? label,
              hintStyle: hintStyle ??TextStyle(fontSize: 15,color: Colors.black.withAlpha(100)),
              labelStyle: labelStyle ?? TextStyle(fontSize: 15,color: Colors.black),
              floatingLabelStyle: Theme.of(context).textTheme.bodyMedium,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              floatingLabelAlignment: FloatingLabelAlignment.start,
              enabled: enable ?? true,
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _buildOutlineInputBorder(BuildContext context,
      {bool? isErrorEnabled}) {
    return OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: isErrorEnabled == true
              ? Colors.red
              : Colors.black,
          width: 0,
        ));
  }
}
