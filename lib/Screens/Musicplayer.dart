import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MusicPlayer extends StatefulWidget {
  final String titleName;
  final String image;
  final String AuthorName;

  MusicPlayer({Key? key, required this.titleName, required this.image, required this.AuthorName})
      : super(key: key);
  static const String id = '/Music_player';

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  final player = AudioPlayer();
  Duration? duration = Duration(seconds: 0);

  void initPlayer() async {
    await player.setSource(AssetSource(""));
    duration = await player.getDuration();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlayer();
  }

  @override
  Widget build(BuildContext context) {
    bool isPlaying = false;
    double value = 0;
    var ScreenHeight = MediaQuery.of(context).size.height;
    var ScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: ScreenHeight / 2,
            minWidth: ScreenWidth,
          ),
          child: Container(
            height: ScreenHeight / 2,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    image: NetworkImage(widget.image))),
          ),
        ),
        SizedBox(height: ScreenHeight/50,),
        Center(
          child: Text(
            widget.titleName,
            style: GoogleFonts.abyssinicaSil(
                fontWeight: FontWeight.w500, fontSize: 30, color: Colors.black),
          ),
        ),
        Row(
          children: [
           // Text('00 : 00' , style: TextStyle(color: Colors.black),),
            // Slider.adaptive(value: value, onChanged: (value){} , activeColor: Colors.black , ),
          ],
        )

      ]),
    );
  }
}
