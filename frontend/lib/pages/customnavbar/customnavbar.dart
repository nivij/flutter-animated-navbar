import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:fluttericon/typicons_icons.dart';

import '../../constants/appcolot.dart';
import '../homepagenewui/homepagenewui.dart';




class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPageIndex = 0;
  int _expandedButtonIndex = 0;

  final List<Widget> _pages = [
    HomescreenNew(),
    HomePage(),
    ProfilePage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPageIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            height: 1,
            thickness: 2,
            color: AppColors.textColor,
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: CustomBottomNavBar(
              selectedIndex: _expandedButtonIndex,
              onNavButtonTap: (index) {
                setState(() {
                  if (_expandedButtonIndex != index) {
                    _expandedButtonIndex = index;
                    _currentPageIndex = index;
                  }
                  // Else do nothing if it's already selected
                });
              },

            ),
          ),
        ],
      ),
    );
  }
}

// Sample pages
class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.explore, size: 100, color: Colors.blue),
          SizedBox(height: 20),
          Text('Discover Page', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home, size: 100, color: Colors.green),
          SizedBox(height: 20),
          Text('Home Page', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 100, color: Colors.purple),
          SizedBox(height: 20),
          Text('Profile Page', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.settings, size: 100, color: Colors.orange),
          SizedBox(height: 20),
          Text('Settings Page', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onNavButtonTap;

  const CustomBottomNavBar({
    required this.selectedIndex,
    required this.onNavButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(

      width: screenWidth,
      child: Row(
        children: [
          NavButton(
            icon: Entypo.compass,
            label: "Discover",
            isExpanded: selectedIndex == 0,
            onTap: () => onNavButtonTap(0),
          ),

          NavButton(
            icon: LineariconsFree.user_1,
            label: "Home",
            isExpanded: selectedIndex == 1,
            onTap: () => onNavButtonTap(1),
          ),

          NavButton(
            icon: Linecons.cog,
            label: "Profile",
            isExpanded: selectedIndex == 2,
            onTap: () => onNavButtonTap(2),
          ),

          NavButton(
            icon: Typicons.plus_outline,
            label: "Settings",
            isExpanded: selectedIndex == 3,
            onTap: () => onNavButtonTap(3),
          ),
        ],
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isExpanded;
  final VoidCallback onTap;

  const NavButton({
    required this.icon,
    required this.label,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: 50,
            width: isExpanded ? screenWidth * 0.63 : 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: 2, color: AppColors.textColor),
            ),
          ),

          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: isExpanded ? 16 : 12,
            child: Icon(icon, size: 25, color: AppColors.textColor),
          ),

          Positioned(
            right: 16,
            child: AnimatedOpacity(
              opacity: isExpanded ? 1.0 : 0.0,
              duration: Duration(milliseconds: 180),
              curve: isExpanded ? Interval(0.8, 1.0) : Interval(0.0, 0.5),
              child: Text(
                label,
                style: TextStyle(fontSize: 16,
                    fontFamily: 'Customfont',

                color:AppColors.textColor
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}