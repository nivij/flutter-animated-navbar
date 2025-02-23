import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedHoverButton extends StatefulWidget {
  final List<Color> gradientColors; // Accept a list of two colors for the gradient
  final Color iconcolor;
  final IconData icon;
  final double Width;
  final double height;
  final VoidCallback onTap;
  final String text;
  final double iconsize;

  const AnimatedHoverButton({
    Key? key,
    required this.gradientColors, // Accept gradient colors as a parameter
    required this.icon,
    required this.onTap,
    required this.iconcolor,
    required this.text,
    required this.Width,
    required this.height,
    required this.iconsize,
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
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 60),
        padding: EdgeInsets.only(bottom: _paddingBottom, right: _paddingright, left: 0),
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Container(
          width: widget.Width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              stops: [0,1],
              colors: widget.gradientColors, // Use the passed gradient colors
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
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
      ),
    );
  }
}
