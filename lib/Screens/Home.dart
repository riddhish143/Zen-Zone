import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final2/Modal/ProductModal/ProductModalAudio.dart';
import 'package:final2/Widgets/Carousal.dart';
import 'package:final2/Widgets/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import '../Modal/ProductModal/ProductModalBook1.dart';

class HomeScreen extends StatefulWidget {
  final String documentId;

  const HomeScreen({Key? key, required this.documentId}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  CollectionReference customer =
      FirebaseFirestore.instance.collection('customer');
  CollectionReference anonymous =
      FirebaseFirestore.instance.collection('anonymous');
  final Stream<QuerySnapshot> _productStream =
      FirebaseFirestore.instance.collection('products').snapshots();

  Widget build(BuildContext context) {
    Future<void> _handleRefresh() async {
      await Future.delayed(Duration(milliseconds: 500));
    }

    return FutureBuilder<DocumentSnapshot>(
        future: customer.doc(widget.documentId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return SafeArea(child: const Text("Something went wrong"));
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return SafeArea(child: const Text("Document does not exist"));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Scaffold(
              backgroundColor: Colors.white,
              drawer: NavDrawer(
                  email: data['email'],
                  Name: data['name'],
                  Image: data['profileimage']),
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.black),
                elevation: 0,
                backgroundColor: Colors.white,
                title: Text(
                  'FeelBetter',
                  style: GoogleFonts.abyssinicaSil(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                actions: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: InkWell(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(data['profileimage']))),
                      ),
                    ),
                  ),
                ],
              ),
              body: LiquidPullToRefresh(
                animSpeedFactor: 20,
                springAnimationDurationInMilliseconds: 1000,
                showChildOpacityTransition: false,
                color: Colors.black,
                onRefresh: _handleRefresh,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      DestinationCarousal(),
                      SizedBox(
                        height: 10,
                      ),
                      ProfileHeaderLabel(headerLabel: 'Recommended Meditation'),
                      StreamBuilder<QuerySnapshot>(
                        stream: _productStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (snapshot.data!.docs.isEmpty) {
                            return Container(
                              height: MediaQuery.of(context).size.height * .4,
                              child: Center(
                                  child: Text(
                                'This category \n has no Recommended Meditation items yet !',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.abyssinicaSil(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              )),
                            );
                          }

                          return SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            child: Container(
                              height: MediaQuery.of(context).size.height / 3,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.all(10),
                                // child: StaggeredGridView.countBuilder(
                                //     physics: const NeverScrollableScrollPhysics(),
                                //     shrinkWrap: true,
                                //     itemCount: snapshot.data!.docs.length,
                                //     crossAxisCount: 2,
                                //     itemBuilder: (context, index) {
                                //       return ProductModelAudio(
                                //         products: snapshot.data!.docs[index],
                                //       );
                                //     },
                                //     staggeredTileBuilder: (context) =>
                                //         const StaggeredTile.fit(1)),
                                child: ListView.builder(
                                    itemCount: snapshot.data!.docs.length,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return ProductModelAudio(
                                        products: snapshot.data!.docs[index],
                                      );
                                    }),
                              ),
                            ),
                          );
                        },
                      ),
                      BooksHomeView(),
                    ],
                  ),
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        });
  }
}

class ProfileHeaderLabel extends StatelessWidget {
  final String headerLabel;

  const ProfileHeaderLabel({Key? key, required this.headerLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .95,
      height: MediaQuery.of(context).size.height / 28,
      child: SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 14),
              child: Text(
                headerLabel,
                style: GoogleFonts.abyssinicaSil(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BooksHomeView extends StatefulWidget {
  const BooksHomeView({Key? key}) : super(key: key);

  @override
  State<BooksHomeView> createState() => _BooksHomeViewState();
}

class _BooksHomeViewState extends State<BooksHomeView> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productStream =
        FirebaseFirestore.instance.collection('Book_detail').snapshots();
    return Column(
      children: [
        ProfileHeaderLabel(headerLabel: 'Recommended Books'),
        StreamBuilder<QuerySnapshot>(
          stream: _productStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data!.docs.isEmpty) {
              return Container(
                height: MediaQuery.of(context).size.height * .4,
                child: Center(
                    child: Text(
                  'This category \n has no Recommended Meditation items yet !',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.abyssinicaSil(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                )),
              );
            }
            return SizedBox(
              height: MediaQuery.of(context).size.height/3,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(0),
                // child: StaggeredGridView.countBuilder(
                //     physics: const NeverScrollableScrollPhysics(),
                //     shrinkWrap: true,
                //     itemCount: snapshot.data!.docs.length,
                //     crossAxisCount: 2,
                //     itemBuilder: (context, index) {
                //       return ProductModelBook1(
                //         products: snapshot.data!.docs[index],
                //       );
                //     },
                //     staggeredTileBuilder: (context) =>
                //         const StaggeredTile.fit(1)),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return ProductModelBook1(
                          products: snapshot.data!.docs[index]);
                    }),
              ),
            );
          },
        )
      ],
    );
  }
}
