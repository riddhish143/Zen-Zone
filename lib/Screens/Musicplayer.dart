import 'package:final2/Widgets/MusicCarousal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({Key? key}) : super(key: key);
  static const String id = '/Music_player';

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  @override
  Widget build(BuildContext context) {
    var ScreenHeight = MediaQuery.of(context).size.height;
    var ScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage('images/MusicPlayer/justin.jpeg'),
                    fit: BoxFit.cover)),
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            leading: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),

          Positioned(
            left: ScreenHeight * 0.1,
            top: ScreenHeight * .50,
            child: Center(
              child: Text(
                'Justin',
                style: GoogleFonts.abyssinicaSil(
                    color: Colors.white, fontSize: 90),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
