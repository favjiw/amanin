import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_flutter3/generated/assets.dart';
import 'package:mobile_flutter3/shared/style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late bool _isPasswordVisible;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isPasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 36.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100.h,),
                  Center(
                    child: Image.asset(Assets.assetsLogoImg, width: 153.w, height: 153.h,),
                  ),
                  SizedBox(height: 60.h,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 9.w),
                  child: Text('Sign in', style: signTitle,),),
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
                  SizedBox(height: 5.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot Password?",
                          style: forgotPassword,
                        ),
                      ),
                    ],
                  ),
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
                        onPressed: () {
                          // login(_emailController.text,
                          //     _passwordController.text);
                        },
                        child: Text(
                          "SIGN IN",
                          style: whiteOnBtn,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 100.h,),
                  Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Belum memiliki akun? ",
                          style: noAcc,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text(
                            "Sign Up",
                            style: forgotPassword,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
