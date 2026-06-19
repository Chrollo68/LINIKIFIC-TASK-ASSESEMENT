import 'package:flutter/material.dart';
import 'routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: "JWT Authentication App",

      theme: ThemeData(primarySwatch: Colors.blue),

      initialRoute: AppRoutes.splash,

      routes: AppRoutes.routes,
    );
  }
}
