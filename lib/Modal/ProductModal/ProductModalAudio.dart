import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import '../../PaymentScreens/Payment_1_screen.dart';

class ProductModelAudio extends StatelessWidget {
  final dynamic products;

  const ProductModelAudio({
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
                builder: (context) => PlaceOrder(
                      products: products,
                      titleName: products['proname'],
                      image: products['proimages'][0],
                      Price: products['price'].toStringAsFixed(2),
                    )));
      },
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(offset: Offset(3,3), spreadRadius: 0.3 , color: Color(0xffcceac8))],
              border: Border.all(color: Colors.black, width: 2),
              color: Colors.white,
              borderRadius: BorderRadius.circular(7)),
          child: Column(children: [
            Padding(
              padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  constraints: BoxConstraints(minHeight: 100, maxHeight: 200),
                  child: Image(
                    image: NetworkImage(products['proimages'][0]),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Column(children: [
                Container(
                  height: MediaQuery.of(context).size.height / 28,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.black),
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      products['proname'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.abyssinicaSil(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
