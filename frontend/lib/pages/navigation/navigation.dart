import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

// Import your pages
import '../../constants/appcolot.dart';
import '../home screen/home screen.dart';
import '../profile/profile.dart';

class FoodAppNavigationBar extends StatefulWidget {
  const FoodAppNavigationBar({Key? key}) : super(key: key);

  @override
  _FoodAppNavigationBarState createState() => _FoodAppNavigationBarState();
}

class _FoodAppNavigationBarState extends State<FoodAppNavigationBar> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabChange(int index) {
    setState(() {
      _pageController.jumpToPage(index);
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          HomeScreen(),
          Profile(),
          Profile(),
        ],
      ),
      floatingActionButton: Container(
         height: 70,
        margin: EdgeInsets.only(bottom: 10,left: 40,right: 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: AppColors.primarybuttonColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: GNav(
          backgroundColor: Colors.transparent,
          selectedIndex: _selectedIndex,
          onTabChange: _onTabChange,
          haptic: true,
          iconSize:35,
          textStyle: GoogleFonts.poppins(
            color: AppColors.primarybuttontextColor,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),

          color:Colors.white,

          activeColor: AppColors.primarybuttontextColor,
          tabBackgroundColor:AppColors.offwhitetabbackgroundColor,
          gap: 10,
          tabs: [
            GButton(
              icon: Iconsax.home_2_copy,
              text: 'Home',
            ),
            GButton(
              icon: Iconsax.heart_copy,
              text: 'Likes',
            ),
            GButton(
              icon: Iconsax.profile_circle,
              text: 'Search',
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
