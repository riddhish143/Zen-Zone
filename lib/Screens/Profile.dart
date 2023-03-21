import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Minor_screen/TabBarPage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String ProfileName = "Profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            shadowColor: Colors.black,
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            expandedHeight: 250,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraint) {
                return FlexibleSpaceBar(
                  title: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: constraint.biggest.height <= 120 ? 1 : 0,
                    child: Text(
                      ProfileName,
                      style: GoogleFonts.abyssinicaSil(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xffcbfa5c), Color(0xffcbfa5c)]),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 33, left: 30),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 50),
                            child: Container(
                              height: 170,
                              width: MediaQuery.of(context).size.width*0.50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 22,
                                  ),
                                  TextF(
                                    text: 'Name',
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  TextF(
                                    text: 'Email',
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  TextF(
                                    text: 'Edit Profile',
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: 200,
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xffe8eaf3),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: Center(
                      child: TextF(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    text: 'Streak',
                  )),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: 60,
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xffe8eaf3),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TabBarList(color: Colors.black , width: 120 , borderradius: 10 ,fontsize: 20 ,onPressed: (){} , str: 'Statistic'),
                      TabBarList(color: Colors.black , width: 120 , borderradius: 10 ,fontsize: 20 ,onPressed: (){} , str: 'Cart'),
                      TabBarList(color: Colors.black , width: 120 , borderradius: 10 ,fontsize: 20 ,onPressed: (){} , str: 'Courses'),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TabBarList extends StatelessWidget {
  final Color color;
  final Function() onPressed;
  final double width;
  final String str;
  final double borderradius;
  final double fontsize;
  const TabBarList({
    super.key, required this.width , required this.str ,required this.onPressed , required this.color ,required this.borderradius ,required this.fontsize
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          height: MediaQuery.of(context).size.height * 0.30,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderradius),
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              str,
              style: GoogleFonts.abyssinicaSil(
                  color: color,
                  fontWeight: FontWeight.normal,
                  fontSize: fontsize),
            ),
          )),
    );
  }
}

class TextF extends StatelessWidget {
  final String text;
  var color;
  var fontWeight;
  double fontSize;

  TextF(
      {super.key,
      required this.color,
      required this.fontSize,
      required this.fontWeight,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.abyssinicaSil(
          color: color, fontWeight: fontWeight, fontSize: fontSize),
    );
  }
}
