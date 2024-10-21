import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:footpit/pages/home%20screen/home%20screen.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        backgroundColor: Colors.black,
        body: HomeScreen(), // 'body' should be inside 'Scaffold'
      ),
    );
  }
}

