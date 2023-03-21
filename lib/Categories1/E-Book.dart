import 'package:flutter/material.dart';

import '../Minor_screen/SubCategoryScreen.dart';

class EbookScreen extends StatefulWidget {
  const EbookScreen({Key? key}) : super(key: key);

  @override
  State<EbookScreen> createState() => _EbookScreenState();
}

class _EbookScreenState extends State<EbookScreen> {
  var colorArray = [
    Color(0xfffeeac0),
    Color(0xff7147e8),
    Color(0xffcafef6),
    Color(0xffb3a0cf),
    Color(0xfff3c664),
    Color(0xfffebde5),
    Colors.amber,
    Colors.deepOrangeAccent,
    Colors.grey,
    Colors.black12,
    Colors.blueAccent,
    Colors.deepPurpleAccent,
    Colors.yellowAccent,
    Colors.blueGrey,
    Colors.pink,
    Colors.red,
    Colors.orange,
    Colors.green,
  ];

  var Track = [
    'Pdf1',
    'Pdf2',
    'Pdf3',
    'Pdf4',
    'Pdf5',
    'Pdf6',
    'Pdf7',
    'Pdf8',
    'Pdf9',
    'Pdf10',
    'Pdf11',
    'Pdf12',
    'Pdf13',
    'Pdf14',
    'Pdf15',
    'Pdf16',
    'Pdf17',
    'Pdf18',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemCount: Track.length,
                itemBuilder: (BuildContext, index) {
                  return InkWell(
                    onTap: (){
                      Navigator.push((context), MaterialPageRoute(builder: (context) => SubCategoryProduct(SubCategoryName: Track[index], index: index)));
                    },
                    child: Stack(children: [
                      Container(
                        decoration: BoxDecoration(
                          color: colorArray[index],
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      // Positioned(
                      //   top: 175,
                      //   left: 10,
                      //   child: Text(
                      //     Track[index],
                      //     style: GoogleFonts.abyssinicaSil(
                      //       color: Colors.black,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      // ),
                    ]),
                  );
                }
            ),
          )
        ],
      ),
    );
  }
}