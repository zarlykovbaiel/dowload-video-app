import 'dart:io';

import 'package:download_video/utils/custom_colors.dart';
import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  final PageController _pageController = PageController();
  final FileManagerController _controller = FileManagerController();
  List<VideoData> _videoData = [];
  List<FileSystemEntity> _downloads = [];
  int _selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> _getDownloads() async {
    setState(() {
      _downloads = [];
      _videoData = [];
    });
    final videoInfo = FlutterVideoInfo();
    final directory = await getApplicationDocumentsDirectory();
    final dir = directory.path;
    final myDir = Directory(dir);
    List<FileSystemEntity> folders =
        myDir.listSync(recursive: true, followLinks: false);
    List<FileSystemEntity> data = [];

    for (var item in folders) {
      if (item.path.contains(".mp4")) {
        data.add(item);
        var info = await videoInfo.getVideoInfo(item.path);
        _videoData.add(info!);
      }
    }
    setState(() {
      _downloads = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.bg,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: CustomColors.bg,
          elevation: 0,
          title: Text(
            "HM Video downloader",
            style: GoogleFonts.poppins(
                fontSize: 26,
                color: CustomColors.white,
                fontWeight: FontWeight.w500),
          ),
        ),
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            SizedBox(),
            SizedBox(),
            SizedBox(),
            SizedBox(),
          ],
        ),
        bottomNavigationBar: WaterDropNavBar(
          backgroundColor: CustomColors.bg,
          bottomPadding: 12.h,
          waterDropColor: CustomColors.primary,
          inactiveIconColor: CustomColors.primary,
          iconSize: 28.w,
          onItemSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
            _pageController.jumpToPage(_selectedIndex);
          },
          selectedIndex: _selectedIndex,
          barItems: [
            BarItem(filledIcon: Icons.home, outlinedIcon: Icons.home_outlined),
            BarItem(
                filledIcon: Icons.file_download,
                outlinedIcon: Icons.download_outlined),
            BarItem(
                filledIcon: Icons.video_library_rounded,
                outlinedIcon: Icons.video_library_outlined),
            BarItem(filledIcon: Icons.info, outlinedIcon: Icons.info_outline),
          ],
        ));
  }
}
