import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:final2/PaymentScreens/Payment_1_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/FavouriteProvider.dart';
import '../../Provider/Product Provider.dart';

class ProductModel extends StatelessWidget {
  final dynamic products;

  const ProductModel({
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
        padding: EdgeInsets.all(6),
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(offset: Offset(3,3), spreadRadius: 0.3 , color: Color(0xffcceac8))],
              border: Border.all(color: Colors.black, width: 2),
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Column(children: [
            Padding(
              padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  constraints: BoxConstraints(minHeight: 100, maxHeight: 200),
                  child: Image(
                    image: NetworkImage(products['proimages'][0]),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Container(
                height: MediaQuery.of(context).size.height / 10,
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.black),
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                  Align(
                    child: Center(
                      child: Text(
                        products['proname'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.abyssinicaSil(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  Divider(color: Colors.black),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ('₹ ') + products['price'].toStringAsFixed(2),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.abyssinicaSil(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      products['sid'] == FirebaseAuth.instance.currentUser!.uid
                          ? IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit,
                                color: Colors.black,
                              ),
                            )
                          : Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    context
                                                .read<Wish>()
                                                .getWishItems
                                                .firstWhereOrNull((Product) =>
                                                    Product.documentId ==
                                                    products['proid']) !=
                                            null
                                        ? context.read<Wish>().removeThis(products['proid'])
                                        : context.read<Wish>().addWishItem(
                                            products['proname'],
                                            products['price'],
                                            products['proimages'],
                                            products['proid'],
                                            products['sid']);
                                  },
                                  icon:context
                                      .watch<Wish>()
                                      .getWishItems
                                      .firstWhereOrNull((Product) =>
                                  Product.documentId ==
                                      products['proid']) !=
                                      null ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ) : Icon(
                                    Icons.favorite_outline_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                                Icon(
                                  Icons.lock,
                                  color: Colors.grey.shade800,
                                )
                              ],
                            )
                    ],
                  )
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
