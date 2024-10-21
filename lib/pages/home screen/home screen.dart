import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model class/card details.dart';
import '../../model class/list/card details.dart';
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

  void _loadRandomCards() {
    cards.shuffle(_random);
    _currentCards = cards.take(5).toList();
    setState(() {});
  }

  void _handleButtonTap(IconData icon) {
    _showLoadingOverlay(icon);
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
      backgroundColor: const Color(0XFF0C0C0C),
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0XFF0C0C0C),
      leadingWidth: 200,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 10),
        child: Row(
          children: [
            Text(
              'Calicut',
              style: GoogleFonts.ubuntu(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            const SizedBox(width: 10),
            const Icon(CupertinoIcons.location, color: Colors.white),
          ],
        ),
      ),
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: const CircleAvatar(
            backgroundColor: Color(0XFFFAFF2A),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          _buildFoodCard(),
          const SizedBox(height: 20),
          _buildSpotButton(),
          const SizedBox(height: 20),
          _buildPlaceholderContainer(),
          const SizedBox(height: 20),
          _buildPlaceholderContainer(),
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

  Widget _buildSpotButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Bounceable(
          onTap: () {},
          child: Container(
            width: 268,
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
                  "Head to the spot",
                  style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(CupertinoIcons.map),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderContainer() {
    return Container(
      height: 200,
      width: 380,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        height: 100,
        width: 350,
        decoration: BoxDecoration(
          color: const Color(0XFF3D3D3D),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BounceableButton(
              color: Colors.white,
              icon: CupertinoIcons.clear_thick,
              onTap: () => _handleButtonTap(Icons.close),
              iconcolor: Colors.black,
            ),
            BounceableButton(
              color: const Color(0XFFFAFF2A),
              icon: CupertinoIcons.suit_heart,
              onTap: () => _handleButtonTap(Icons.favorite),
              iconcolor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
