import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage())));
    var assetsImage = AssetImage(
        'assets/images/splash1.png',); //<- Creates an object that fetches an image.
    var image = Image(
        image: assetsImage,
        height: MediaQuery.of(context)
            .size
            .height,); //<- Creates a widget that displays an image.
    return  Scaffold(
        body: Container(
          decoration: new BoxDecoration(color: Colors.white),
          child: Center(
            child: image,
          ),
        ), //<- place where the image appears
    );
  }
}
