import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  final Animation<double> animation;
  final IconData icon;


  const LoadingOverlay({
    Key? key,
    required this.animation,
    required this.icon,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
         Stack(
      children: [
        // A full-screen container with a semi-transparent background
        Container(
          color: Color(0XFF0C0C0C),// Background color with opacity
        ),
        Center(
          child:


           Icon(
              icon,
              size: 80,
              color: Color(0XFFFAFF2A),
            ),

        ),
      ],
    );

  }
}
