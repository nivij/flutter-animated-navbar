import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/appcolot.dart';
import '../../model class/card details.dart';
import '../../model class/list/card details.dart';
import '../../widgets/button.dart';
import '../../widgets/buttonbouncable.dart';
import '../../widgets/card.dart';
import '../../widgets/loadingicon.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final Random _random = Random();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  List<CardModel> _currentCards = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
    _loadRandomCards();
  }

  void _initializeAnimation() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  }
  // Future<void> _openLocation() async {
  //   if (_currentCards.isNotEmpty &&
  //       _currentIndex < _currentCards.length &&
  //       _currentCards[_currentIndex].location != null) {
  //     final location = _currentCards[_currentIndex].location;
  //     if (location != null && location.isNotEmpty) {
  //       await openGoogleMapsWithAddress(location);
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Location not available for this spot'),
  //           duration: Duration(seconds: 2),
  //         ),
  //       );
  //     }
  //   }
  // }

  Future<void> openGoogleMapsWithAddress(String location) async {
    try {
      final encodedLocation = Uri.encodeComponent(location);
      final url = 'google.navigation:q=$encodedLocation';
      final uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        print('Launching native maps app'); // Debug print
        await launchUrl(uri);
      } else {
        print('Falling back to browser'); // Debug print
        final browserUrl = 'https://www.google.com/maps/dir/?api=1&destination=$encodedLocation';
        final browserUri = Uri.parse(browserUrl);
        if (await canLaunchUrl(browserUri)) {
          await launchUrl(browserUri);
        } else {
          throw 'Could not launch maps';
        }
      }
    } catch (e) {
      print('Error launching maps: $e'); // Debug print
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not open maps: ${e.toString()}'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
  void _loadRandomCards() {
    final shuffledCards = List<CardModel>.from(cards);  // Make a copy of the list
    shuffledCards.shuffle();  // Use the shuffle method from collection package
    _currentCards = shuffledCards.toList();  // Get the first 5 shuffled cards
    _currentIndex = 0;  // Reset the index to start from the first card
    setState(() {});  // Trigger a rebuild to update the UI with new cards
  }


  void _handleButtonTap(IconData icon ,bool isLiked) {
    _showLoadingOverlay(icon);

    // Check if the icon is for like or dislike
    if (icon == Icons.favorite) {
      print('Like button tapped');
      print(cards[_currentIndex].title);
      print(cards[_currentIndex].foodSpot);
      print(cards[_currentIndex].location);
     cards[_currentIndex].isLiked=isLiked;
      print(cards[_currentIndex].isLiked);

    } else if (icon == Icons.close) {
      print('Dislike button tapped');
      print(cards[_currentIndex].title);
      print(cards[_currentIndex].foodSpot);
      print(cards[_currentIndex].location);
      cards[_currentIndex].isLiked=isLiked;
      print(cards[_currentIndex].isLiked);

    }

    Future.delayed(const Duration(seconds: 1), () {
      _dismissLoadingOverlay();
      _loadRandomCards();
    });
  }


  void _showLoadingOverlay(IconData icon) {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => LoadingOverlay(animation: _fadeAnimation, icon: icon),
    );
  }

  void _dismissLoadingOverlay() {
    Navigator.of(context).pop();

  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // backgroundColor: AppColors.backgroundColor,
      appBar: _buildAppBar(),
      body:Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: [0.0, 0.5],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryColor,
              AppColors.accentColor,

            ],
          ),
        ),
        child: _buildBody(),
      ),
      // floatingActionButton: _buildFloatingActionButton(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      leadingWidth: 120,
      centerTitle: true,
      title: Text("Spotit",

        style: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontStyle: FontStyle.italic,
        fontSize: 26,
      ),),
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 10),
        child: Row(
          children: [
            Icon(CupertinoIcons.line_horizontal_3,size: 40,)
            // const SizedBox(width: 10),
            //  Icon(Iconsax.direct_up, color: AppColors.primarybuttonColor,),
          ],
        ),
      ),
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child:
          Row(
            children: [
              // Text(
              //   'calicut',
              //   style: GoogleFonts.righteous(
              //     fontWeight: FontWeight.bold,
              //     color: AppColors.primarybuttontextColor,
              //     fontSize: 25,
              //   ),
              // ),
              const SizedBox(width: 10),
              Icon(Iconsax.direct_up, color: AppColors.primarybuttonColor,),
            ],
          ),
          // const CircleAvatar(
          //   backgroundImage: AssetImage("assets/images/logo.png"),
          //   backgroundColor: Colors.white,
          // ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Column(
        children: [
          // Align(alignment: Alignment.centerLeft,
          //   child: Text(
          //     'Cravings?',
          //     style: GoogleFonts.righteous(
          //       fontWeight: FontWeight.bold,
          //       color: AppColors.primarybuttontextColor,
          //       fontSize: 45,
          //
          //     ),
          //   ),
          // ),
          Align(
              alignment: Alignment.centerRight,
              child: _buildMoodButton()),
          const SizedBox(height: 20),
          _buildFoodCard(),
          const SizedBox(height: 20),
          _buildFloatingActionButton2(),
          const SizedBox(height: 20),
          // _buildSpotButton(),
          // const SizedBox(height: 20),
          _buildPlaceholderContainer("","",),

          const SizedBox(height: 20),
          _buildPlaceholderContainer("",""),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildFoodCard() {
    return Center(
      child: FoodCard(
        items: _currentCards,
        onCardSwiped: (index) {
          print('Card at index $index swiped');
        },
      ),
    );
  }

  // Widget _buildSpotButton() {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 20.0),
  //     child: Align(
  //       alignment: Alignment.centerRight,
  //       child: Bounceable(
  //         onTap: _openLocation,  // Use the same location opening function here
  //         child: Container(
  //           width: 268,
  //           height: 40,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(40),
  //             color: const Color(0XFFFAFF2A),
  //             boxShadow: const [
  //               BoxShadow(
  //                 color: Colors.black,
  //                 offset: Offset(1, 4),
  //               ),
  //             ],
  //           ),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text(
  //                 "Head to the spot",
  //                 style: GoogleFonts.righteous(
  //                   fontWeight: FontWeight.w600,
  //                   color: Colors.black,
  //                   fontSize: 22,
  //                 ),
  //               ),
  //               const SizedBox(width: 10),
  //               const Icon(CupertinoIcons.map),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildPlaceholderContainer(String head,String Price) {
    return Container(
      height: 206,
      width: 380,// 200*2
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

              height: 200,
              width: 380
          ),


          // _buildCardImage(item.image),
        ],
      ),
    );

  }
  Widget _buildMoodButton() {
    return AnimatedHoverButton(
      iconsize: 25,
      // color: Color(0XFFFDC95E),
      iconcolor: Colors.white,
        Width: 110,
      height: 50,
      icon: CupertinoIcons.dial,
      text: "Mood",
      onTap: () {
        // Your tap handling code here
      },
      gradientColors: [Color(0XFFFDC95E),Color(0XFFFDC95E)],
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
  Widget _buildFloatingActionButton2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AnimatedHoverButton(
          iconsize: 35,
          text: "",
          Width: 60,
          height: 60,
          // color: Color(0XFFFFFFFF),
          icon: CupertinoIcons.clear_circled_solid,
          onTap: () => _handleButtonTap(Icons.close, false),
          iconcolor: Colors.black, gradientColors: [
            Colors.white,Colors.white
        ],
        ),
        AnimatedHoverButton(
          iconsize: 55,
          Width: 80,
          height: 70,
          // color: Color(0XFFFEC14F),
          icon: CupertinoIcons.location_circle_fill,
          onTap: () {
            // Debug print to verify button tap
            print('Location button tapped');
            if (_currentCards.isNotEmpty &&
                _currentIndex < _currentCards.length &&
                _currentCards[_currentIndex].location != null) {
              final location = _currentCards[_currentIndex].location;
              print('Current location: $location'); // Debug print location
              if (location != null && location.isNotEmpty) {
                openGoogleMapsWithAddress(location);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Location not available for this spot'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            } else {
              print('No valid card or location'); // Debug print if no valid card
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Location not available'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          iconcolor: Colors.black,
          text: '', gradientColors: [Colors.white,Color(0XFFFEC14F)],
        ),
        AnimatedHoverButton(
          iconsize: 35,
          Width: 60,
          height: 60,
          // color: Color(0XFFFFFFFF),
          icon: CupertinoIcons.heart_fill,
          onTap: () => _handleButtonTap(Icons.favorite, true),
          iconcolor: Colors.red,
          text: '', gradientColors: [Colors.white,Colors.white],
        ),
      ],
    );
  }
  Widget _buildFloatingActionButton() {
    return Container(
      height: 60,
      width: 240,
      decoration: BoxDecoration(
        color: AppColors.primarybuttonColor,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BounceableButton(
            color: AppColors.primarybuttonColor,
            icon: CupertinoIcons.clear_thick,
            onTap: () => _handleButtonTap(Icons.close,false),
            iconcolor: AppColors.primarybuttontextColor,
          ),
          SizedBox(width: 30,),
          BounceableButton(
            color:AppColors.offwhitetabbackgroundColor,
            icon: CupertinoIcons.suit_heart,
            onTap: () => _handleButtonTap(Icons.favorite,true),
            iconcolor: AppColors.primarybuttontextColor,
          ),
        ],
      ),
    );
  }
}
