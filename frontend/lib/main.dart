import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'pages/customnavbar/customnavbar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAgvmZD7MVsSOREQUa08JDLAhRtHBmYKcA",
          appId: "1:463150786121:android:7cd0cd174a4ec327ad0198",
          messagingSenderId: "463150786121",
          projectId: "food-pit")
  );
  runApp(


      MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Swiper',
      theme: ThemeData(primarySwatch: Colors.blue,
          
          scaffoldBackgroundColor: Color(0XFF1B1B1B),
      appBarTheme: AppBarTheme(color: Color(0XFF1B1B1B))
      ),
      home: MainScreen(),
      // HomescreenNew(),

      // FoodAppNavigationBar(),
    );
  }
}
