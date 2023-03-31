import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Minor_screen/SearchScreen.dart';

class fakesearch extends StatelessWidget {
  const fakesearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> category = [
      'Focus',
      'Podcast',
      'Sleep',
      'Deep Focus',
      'Kids',
      'Productivity',
      'Ambient Sound',
      'Free'
    ];
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SearchScree()));
      },
      child: Container(
        height: 45,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 0.5),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.search_sharp,
                color: Colors.black,
              ),
            ),
            Text(
              'What are you looking for?',
              style: GoogleFonts.abyssinicaSil(
                  fontWeight: FontWeight.w500, color: Colors.black),
            ),
            // DefaultTextStyle(
            //   style: GoogleFonts.abyssinicaSil(
            //       fontSize: 30.0,
            //       fontWeight: FontWeight.w500,
            //       color: Colors.black),
            //   child: AnimatedTextKit(
            //     animatedTexts: [
            //       TypewriterAnimatedText(
            //         'Searching for Focus',
            //         textStyle: GoogleFonts.abyssinicaSil(
            //             fontSize: 20.0,
            //             fontWeight: FontWeight.w500,
            //             color: Colors.black),
            //         speed: Duration(milliseconds: 100),
            //       ),
            //     ],
            //     onTap: () {
            //       print("Tap Event");
            //     },
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(right: 2),
              child: Container(
                height: 40,
                width: 70,
                decoration: BoxDecoration(
                    color: Colors.grey.shade600,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                    child: Text(
                  'Search',
                  style: GoogleFonts.abyssinicaSil(
                      fontWeight: FontWeight.w500, color: Colors.white),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
