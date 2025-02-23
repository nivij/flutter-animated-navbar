import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/appcolot.dart';
import '../model class/card details.dart';
import 'button.dart';

class FoodCard extends StatefulWidget {
  final List<CardModel> items;
  final Function(int) onCardSwiped;
  final Function(IconData, bool) onButtonTap; // Add this callback
  final Function(String) onLocationTap; // Add this callback

  const FoodCard({
    Key? key,
    required this.items,
    required this.onCardSwiped,
    required this.onButtonTap,
    required this.onLocationTap,
  }) : super(key: key);

  @override
  FoodCardState createState() => FoodCardState();
}

class FoodCardState extends State<FoodCard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _currentIndex < widget.items.length
              ? _buildCard(widget.items[_currentIndex])
              : const Text('No cards available',
              style: TextStyle(color: Colors.white)),
          const SizedBox(height: 20), // Add spacing between card and buttons
        ],
      ),
    );
  }

  Widget _buildCard(CardModel item) {
    return Container(
      height: 40*9,
      width: 540,
      child: AspectRatio(
        aspectRatio: 4 / 6, // Square Instagram-like ratio
        child: Card(
          elevation: 10,
          margin: EdgeInsets.symmetric(horizontal: 20),
          color: Color(0xFF343434),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              fit: StackFit.expand, // Make sure stack fills the available space
              children: [
                _buildCardImage(item.image),
                // _buildProfileNameContainer("nivij"),
                _buildBottomGradientOverlay(),
                _buildTitleText(item.title),
                _buildProfileNameContainer("nivij"),
                _buildDistanceText(),
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: _buildFloatingActionButtons(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileNameContainer(String profileName) {
    return Positioned(
      bottom: 22*5,
      left: 20,
      child: Container(
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage("assets/images/logo.png"),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              profileName,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardImage(String imagePath) {
    return AspectRatio(
      aspectRatio: 4 / 6, // Perfect square ratio like Instagram
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildBottomGradientOverlay() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 260,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.9),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleText(String title) {
    return Positioned(
      bottom: 46*4,
      left: 15,
      child: Text(
        title,

        style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontStyle: FontStyle.italic,
          fontSize: 35,
        ),
      ),
    );
  }

  Widget _buildDistanceText() {
    return Positioned(
      bottom: 40*4,
      left: 10,
      child: Text(
        "⚲  Calicut 10 km away",
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 17,
        ),
      ),
    );
  }

  Widget _buildBlurredTextContainer(String text) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            offset: Offset(1, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.primarybuttonColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              text,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }


  // New method to build the floating action buttons
  Widget _buildFloatingActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AnimatedHoverButton(
          color: Colors.white,

          iconsize: 35,
          text: "",
          Width: 90,
          height: 60,
          icon: CupertinoIcons.clear_circled_solid,
          onTap: () {
            widget.onButtonTap(Icons.close, false);
            // Move to next card
          },
          iconcolor: Colors.black,
        ),
        AnimatedHoverButton(
          color: Color(0XFF9D1F16),

          iconsize: 55,
          Width: 80,
          height: 70,
          icon: CupertinoIcons.location_circle_fill,
          onTap: () {
            if (_currentIndex < widget.items.length) {
              final location = widget.items[_currentIndex].location;
              if (location != null && location.isNotEmpty) {
                widget.onLocationTap(location);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Location not available for this spot'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            }
          },
          iconcolor: Colors.white,
          text: '',
        ),
        AnimatedHoverButton(
          iconsize: 35,
          Width: 90,
          height: 60,
          icon: CupertinoIcons.heart_fill,
          onTap: () {
            widget.onButtonTap(Icons.favorite, true);
            // Move to next card
          },
          iconcolor: Colors.black,
          text: '',
          color: Colors.white,
        ),
      ],
    );
  }

  // Helper method to move to the next card

}