// ignore_for_file: depend_on_referenced_packages

import 'package:amar_bongo_app/presentation/constants/color.dart';
import 'package:amar_bongo_app/presentation/constants/string.dart';
import 'package:amar_bongo_app/presentation/pages/bottom_nav/bottom.dart';
import 'package:amar_bongo_app/presentation/pages/home/home.dart';
import 'package:amar_bongo_app/presentation/pages/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BongoApp extends StatelessWidget {
  const BongoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: TextTheme(
              headline1: GoogleFonts.openSans(
                  fontSize: 72.0,
                  color: AppColor.redColor,
                  fontWeight: FontWeight.bold),
              headline6: GoogleFonts.openSans(
                  fontSize: 32.0,
                  color: AppColor.redColor,
                  fontWeight: FontWeight.w600),
              bodyText2: GoogleFonts.openSans(
                fontSize: 14.0,
                color: AppColor.goldenColor,
              )),
          primaryColor: AppColor.primaryColor,
          scaffoldBackgroundColor: AppColor.bgColor),
      debugShowCheckedModeBanner: false,
      title: AppString.appName,
      home: BottomNavPage(),
    );
  }
}
