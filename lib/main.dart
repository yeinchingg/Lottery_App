import 'package:flutter/material.dart';
import 'homePage.dart';
import 'package:google_fonts/google_fonts.dart';
void main () {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({Key? key}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: GoogleFonts.zcoolQingKeHuangYouTextTheme().copyWith(
          bodyLarge: GoogleFonts.zcoolQingKeHuangYou(
            fontWeight: FontWeight.w400, // Regular
            color: Colors.black,
            fontSize: 40,
          ),
          titleLarge: GoogleFonts.zcoolQingKeHuangYou(
            fontWeight: FontWeight.w400,
            fontSize: 30,
            color: Colors.black,
          ),
          bodyMedium: GoogleFonts.zcoolQingKeHuangYou(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: Colors.black,
          ),
          titleMedium: GoogleFonts.zcoolQingKeHuangYou(
            fontWeight: FontWeight.w400,
            fontSize: 20,
            color: Colors.black,
          ),


        ),
      ),
    );
  }
}