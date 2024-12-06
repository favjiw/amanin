import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_flutter3/generated/assets.dart';
import 'package:mobile_flutter3/services/auth_services.dart';
import 'package:mobile_flutter3/shared/style.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _token;


  Future<void> _fetchToken() async {
    final storage = FlutterSecureStorage();
    _token = await storage.read(key: 'auth_token');
  }

  void _logout(BuildContext context) async {
    await AuthService().logout(_token!);
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchToken();
  }

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
                  decoration: const BoxDecoration(
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
                    _logout(context);
                    print('Token: $_token');
                    print('Cliced');
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
