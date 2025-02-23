import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedHoverButton extends StatefulWidget {
  final Color iconcolor;
  final Color color;
  final IconData icon;
  final double Width;
  final double height;
  final VoidCallback onTap;
  final String text;
  final double iconsize;

   AnimatedHoverButton({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.iconcolor,
    required this.text,
    required this.Width,
    required this.height,
    required this.iconsize,
    required this.color,
  }) : super(key: key);

  @override
  State<AnimatedHoverButton> createState() => _AnimatedHoverButtonState();
}

class _AnimatedHoverButtonState extends State<AnimatedHoverButton> {
  double _paddingBottom = 5;
  double _paddingright = 5;
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _paddingBottom = 0;
      _paddingright = 0;
      _isPressed = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _paddingBottom = 5;
      _paddingright = 5;
      _isPressed = false;
    });
    widget.onTap(); // Call the onTap callback here
  }

  void _handleTapCancel() {
    setState(() {
      _paddingBottom = 5;
      _paddingright = 5;
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () => _isPressed,
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: Container(
        width: widget.Width,
        height: widget.height,
        decoration: BoxDecoration(
          border: Border.all(width: 2,
          color: Colors.white
          ),
          color:widget.color,
          borderRadius: BorderRadius.circular(30),

        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.text.isNotEmpty) ...[
              Text(
                widget.text,
                style: GoogleFonts.righteous(
                  fontWeight: FontWeight.bold,
                  color: widget.iconcolor,
                  fontSize: 17,
                ),
              ),
              const SizedBox(width: 8),
            ],
            Icon(
              widget.icon,
              size: widget.iconsize,
              color: widget.iconcolor,
            ),
          ],
        ),
      ),
    );
  }
}
