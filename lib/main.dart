import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_builder/util/routes/routes.dart';
import 'package:resume_builder/util/routes/routes_name.dart';
import 'package:resume_builder/view_model/resume_details_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ResumeDetailsViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: RouteNames.home,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}


