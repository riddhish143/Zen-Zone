import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class DestinationCarousal extends StatefulWidget {
  const DestinationCarousal({Key? key}) : super(key: key);

  @override
  State<DestinationCarousal> createState() => _DestinationCarousalState();
}

class _DestinationCarousalState extends State<DestinationCarousal> {
  @override
  Widget build(BuildContext context) {
    List<Color> colorArray = [
      Color(0xfffeeac0),
      Color(0xff7147e8),
      Color(0xffcafef6),
    ];

    var sliderName = [
      'Slider1',
      'Slider2',
      'Slider3',
    ];

    List<Widget> container(int index) {
      return colorArray
          .map(
            (e) => ClipRect(
              child: Container(
                decoration: BoxDecoration(
                    color: colorArray[index],
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
          )
          .toList();
    }

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 10),
      child: Stack(
        children: [
          CarouselSlider(
              items: container(0),
              options: CarouselOptions(
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
                autoPlayCurve: Curves.bounceInOut,

              ))
        ],
      ),
    );
  }
}
