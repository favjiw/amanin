import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_flutter3/generated/assets.dart';
import 'package:mobile_flutter3/shared/style.dart';

class CreateLaporanScreen extends StatefulWidget {
  const CreateLaporanScreen({super.key});

  @override
  State<CreateLaporanScreen> createState() => _CreateLaporanScreenState();
}

class _CreateLaporanScreenState extends State<CreateLaporanScreen> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  String? _selectedValue;
  final List<String> _dropdownValues = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
  ];

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
          title: Text('Tambah Laporan'),
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 36.w),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                    child: Container(
                      height: 174.h,
                      width: 174.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                          child: Image.asset(
                        Assets.assetsCameraImg,
                        width: 100.w,
                        height: 87.h,
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 59.h,
                  ),
                  TextFormField(
                    controller: _locationController,
                    style: loginOnInput,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
                      hintText: 'Lokasi Kejadian',
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
                      prefixIcon: Icon(
                        Icons.location_on,
                        color: HexColor('#807A7A'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  DropdownButtonFormField<String>(
                    hint: Text('Jenis Kriminalitas'),
                    style: loginOnInput,
                    borderRadius: BorderRadius.circular(12.r),
                    icon: Icon(Icons.keyboard_arrow_down_rounded, color: HexColor('#807A7A'),),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.warning_amber_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: HexColor("#353535").withOpacity(0.4),
                          width: 1.w,
                        ),
                      ),
                    ),
                    value: _selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedValue = newValue;
                      });
                    },
                    items: _dropdownValues.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  TextFormField(
                    controller: _descController,
                    style: loginOnInput,
                    decoration: InputDecoration(
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
                      hintText: 'Deskripsi Kejadian',
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
                      prefixIcon: Icon(
                        Icons.edit,
                        color: HexColor('#807A7A'),
                      ),
                    ),
                  ),
                  SizedBox(height: 77.h,),
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
                          "KIRIM LAPORAN",
                          style: whiteOnBtn,
                        ),
                      ),
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
