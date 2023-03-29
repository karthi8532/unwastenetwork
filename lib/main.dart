import 'package:flutter/material.dart';
import 'package:unwaste/apartmentview/apartment_view.dart';
import 'package:unwaste/dashboard/dashboard.dart';
import 'package:unwaste/login/login_page.dart';
import 'package:unwaste/profileview.dart';
import 'package:unwaste/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  SplashScreen(),
    );
  }
}
