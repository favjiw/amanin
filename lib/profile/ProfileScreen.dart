import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_flutter3/generated/assets.dart';
import 'package:mobile_flutter3/shared/style.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: appBar,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: HexColor('#D74A49'),
            ),
            onPressed: () {
              // Handle button press
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  width: 130.w, // Set the desired width
                  height: 130.h, // Set the desired height
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, // Make the container circular
                    image: DecorationImage(
                      image: AssetImage(Assets
                          .assetsProfileImg), // Or AssetImage for local images
                      fit: BoxFit.cover, // Adjust the image fit as needed
                    ),
                  ),
                ),
                SizedBox(
                  height: 13.h,
                ),
                Text(
                  'Karina Wicaksono',
                  style: profileName,
                ),
                Text(
                  'karina@gmail.com',
                  style: profileEmail,
                ),
                SizedBox(
                  height: 13.h,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle sign out logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.r),
                    ),
                  ),
                  child: Text('Logout', style: logoutBtn,),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
