import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class BounceableButton extends StatelessWidget {
  final Color color;
  final Color iconcolor;
  final IconData icon;
  final VoidCallback onTap;

  const BounceableButton({
    Key? key,
    required this.color,
    required this.icon,
    required this.onTap, required this.iconcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounceable(

      onTap: onTap,
      child: Container(
        width: 168,
        height: 90,
        decoration: BoxDecoration(
borderRadius: BorderRadius.circular(40),
          color: color,
        ),
        child: Icon(icon, color: iconcolor, size: 35,),
      ),
    );
  }
}
