import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';

Color mainColor = HexColor('#183E4B');

TextStyle splashTitle = GoogleFonts.poppins(
  fontSize: 48.sp,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

TextStyle homeWelcome = GoogleFonts.poppins(
  fontSize: 20.sp,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

TextStyle whiteOnBtn = GoogleFonts.poppins(
  fontSize: 16.sp,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);

TextStyle homeTitle = GoogleFonts.poppins(
  fontSize: 16.sp,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

TextStyle seeAll = GoogleFonts.poppins(
  fontSize: 16.sp,
  fontWeight: FontWeight.w400,
  color: mainColor,
);

TextStyle appBar = GoogleFonts.poppins(
  fontSize: 20.sp,
  fontWeight: FontWeight.w600,
  color: HexColor('#1B1E28'),
);

TextStyle profileName = GoogleFonts.poppins(
  fontSize: 24.sp,
  fontWeight: FontWeight.w500,
  color: HexColor('#1B1E28'),
);

TextStyle profileEmail = GoogleFonts.poppins(
  fontSize: 13.sp,
  fontWeight: FontWeight.w400,
  color: HexColor('#7D848D'),
);

TextStyle logoutBtn = GoogleFonts.poppins(
  fontSize: 16.sp,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);