import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_flutter3/generated/assets.dart';
import 'package:mobile_flutter3/services/laporan_services.dart';
import 'package:mobile_flutter3/shared/style.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as img;

class CreateLaporanScreen extends StatefulWidget {
  const CreateLaporanScreen({super.key});

  @override
  State<CreateLaporanScreen> createState() => _CreateLaporanScreenState();
}

class _CreateLaporanScreenState extends State<CreateLaporanScreen> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  String? _selectedValue;
  File? _selectedImage;

  final List<String> _dropdownValues = [
    'Konvoi Berbahaya',
    'Pembegalan',
    'Pencurian',
    'Penganiayaan',
  ];

  Future<File> resizeImage(File imageFile) async {
    img.Image? image = img.decodeImage(imageFile.readAsBytesSync());

    if (image == null) {
      throw Exception("Gagal mendekode gambar");
    }

    img.Image resizedImage = img.copyResize(image, width: 800);

    return File(imageFile.path)..writeAsBytesSync(img.encodeJpg(resizedImage));
  }

  Future<void> _pickImage() async {
    PermissionStatus cameraStatus = await Permission.camera.request();

    if (cameraStatus.isGranted) {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);

        // Resize gambar jika ukurannya terlalu besar
        File resizedImage = await resizeImage(imageFile);

        setState(() {
          _selectedImage = resizedImage;
        });
      }
    } else {
      print('Camera permission denied');
    }
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
          title: const Text('Tambah Laporan'),
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
                    child: InkWell(
                      onTap: (){
                        _pickImage();
                      },
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
                              offset: const Offset(0, 3),
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
                        onPressed: () async {
                          if (_locationController.text.isEmpty || _descController.text.isEmpty || _selectedValue == null || _selectedImage == null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Semua kolom harus diisi dan gambar dipilih!')));
                            return;
                          }
                          try {
                            await LaporanService().createLaporanWithLocation(
                              location: _locationController.text,
                              desc: _descController.text,
                              jenisKriminalitas: _selectedValue ?? 'Lainnya',
                              imageFile: _selectedImage!, // Mengirimkan file gambar
                            );
                            Navigator.pushReplacementNamed(context, '/detailLaporan');
                          } catch (e) {
                            print('Gagal membuat laporan: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Gagal membuat laporan. Silakan coba lagi.')),
                            );
                          }
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
