import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/FavouriteProvider.dart';
import '../Provider/Product Provider.dart';

class WishlistModel extends StatelessWidget {
  const WishlistModel({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: const EdgeInsets.all(5.0),
    //   child: Card(
    //       child: Row(
    //         children: [
    //           ClipRRect(
    //             borderRadius: BorderRadius.circular(5),
    //             child: Container(
    //               constraints: BoxConstraints(minHeight: 100, maxHeight: 200),
    //               child: Image(fit: BoxFit.cover,
    //                 image: NetworkImage(product.imagesUrl.first),
    //               ),
    //             ),
    //           ),
    // Flexible(
    //   child: Padding(
    //     padding: const EdgeInsets.all(6.0),
    //     child: Column(
    //       children: [
    //         Text(
    //           product.name,
    //           maxLines: 1,
    //           overflow: TextOverflow.ellipsis,
    //           style: TextStyle(
    //               fontSize: 16,
    //               fontWeight: FontWeight.w600,
    //               color: Colors.grey.shade700),
    //         ),
    //         Text(
    //           product.price.toStringAsFixed(2),
    //           style: const TextStyle(
    //               fontSize: 16,
    //               fontWeight: FontWeight.bold,
    //               color: Colors.red),
    //         )
    //       ],
    //     ),
    //   ),
    // )
    //         ],
    //       )),
    // );
    return Padding(
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
                image: NetworkImage(product.imagesUrl.first),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
