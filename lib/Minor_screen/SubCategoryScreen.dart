import 'package:final2/Color/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubCategoryProduct extends StatelessWidget {
  final String SubCategoryName;
  final int index;
  const SubCategoryProduct({Key? key, required this.SubCategoryName, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [ colorArray[index] , Color(0xffffffff)]
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            SubCategoryName,
            style: GoogleFonts.abyssinicaSil(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
           icon: Icon(Icons.arrow_back_ios_new ,color: Colors.black,),
          ),
        ),
      ),
    );
  }
}
