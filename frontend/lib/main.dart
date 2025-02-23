import 'package:flutter/material.dart';

import 'test/test homescreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Swiper',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TestHomeScreeen(),
      // HomeScreen(),
      // TestHomePage(),

      // FoodAppNavigationBar(),
    );
  }
}
