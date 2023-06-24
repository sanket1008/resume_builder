import 'package:flutter/cupertino.dart';
import 'assets.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          height: 25,
          width: 25,
          child: Image.asset(Assets.LOADING_IMAGE),
        ));
  }
}