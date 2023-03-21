import 'package:final2/Widgets/Carousal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'FeelBetter',
          style: GoogleFonts.abyssinicaSil(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.density_medium,
          size: 30,
          color: Colors.black,
        ),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.black54,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          DestinationCarousal(),
        ],
      ),
    );
  }
}
