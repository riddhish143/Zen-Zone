import 'package:final2/ProfileList/Favourites.dart';
// import 'package:final2/Provider/ProductProvider.dart';
import 'package:final2/Screens/Musicplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductModelHomeScreen extends StatelessWidget {
  final dynamic products;
  const ProductModelHomeScreen({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MusicPlayer(
                      titleName: products['proname'],
                      image: products['proimages'][0],
                    )));
      },
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Column(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                constraints: BoxConstraints(minHeight: 100, maxWidth: 200),
                child: Image(
                  image: NetworkImage(products['proimages'][0]),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(children: [
                Align(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    Flexible(
                      child: Text(
                        products['proname'],
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.abyssinicaSil(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  Row(children: [
                          IconButton(
                            onPressed: () {

                            },
                            icon: Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.red,
                              size: 18,
                            ),
                          ),
                          Icon(
                            Icons.lock,
                            color: Colors.grey.shade800,
                            size: 18,
                          )
                        ])
                  ]),
                  alignment: Alignment.topLeft,
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
