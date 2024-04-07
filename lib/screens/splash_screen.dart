import 'package:download_video/screens/app_screen.dart';
import 'package:download_video/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_update/in_app_update.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AppUpdateInfo? _updateInfo;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void _showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(SnackBar(
        content: Text(text),
      ));
    }
  }

  @override
  void initState() {
    if (_updateInfo?.updateAvailability == UpdateAvailability.updateAvailable) {
      InAppUpdate.performImmediateUpdate().catchError((e) {
        _showSnack(e.toString());
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const AppScreen(),
          ),
        );
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.bg,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 20.h,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "HM",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 80,
                      color: CustomColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Video downloader",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      fontSize: 35,
                      color: CustomColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Very fast, secure and private",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: CustomColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Supports",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      fontSize: 50,
                      color: CustomColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "multiple",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                          fontSize: 35,
                          color: CustomColors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        "Source",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                          fontSize: 45,
                          color: CustomColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "HM video Downloaderis the easiest application to download videos from multiple sources.",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: CustomColors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
