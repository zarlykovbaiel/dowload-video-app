import 'package:download_video/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
        360,
        690,
      ),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, widget) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: const SplashScreen(),
        builder: (context, widget) {
          ScreenUtil.registerToBuild(context);
          return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.0)),
              child: widget!);
        },
      ),
    );
  }
}
