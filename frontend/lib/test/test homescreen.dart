import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/appcolot.dart';
import '../model class/card details.dart';
import '../widgets/buttonbouncable.dart';

class TestHomeScreeen extends StatelessWidget {
  const TestHomeScreeen({super.key});

  @override
  Widget build(BuildContext context) {

    List<CardModel> _currentCards = [];
    int _currentIndex = 1;
    return Scaffold(
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,


backgroundColor: Colors.black12,
      // appBar: AppBar(
      //   backgroundColor: Colors.black12,
      // ),
      body:SingleChildScrollView(

        padding: EdgeInsets.all(30),
        child: Column(
          children: [
         Row(
           children: [

             Text("Hi",
          style: GoogleFonts.righteous(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primarybuttontextColor,
                  fontSize: 45,

                ),


             ),
             // CircleAvatar(
             //   radius: 50,
             //   backgroundColor: Colors.white,
             // )
           ],
         ),
            SizedBox(height: 20,),
            Center(
              child: Container(
                height: 500,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(40)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/images/1.jpeg",

                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,

                  ),
                ),

              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 300,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)
                  ),
        
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 150,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(40)
                  ),

                ),
        
              ],
            )
          ],
        ),
      ),);
  }
  Widget _buildFloatingActionButton() {
    return Column(
mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BounceableButton(
          color: AppColors.primarybuttonColor,
          icon: CupertinoIcons.clear_thick,
          onTap: () {},
          iconcolor: AppColors.primarybuttontextColor,
        ),
        SizedBox(height: 30,),
        BounceableButton(
          color:AppColors.primarybuttonColor,
          icon: CupertinoIcons.suit_heart,
          onTap: () {},
          iconcolor: AppColors.primarybuttontextColor,
        ),SizedBox(height: 30,),
        BounceableButton(
          color:AppColors.primarybuttonColor,
          icon: CupertinoIcons.location_circle,
          onTap: () {},
          iconcolor: AppColors.primarybuttontextColor,
        ),
      ],
    );
  }
}
