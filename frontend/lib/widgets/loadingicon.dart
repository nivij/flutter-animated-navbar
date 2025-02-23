import 'package:flutter/material.dart';

import '../constants/appcolot.dart';

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
          color:AppColors.backgroundColor// Background color with opacity
        ),
        Center(
          child:


           Icon(
              icon,
              size: 80,
              color: AppColors.primarybuttonColor,
            ),

        ),
      ],
    );

  }
}
