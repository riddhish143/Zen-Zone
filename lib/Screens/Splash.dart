import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/OnBoarding_screen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe5dfe4),
      body: SafeArea(
        child: Stack(
          children: [
            //
            Align(
              alignment: AlignmentDirectional(0.11, -0.07),
              child: Container(
                width: 250,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Align(
                  alignment: AlignmentDirectional(0, 0.03),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    child: Row(
                      children: [
                        Text(
                          'Zen',
                          style: GoogleFonts.abyssinicaSil(
                              fontWeight: FontWeight.w600,
                              fontSize: 40,
                              color: Colors.black),
                        ),
                        Text(
                          ' - Zone',
                          style: GoogleFonts.abyssinicaSil(
                              fontWeight: FontWeight.w600,
                              fontSize: 40,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
