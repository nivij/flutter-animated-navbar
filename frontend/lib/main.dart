import 'package:flutter/material.dart';
import 'customnavbar/customnavbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Swiper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0XFF1B1B1B),
        appBarTheme: AppBarTheme(color: Color(0XFF1B1B1B)),
      ),
      home: MainScreen(),
    );
  }
}
