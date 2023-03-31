import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import '../Modal/WishModel.dart';
import '../Provider/FavouriteProvider.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouritesScreen> {
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            title: Text(
              'Favourites',
              style: GoogleFonts.abyssinicaSil(
                  fontWeight: FontWeight.bold, fontSize: 24 , color: Colors.black),
            ),
            actions: [
              context.watch<Wish>().getWishItems.isEmpty
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () {
                        CupertinoAlertDialog(
                          title: new Text("Clear Favourites"),
                          content: new Text(
                              "Are you sure you want to clear Favourites?"),
                          actions: [
                            CupertinoDialogAction(
                                isDefaultAction: true,
                                child: Text('Yes'),
                                onPressed: () {
                                  context.read<Wish>().clearWishlist();
                                  Navigator.pop(context);
                                }),
                            CupertinoDialogAction(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      },
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.black,
                      ))
            ],
          ),
          body: context.watch<Wish>().getWishItems.isNotEmpty
              ? const WishItems()
              : const EmptyWishlist(),
        ),
      ),
    );
  }
}

class EmptyWishlist extends StatelessWidget {
  const EmptyWishlist({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'No Favourites',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}

class WishItems extends StatelessWidget {
  const WishItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Wish>(
      builder: (context, wish, child) {
        // return ListView.builder(
        //     itemCount: wish.count,
        //     itemBuilder: (context, index) {
        //       final product = wish.getWishItems[index];
        //       return WishlistModel(
        //         product: product,
        //       );
        //     });
        return StaggeredGridView.countBuilder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: wish.count,
            crossAxisCount: 2,
            itemBuilder: (context, index) {
              final product = wish.getWishItems[index];
              return WishlistModel(product: product);
            },
            staggeredTileBuilder: (context) => const StaggeredTile.fit(1));
      },
    );
  }
}
