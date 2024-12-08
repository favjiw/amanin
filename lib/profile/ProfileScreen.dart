import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_flutter3/Model/User.dart';
import 'package:mobile_flutter3/generated/assets.dart';
import 'package:mobile_flutter3/services/auth_services.dart';
import 'package:mobile_flutter3/services/user_services.dart';
import 'package:mobile_flutter3/shared/style.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _token;
  User? _user;

  Future<void> _fetchUserData() async {
    final user = await UserServices().fetchUserData();
    setState(() {
      _user = user;
    });
  }

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
    _fetchUserData();
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
                _user == null
                    ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7.r),
                    ),
                  ),
                )
                    : FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    _user!.username,
                    style: profileName,
                  ),
                ),
                const SizedBox(height: 8),
                // Email
                _user == null
                    ?  Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7.r),
                    ),
                  ),
                )
                    : FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    _user!.email,
                    style: profileEmail,
                  ),
                ),
                SizedBox(
                  height: 13.h,
                ),
                ElevatedButton(
                  onPressed: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.question,
                      animType: AnimType.scale,
                      title: 'Konfirmasi Logout',
                      desc: 'Apakah Anda yakin ingin logout?',
                      btnCancelOnPress: () {
                        print('Logout dibatalkan');
                      },
                      btnOkOnPress: () {
                        _logout(context);
                        print('Token: $_token');
                        print('Clicked Logout');
                      },
                      btnOkColor: Colors.red,
                      btnCancelColor: Colors.grey,
                      btnOkText: 'Ya',
                      btnCancelText: 'Tidak',
                    ).show();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.r),
                    ),
                  ),
                  child: Text(
                    'Logout',
                    style: logoutBtn,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
