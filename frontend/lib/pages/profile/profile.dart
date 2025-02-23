import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(
        child: Text('Profile Screen', style: TextStyle(fontSize: 24, color: Colors.white)),
      ),
    );
  }
}