import 'package:flutter/material.dart';
import 'package:resume_builder/util/routes/routes_name.dart';
import 'package:resume_builder/view/add_resume_details.dart';

import '../../view/home_screen.dart';
import '../../view/login_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
      case RouteNames.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());
      case RouteNames.addResume:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AddResumeDetails());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("No route defined"),
            ),
          );
        });
    }
  }
}
