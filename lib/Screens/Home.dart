import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final2/Modal/ProductModal.dart';
import 'package:final2/Modal/ProductModelHomeScreen.dart';
import 'package:final2/Widgets/Carousal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

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
              appBar: AppBar(
                elevation: 0,
                title: Text(
                  'FeelBetter',
                  style: GoogleFonts.abyssinicaSil(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                backgroundColor: Colors.white,
                leading: Icon(
                  Icons.density_medium,
                  size: 30,
                  color: Colors.black,
                ),
                actions: [
                  InkWell(
                //     onTap: (){
                //       Navigator.pushReplacementNamed(context, ProfileScreen.id);
                // },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.black54,
                        backgroundImage: NetworkImage(data['profileimage']),
                      ),
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    DestinationCarousal(),
                    SizedBox(height: 10,),
                    ProfileHeaderLabel(headerLabel: 'Recommended Meditation'),
                    StreamBuilder<QuerySnapshot>(
                      stream: _productStream,
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.data!.docs.isEmpty) {
                          return  Container(
                            height: MediaQuery.of(context).size.height*.4,
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

                        return SingleChildScrollView(
                          padding: EdgeInsets.all(10),
                          child: StaggeredGridView.countBuilder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              crossAxisCount: 2,
                              itemBuilder: (context, index) {
                                return ProductModelHomeScreen(products: snapshot.data!.docs[index],);
                              },
                              staggeredTileBuilder: (context) => const StaggeredTile.fit(1)),
                        );
                      },
                    )
                  ],
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
      width: MediaQuery.of(context).size.width*.95,
      child: SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
              width: 50,
              child: Divider(
                color: Colors.black,
                thickness: 1,
              ),
            ),
            SizedBox(width: 20,),
            Text(
              headerLabel,
              style: GoogleFonts.abyssinicaSil(
                  color: Colors.black, fontSize: 24, fontWeight: FontWeight.normal),
            ),
            SizedBox(width: 20,),
            const SizedBox(
              height: 40,
              width: 50,
              child: Divider(
                color: Colors.black,
                thickness: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}