import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_flutter3/generated/assets.dart';
import 'package:mobile_flutter3/services/auth_services.dart';
import 'package:mobile_flutter3/shared/style.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late bool _isPasswordVisible;
  late bool _isConfirmPasswordVisible;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isPasswordVisible = false;
    _isConfirmPasswordVisible = false;

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title:  Text('Sign up'),
          titleTextStyle: appBar,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: HexColor('#000000'),
            ),
            onPressed: () {
              // Handle button press
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.symmetric(horizontal: 36.w),
          child: SizedBox(
            width: 390.w,
            height: 710.h,
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30.h,),
                  TextFormField(
                    controller: _usernameController,
                    style: loginOnInput,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
                      hintText: 'username',
                      hintStyle: loginOffInput,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: HexColor("#353535").withOpacity(0.4),
                          width: 1.w,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                        borderSide: BorderSide(
                          color: HexColor("#85B1B4"),
                          width: 2.w,
                        ),
                      ),
                      prefixIcon: Image.asset(Assets.assetsUsernameIc),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  TextFormField(
                    controller: _emailController,
                    style: loginOnInput,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
                      hintText: 'abc@gmail.com',
                      hintStyle: loginOffInput,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: HexColor("#353535").withOpacity(0.4),
                          width: 1.w,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                        borderSide: BorderSide(
                          color: HexColor("#85B1B4"),
                          width: 2.w,
                        ),
                      ),
                      prefixIcon: Image.asset(Assets.assetsMailIc),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    style: loginOnInput,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
                      hintText: 'Your password',
                      hintStyle: loginOffInput,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: HexColor("#353535").withOpacity(0.4),
                          width: 1.w,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                        borderSide: BorderSide(
                          color: HexColor("#85B1B4"),
                          width: 2.w,
                        ),
                      ),
                      prefixIcon: Image.asset(Assets.assetsPasswIc),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: !_isConfirmPasswordVisible,
                    style: loginOnInput,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                          });
                        },
                        icon: Icon(
                          _isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
                      hintText: 'Confirm password',
                      hintStyle: loginOffInput,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: HexColor("#353535").withOpacity(0.4),
                          width: 1.w,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                        borderSide: BorderSide(
                          color: HexColor("#85B1B4"),
                          width: 2.w,
                        ),
                      ),
                      prefixIcon: Image.asset(Assets.assetsPasswIc),
                    ),
                  ),
                  SizedBox(height: 50.h,),
                  Center(
                    child: SizedBox(
                      width: 271.w,
                      height: 60.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r)
                            )
                        ),
                        onPressed: () async {
                          final authService = AuthService();

                          // Validasi input
                          if (_passwordController.text != _confirmPasswordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Passwords do not match")),
                            );
                            return;
                          }

                          // Panggil service register
                          final result = await authService.register(
                            username: _usernameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            confirmPassword: _confirmPasswordController.text,
                          );

                          if (result['success']) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Registration successful, please login")),
                            );
                            Navigator.pop(context);
                          } else {
                            // Tampilkan pesan error
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(result['message'])),
                            );
                          }
                        },
                        child: Text(
                          "SIGN UP",
                          style: whiteOnBtn,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sudah memiliki akun? ",
                          style: noAcc,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Sign In",
                            style: forgotPassword,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h,),
                ],
              ),
            ),
          ),),
        ),
      ),
    );
  }
}
