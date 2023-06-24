import 'package:flutter/material.dart';

import '../colors.dart';


class RoundButton extends StatelessWidget {
  const RoundButton(
      {Key? key,
      required this.title,
      this.loading = false,
      required this.onPress})
      : super(key: key);

  final String title;
  final bool? loading;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 200,
      decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Center(
        child: loading==true
            ? CircleAvatar()
            : Text(
                title,
                style: TextStyle(color: AppColors.whiteColor),
              ),
      ),
    );
  }
}
