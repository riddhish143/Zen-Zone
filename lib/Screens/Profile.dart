import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// final _firestore = FirebaseFirestore.instance;

class ProfileScreen extends StatefulWidget {
  final String documentId;
  static const String id='/Profile_screen';
  const ProfileScreen({Key? key, required this.documentId}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customer');
  CollectionReference anonymous =
      FirebaseFirestore.instance.collection('anonymous');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: customers.doc(widget.documentId).get(),
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
              backgroundColor: Colors.grey.shade300,
              body: Stack(
                children: [
                  Container(
                    height: 236,
                    decoration: const BoxDecoration(
                      color: Color(0xfff39171),
                    ),
                  ),
                  CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        centerTitle: true,
                        pinned: true,
                        elevation: 0,
                        backgroundColor: Colors.black,
                        expandedHeight: 140,
                        flexibleSpace: LayoutBuilder(
                          builder: (context, constraints) {
                            return FlexibleSpaceBar(
                              title: AnimatedOpacity(
                                duration: const Duration(milliseconds: 200),
                                opacity:
                                    constraints.biggest.height <= 120 ? 1 : 0,
                                child: const Text(
                                  'Profile',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              background: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xfff39171),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 25, left: 30),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Colors.white,
                                        backgroundImage:
                                            NetworkImage(data['profileimage']),
                                        // backgroundImage: AssetImage(
                                        //     'images/Profile_images/Profile_image.jpeg'),
                                      ),
                                      SizedBox(
                                        width: 100,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left:0),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width*.40,
                                          child: Text(
                                            data['name'].toUpperCase(),
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 24,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                            softWrap: false,
                                            maxLines: 1,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: TextButton(
                                    child: SizedBox(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width *
                                          0.23,
                                      child: Center(
                                        child: Text(
                                          'Cart',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: TextButton(
                                    child: SizedBox(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width *
                                          0.23,
                                      child: Center(
                                        child: Text(
                                          'Orders',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: TextButton(
                                    child: SizedBox(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width *
                                          0.23,
                                      child: Center(
                                        child: Text(
                                          'Wishlist',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                  ),
                                )
                              ],
                            ),
                            Container(
                              color: Colors.grey.shade300,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 150,
                                    child: Image(
                                        width: double.infinity,
                                        image:
                                            AssetImage('images/Blur/blur.png')),
                                  ),
                                  const ProfileHeaderLabel(
                                    headerLabel: '  Account Info.  ',
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 260,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: Column(
                                        children: [
                                          RepeatedListTile(
                                              icon: Icons.email,
                                              subTitle: data['email'],
                                              title: 'Email Address'),
                                          const YellowDivider(),
                                          RepeatedListTile(
                                              icon: Icons.phone,
                                              subTitle: data['phone'],
                                              title: 'Phone No.'),
                                          const YellowDivider(),
                                          RepeatedListTile(
                                              icon: Icons.location_pin,
                                              subTitle: data['address'],
                                              title: 'Address'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const ProfileHeaderLabel(
                                      headerLabel: '  Account Settings  '),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 260,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: Column(
                                        children: [
                                          RepeatedListTile(
                                            title: 'Edit Profile',
                                            subTitle: '',
                                            icon: Icons.edit,
                                            onPressed: () {},
                                          ),
                                          const YellowDivider(),
                                          RepeatedListTile(
                                            title: 'Change Password',
                                            icon: Icons.lock,
                                            onPressed: () {},
                                          ),
                                          const YellowDivider(),
                                          RepeatedListTile(
                                            title: 'Log Out',
                                            icon: Icons.logout,
                                            onPressed: () async {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          CupertinoAlertDialog(
                                                            title: new Text(
                                                                "Logging Out"),
                                                            content: new Text(
                                                                "Are you sure you want to log out?"),
                                                            actions: <Widget>[
                                                              CupertinoDialogAction(
                                                                  isDefaultAction:
                                                                      true,
                                                                  child: Text(
                                                                      'Yes'),
                                                                  onPressed:
                                                                      () async {
                                                                    await FirebaseAuth
                                                                        .instance
                                                                        .signOut();
                                                                    Navigator.pop(
                                                                        context);
                                                                    Navigator.pushReplacementNamed(
                                                                        context,
                                                                        '/Welcome_screen');
                                                                  }),
                                                              CupertinoDialogAction(
                                                                child:
                                                                    Text('No'),
                                                                onPressed: (){
                                                                  Navigator.pop(context);
                                                                },
                                                              )
                                                            ],
                                                          ));
                                              // MyAlertDilaog.showMyDialog(
                                              //     context: context,
                                              //     title: 'Log Out',
                                              //     content:
                                              //     'Are you sure to log out ?',
                                              //     tabNo: () {
                                              //       Navigator.pop(context);
                                              //     },
                                              //     tabYes: () async {
                                              //       await FirebaseAuth.instance
                                              //           .signOut();
                                              //       Navigator.pop(context);
                                              //       Navigator
                                              //           .pushReplacementNamed(
                                              //           context,
                                              //           '/welcome_screen');
                                              //     });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
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

class AppbarBackButton {}

class YellowDivider extends StatelessWidget {
  const YellowDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Divider(
        color: Colors.black,
        thickness: 1,
      ),
    );
  }
}

class RepeatedListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final Function()? onPressed;

  const RepeatedListTile(
      {Key? key,
      required this.icon,
      this.onPressed,
      this.subTitle = '',
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subTitle),
        leading: Icon(icon),
      ),
    );
  }
}

class ProfileHeaderLabel extends StatelessWidget {
  final String headerLabel;

  const ProfileHeaderLabel({Key? key, required this.headerLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          Text(
            headerLabel,
            style: const TextStyle(
                color: Colors.grey, fontSize: 24, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
