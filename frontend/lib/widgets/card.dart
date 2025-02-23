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
          ? _buildcard2(widget.items[_currentIndex])
          : const Text('No cards available',
              style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildcard2(CardModel item) {
    return Container(
      height: 505,
      width: 350,// 200*2
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              topLeft: Radius.circular(40),
              bottomRight: Radius.circular(10))),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(right: 3,),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black,width: 3),
              color: Colors.white,
            ), // Add space above

            height: 500,
width: 350
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 70,right: 5),
            child: Center(

              child: Container(height: 130*3,
              width: 160*2,
              decoration: BoxDecoration(
                  color: Colors.red,
                border: Border.all(color: Colors.black,width: 3),
                borderRadius: BorderRadius.circular(10)
              ),
                child: _buildCardImage(item.image),
            ),
            ),
          ),
          _buildTitleText(item.title),
          _buildDistanceText(),
          // _buildCardImage(item.image),
        ],
      ),
    );
  }

  Widget _buildCard(CardModel item) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 0.2, sigmaY: 0.2),
      child: Container(
        height: 148 * 3,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(20)),
        child: Card(
          elevation: 10,
          margin: EdgeInsets.symmetric(horizontal: 20),
          color: Color(0xFF343434),
          shape: RoundedRectangleBorder(
            // side: BorderSide(color: Colors.white,width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Stack(
                  children: [
                    _buildCardImage(item.image),
                    _buildProfileNameContainer("nivij"),
                    _buildBottomGradientOverlay(),
                    _buildTitleText(item.title),
                    _buildDistanceText(),
                    _buildInfoRow(item.foodSpot, "Additional Info"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileNameContainer(String profileName) {
    return Container(
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
            decoration: BoxDecoration(
              color: Colors.black
                  .withOpacity(0.3), // Add semi-transparent background
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
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
                _buildMoodButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardImage(String imagePath) {
    return Image.asset(
        imagePath,
      
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,

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
      bottom: 40,
      left: 15,
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontStyle: FontStyle.italic,
          fontSize: 35,
        ),
      ),
    );
  }

  Widget _buildDistanceText() {
    return Positioned(
      bottom: 28,
      left: 10,
      child: Text(
        "⚲  Calicut 10 km away",
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 13,
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

  Widget _buildMoodButton() {
    return AnimatedHoverButton(
      Width: 110,
      height: 90,
      iconsize: 25,
      // color: Colors.blue,
      iconcolor: Colors.white,
      icon: CupertinoIcons.dial,
      text: "Mood",
      onTap: () {
        // Your tap handling code here
      }, gradientColors: [Color(0XFFFDC95E),Color(0XFFFDC95E)],
    );
    // Bounceable(
    //   onTap: () {
    //     // Implement mood button functionality here
    //   },
    //   child: Container(
    //     width: 110,
    //     height: 40,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(40),
    //       color: AppColors.primarybuttonColor,
    //       boxShadow: const [
    //         BoxShadow(
    //           color: Colors.white,
    //           offset: Offset(1, 4),
    //         ),
    //       ],
    //     ),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Text(
    //           "Mood",
    //           style: GoogleFonts.righteous(
    //             fontWeight: FontWeight.bold,
    //             color: AppColors.primarybuttontextColor,
    //             fontSize: 17,
    //           ),
    //         ),
    //         const SizedBox(width: 8),
    //         const Icon(CupertinoIcons.dial, size: 25),
    //       ],
    //     ),
    //   ),
    // );
  }
}
