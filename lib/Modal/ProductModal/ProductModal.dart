import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:final2/Minor_screen/BottomModalSheet.dart';
import 'package:final2/Screens/Musicplayer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/FavouriteProvider.dart';

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
                builder: (context) => BottomModel(
                      products: products,
                      titleName: products['proname'],
                      image: products['proimages'][0],
                      Price: products['price'].toStringAsFixed(2),
                    )));
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => MusicPlayer(
        //               titleName: products['proname'],
        //               image: products['proimages'][0],
        //             )));
      },
      child: Padding(
        padding: EdgeInsets.all(6),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Column(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                constraints: BoxConstraints(minHeight: 100, maxHeight: 200),
                child: Image(
                  image: NetworkImage(products['proimages'][0]),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(children: [
                Align(
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
                  alignment: Alignment.topLeft,
                ),
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
                                  // Provider.of<Wish>(context , listen: false)
                                  //             .getWishItems
                                  //             .firstWhereOrNull((products) =>
                                  //                 products.documentId ==
                                  //                 products['proid']) !=
                                  //         null
                                  //     ? ScaffoldMessenger.of(context)
                                  //         .showSnackBar(SnackBar(
                                  //         elevation: 0,
                                  //         behavior: SnackBarBehavior.floating,
                                  //         backgroundColor: Colors.transparent,
                                  //         content: AwesomeSnackbarContent(
                                  //           title: 'On Snap!',
                                  //           message: 'Already in Cart',
                                  //           contentType: ContentType.failure,
                                  //         ),
                                  //       ))
                                  context
                                              .read<Wish>()
                                              .getWishItems
                                              .firstWhereOrNull((Product) =>
                                                  Product.documentId ==
                                                  products['proid']) !=
                                          null
                                      ? ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                          SnackBar(
                                            elevation: 0,
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.transparent,
                                            content: AwesomeSnackbarContent(
                                              title: 'On Snap!',
                                              message: 'Already in Cart',
                                              contentType: ContentType.failure,
                                            ),
                                          ),
                                        )
                                      : context.read<Wish>().addWishItem(
                                          products['proname'],
                                          products['price'],
                                          products['proimages'],
                                          products['sid']
                                  );
                                },
                                icon: Icon(
                                  Icons.favorite_border_outlined,
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
          ]),
        ),
      ),
    );
  }
}
