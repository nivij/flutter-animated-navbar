import 'package:flutter/material.dart';
import 'dart:async';
import '../../constants/appcolot.dart';
import '../navigation/navigation.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Start a timer for the splash screen duration
    Timer(Duration(seconds: 2), () {
      // Navigate to the home screen after 3 seconds
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FoodAppNavigationBar()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: CircleAvatar(
            radius: 40,
            child: Image.asset('assets/images/logo.png', width: 200, height: 200)),
        // Add your splash screen logo or animation
      ),
    );
  }
}
