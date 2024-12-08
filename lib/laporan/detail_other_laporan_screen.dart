import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_flutter3/Model/Laporan.dart';
import 'package:mobile_flutter3/services/laporan_services.dart';
import 'package:mobile_flutter3/services/report_services.dart';
import 'package:mobile_flutter3/shared/style.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class DetailOtherLaporanScreen extends StatefulWidget {
  final Laporan laporan;

  const DetailOtherLaporanScreen({super.key, required this.laporan});

  @override
  State<DetailOtherLaporanScreen> createState() => _DetailOtherLaporanScreenState();
}

class _DetailOtherLaporanScreenState extends State<DetailOtherLaporanScreen> {
  ReportServices reportServices = ReportServices();
  final TextEditingController _descController = TextEditingController();
  String? token;

  Future<void> loadToken() async {
    final storage = FlutterSecureStorage();
    final fetchedToken = await storage.read(key: 'auth_token');
    if (fetchedToken != null) {
      setState(() {
        token = fetchedToken;
      });
    } else {
      // Token tidak ditemukan, lakukan sesuatu
    }
  }

  Future<String> getImageUrl(String laporanId) async {
    try {
      final imageUrl = await LaporanService().fetchImage(laporanId);
      print("THIS IS IMAGE URL: ${imageUrl}");
      return imageUrl;
    } catch (e) {
      print('Error fetching image URL: $e');
      return '';
    }
  }

  String formatTanggal(String rawDate) {
    DateTime date = DateTime.parse(rawDate);

    String formattedDate = DateFormat('d MMM yyyy').format(date);

    return formattedDate;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadToken();
  }

  @override
  Widget build(BuildContext context) {
    final laporan = widget.laporan;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Detail Laporan',
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.report,
              color: Colors.black,
            ),
            onPressed: () {
              // Menampilkan pop-up dialog
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Alasan Melaporkan Pengaduan'),
                    titleTextStyle: appBar,
                    content: TextField(
                      controller: _descController,
                      style: loginOnInput,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Masukkan alasan Anda...',
                        hintStyle: loginOffInput,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Menutup dialog
                        },
                        child: Text('Batal', style: abortBtn,),
                      ),
                      TextButton(
                        onPressed: () async {
                          try {
                            await reportServices.createReport(
                              laporanId: laporan.id,
                              userId: laporan.userId,
                              description: _descController.text,
                            );
                            Navigator.of(context).pop();
                            // AwesomeDialog(
                            //   context: context,
                            //   dialogType: DialogType.question,
                            //   animType: AnimType.scale,
                            //   titleTextStyle: appBar,
                            //   descTextStyle: detailValue,
                            //   buttonsTextStyle: whiteOnBtn,
                            //   title: 'Berhasil report laporan',
                            //   desc: 'Anda berhasil report laporan ini',
                            //   btnOkColor: Colors.green,
                            //   btnOkText: 'Oke',
                            // ).show();
                          } catch (e) {
                            print('Error: $e');
                          }
                          Navigator.of(context).pop(); // Menutup dialog
                        },
                        child: Text('Kirim', style: sendBtn,),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
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
        titleTextStyle: appBar,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 26.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Container(
                  width: 301.w,
                  padding: EdgeInsets.only(bottom: 20.h),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ]),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.r),
                          topRight: Radius.circular(15.r),
                        ),
                        child: buildLaporanImage(laporan.id.toString()),
                      ),
                      SizedBox(height: 13.h),
                      Text(
                        laporan.title,
                        style: detailTitle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 55.h,
              ),
              Center(
                child: Container(
                  width: 337.w,
                  padding:
                  EdgeInsets.symmetric(horizontal: 23.w, vertical: 14.h),
                  decoration: BoxDecoration(
                    color: HexColor('#EAEAEA'),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tanggal Laporan:',
                            style: detailLabel,
                          ),
                          Text(
                            laporan.status,
                            style: detailStatus,
                          ),
                        ],
                      ),
                      Text(
                        formatTanggal(laporan.datetime),
                        style: detailValue,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Lokasi Kejadian:',
                        style: detailLabel,
                      ),
                      Text(
                        laporan.location,
                        style: detailValue,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Deskripsi:',
                        style: detailLabel,
                      ),
                      Text(
                        laporan.desc,
                        style: detailValue,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLaporanImage(String laporanId) {
    if (token == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return FutureBuilder<String>(
      future: getImageUrl(laporanId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: 301.w, height: 174.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7.r),
              ),
            ),
          );
        } else if (snapshot.hasError || snapshot.data!.isEmpty) {
          return const Icon(Icons.broken_image, size: 50);
        } else {
          final imageUrl = snapshot.data!;
          return Image.network(
            imageUrl,
            width: 301.w,
            height: 174.h,
            fit: BoxFit.cover,
            headers: {
              'Authorization': 'Bearer $token',
              'Accept': 'application/json',
            },
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.broken_image, size: 50);
            },
          );
        }
      },
    );
  }
}
