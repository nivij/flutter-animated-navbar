import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

import '../../constants/appcolot.dart';
import '../../constants/mediaquery.dart';
import '../../model class/card details.dart';
import '../../model class/list/card details.dart';
import '../../model class/list/colors/colorsList.dart';

import '../../widgets/card.dart';





class HomescreenNew extends StatefulWidget {
  @override
  _HomescreenNewState createState() => _HomescreenNewState();
}

class _HomescreenNewState extends State<HomescreenNew> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _waveAnimation;
  List<CardModel> _currentCards = [];
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();

    // Initialize AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(minutes: 4),
      upperBound: 2 * 3.14159,
    )..repeat(reverse: true);

    // Define the animation
    _waveAnimation = Tween<double>(begin: 0, end: 2 * 3.14159).animate(_animationController);

    _loadRandomCards();

  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  void _loadRandomCards() {
    final shuffledCards = List<CardModel>.from(cards);
    shuffledCards.shuffle();
    _currentCards = shuffledCards;
    _currentIndex = 0;
    setState(() {});
  }

  void _handleButtonTap(IconData icon, bool isLiked) {
    if (_currentCards.isEmpty) return;

    if (icon == Icons.favorite) {
      _currentCards[_currentIndex].isLiked = isLiked;
    } else if (icon == Icons.close) {
      _currentCards[_currentIndex].isLiked = isLiked;
    }

    Future.delayed(Duration(milliseconds: 500), () {
      _loadRandomCards(); // or navigate to next card
    });
  }

  void _onCardSwiped(int index) {
    print('Card at index $index was swiped');
  }

  Future<void> openGoogleMapsWithAddress(String location) async {
    try {
      final encodedLocation = Uri.encodeComponent(location);
      final url = 'google.navigation:q=$encodedLocation';
      final uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        final browserUrl = 'https://www.google.com/maps/dir/?api=1&destination=$encodedLocation';
        final browserUri = Uri.parse(browserUrl);
        if (await canLaunchUrl(browserUri)) {
          await launchUrl(browserUri);
        } else {
          throw 'Could not launch maps';
        }
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open maps')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double appBarHeight = screenHeight * 0.1;
    double searchBarWidth = screenWidth * 5;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight),
        child: Stack(
          children: [
            AppBar(

              // leadingWidth: 80,
              // leading: _buildCircularIcon(LineariconsFree.user_1, 25),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCircularIcon(LineariconsFree.user_1, 25),
                  Flexible(child: _buildSearchBar(searchBarWidth)),
                  _buildCircularIcon(FontAwesome5.sliders_h, 20),
                ],
              ),
              // centerTitle: true,
              // actions: [
              //   _buildCircularIcon(FontAwesome5.sliders_h, 20),
              // ],
              elevation: 0,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedBuilder(
                animation: _waveAnimation,
                builder: (context, child) {
                  return CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, 20),
                    painter: SmallWavyLinePainter(animationValue: _waveAnimation.value),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text.rich(
              TextSpan(
                text: "Craving some\n", // First line
                style: TextStyle(
                  fontSize: MQ.scaledFont(37),
                  color: AppColors.textColor,
                  fontFamily: 'Customfont',
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: "delicious today ?", // Second line
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontFamily: 'Customfont',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 40,),
          Container(
            child: _listbuilderslider(),
          ),
          SizedBox(height: 25,),
          Container(child: _Gridlayout()),
          // _buildFoodCard(),
        ],
      ),
    );
  }
Widget _Gridlayout(){
    return  Expanded(
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.78,
        ),
        // itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.white, width: 0.6),
                right: (index % 2 == 0)
                    ? BorderSide(color: Colors.white, width: 0.6)
                    : BorderSide.none,
                bottom: BorderSide(color: Colors.white, width: 0.6),
              ),
            ),
            // child: FoodCard(items[index]),
          );
        },
      ),
    );

}
  Widget _buildFoodCard() {
    return Center(
      child:  FoodCard(
        items: _currentCards,
        onCardSwiped: _onCardSwiped,
        onButtonTap: _handleButtonTap,
        onLocationTap: openGoogleMapsWithAddress,
      ),
    );
  }
  Widget _listbuilderslider() {
    return SizedBox(
      height: MQ.height(0.2).clamp(40, double.infinity),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colorList.length,
        itemBuilder: (context, index) {
          final item = colorList[index];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 0),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0), // adds space around the content
            decoration: BoxDecoration(
              color: item.color,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min, // this ensures the container wraps the content
              children: [
                Icon(item.iconData, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  item.label,
                  style: TextStyle(
                      fontSize: MQ.scaledFont(12),
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );

        },
      ),
    );
  }



  Widget _buildCircularIcon(IconData icon, double size) {
    return Center(
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.textColor, width: 2),
        ),
        child: Center(
          child: Icon(icon, size: size, color: AppColors.textColor),
        ),
      ),
    );
  }

  Widget _buildSearchBar(double width) {
    return Container(
      height: 40,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.textColor, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Linecons.globe,color: AppColors.textColor,),
          ),
          Text(
            "Calicut",
            style: TextStyle(fontSize: 20,
                color: AppColors.textColor,
                fontFamily: 'Customfont'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.keyboard_arrow_down,color: AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class SmallWavyLinePainter extends CustomPainter {
  final double animationValue;

  SmallWavyLinePainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.textColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Path path = Path();
    double waveWidth = 50;
    double waveHeight = 15;

    path.moveTo(0, size.height);
    for (double i = 0; i < size.width; i += waveWidth) {
      double offset = (i / waveWidth + animationValue) % 1.0;
      double yOffset = waveHeight * (math.sin(offset * 2 * math.pi));

      path.relativeQuadraticBezierTo(waveWidth / 4, -yOffset, waveWidth / 2, 0);
      path.relativeQuadraticBezierTo(waveWidth / 4, yOffset, waveWidth / 2, 0);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
