import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model class/card details.dart';


class FoodCard extends StatefulWidget {
  final List<CardModel> items;
  final Function(int) onCardSwiped;

  const FoodCard({
    Key? key,
    required this.items,
    required this.onCardSwiped,
  }) : super(key: key);

  @override
  FoodCardState createState() => FoodCardState();
}

class FoodCardState extends State<FoodCard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _currentIndex < widget.items.length
          ? _buildCard(widget.items[_currentIndex])
          : const Text('No cards available', style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildCard(CardModel item) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            _buildCardImage(item.image),
            _buildBottomGradientOverlay(),
            _buildTitleText(item.title),
            _buildDistanceText(),
            _buildInfoRow(item.foodSpot, "Additional Info"),
            _buildMoodButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCardImage(String imagePath) {
    return Container(
      width: 350,
      height: 430,
      alignment: Alignment.center,
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  Widget _buildBottomGradientOverlay() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleText(String title) {
    return Positioned(
      bottom: 45,
      left: 10,
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontStyle: FontStyle.italic,
          fontSize: 40,
        ),
      ),
    );
  }

  Widget _buildDistanceText() {
    return Positioned(
      bottom: 98,
      left: 10,
      child: Text(
        "⚲  Calicut 10 km away",
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String leftText, String rightText) {
    return Positioned(
      bottom: 10,
      left: 10,
      child: Row(
        children: [
          _buildBlurredTextContainer(leftText),
          const SizedBox(width: 10),
          _buildBlurredTextContainer(rightText),
        ],
      ),
    );
  }

  Widget _buildBlurredTextContainer(String text) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            text,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMoodButton() {
    return Positioned(
      top: 20,
      right: 10,
      child: Bounceable(
        onTap: () {
          // Implement mood button functionality here
        },
        child: Container(
          width: 130,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: const Color(0XFFFAFF2A),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(1, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Mood",
                style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(CupertinoIcons.dial, size: 30),
            ],
          ),
        ),
      ),
    );
  }
}
